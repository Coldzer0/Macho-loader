unit system;


{.$I-,Q-,H-,R-,V-}
{$mode objfpc}
{$modeswitch advancedrecords}

{ At least 3.0.0 is required }
{$if defined(VER1) or defined(VER2_0) or defined(VER2_2) or defined(VER2_4) or defined(VER2_6) }
  {$fatal You need at least FPC 3.0.0 to build this version of FPC}
{$endif}

{ Using inlining for small system functions/wrappers }
{$inline on}
{$define SYSTEMINLINE}

{ don't use FPU registervariables on the i386 and i8086 }
{$if defined(CPUI386) or defined(CPUI8086)}
  {$maxfpuregisters 0}
{$endif CPUI386 or CPUI8086}

{ the assembler helpers need this}
{$ifdef CPUPOWERPC}
  {$goto+}
{$endif CPUPOWERPC}

{$ifdef CPUAVR}
  {$goto+}
{$endif CPUAVR}


{ needed for insert,delete,readln }
{$P+}
{ stack checking always disabled
  for system unit. This is because
  the startup code might not
  have been called yet when we
  get a stack error, this will
  cause big crashes
}
{$S-}

{$INLINE ON}
{$OPTIMIZATION STACKFRAME}
{$SMARTLINK ON}
{$asmmode GAS}
{$inline on}
{$Hints OFF}
{$define SYSTEMINLINE}

interface

type
  HResult = longint;
  pchar = ^char;
  PByte = ^byte;
  DWord    = LongWord;
  Cardinal = LongWord;
  Integer  = longint;
  UInt64   = QWord;
  THandle  = DWord;
{$ifdef CPU64}
  SizeInt = Int64;
  SizeUInt = QWord;
  PtrInt = Int64;
  PtrUInt = QWord;
  ValSInt = int64;
  ValUInt = qword;
  CodePointer = Pointer;
  CodePtrInt = PtrInt;
  CodePtrUInt = PtrUInt;

{$endif CPU64}

{$ifdef CPU32}
  SizeInt = Longint;
  SizeUInt = DWord;
  PtrInt = Longint;
  PtrUInt = DWord;
  ValSInt = Longint;
  ValUInt = Cardinal;
  CodePointer = Pointer;
  CodePtrInt = PtrInt;
  CodePtrUInt = PtrUInt;
{$endif CPU32} 


{
    This file is part of the Free Pascal run time library.
    Copyright (c) 2001 by Free Pascal development team

    Basic types for C interfacing. Check the 64-bit defines.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{***********************************************************************}
{                       POSIX TYPE DEFINITIONS                          }
{***********************************************************************}


  { the following type definitions are compiler dependant }
  { and system dependant                                  }

  cint8                  = shortint;           pcint8                 = ^cint8;
  cuint8                 = byte;               pcuint8                = ^cuint8;
  cchar                  = cint8;              pcchar                 = ^cchar;
  cschar                 = cint8;              pcschar                = ^cschar;
  cuchar                 = cuint8;             pcuchar                = ^cuchar;

  cint16                 = smallint;           pcint16                = ^cint16;
  cuint16                = word;               pcuint16               = ^cuint16;
  cshort                 = cint16;             pcshort                = ^cshort;
  csshort                = cint16;             pcsshort               = ^csshort;
  cushort                = cuint16;            pcushort               = ^cushort;

  cint32                 = longint;            pcint32                = ^cint32;
  cuint32                = longword;           pcuint32               = ^cuint32;
  cint                   = cint32;             pcint                  = ^cint;              { minimum range is : 32-bit    }
  csint                  = cint32;             pcsint                 = ^csint;             { minimum range is : 32-bit    }
  cuint                  = cuint32;            pcuint                 = ^cuint;             { minimum range is : 32-bit    }
  csigned                = cint;               pcsigned               = ^csigned;
  cunsigned              = cuint;              pcunsigned             = ^cunsigned;

  cint64                 = int64;              pcint64                = ^cint64;
  cuint64                = qword;              pcuint64               = ^cuint64;
  clonglong              = cint64;             pclonglong             = ^clonglong;
  cslonglong             = cint64;             pcslonglong            = ^cslonglong;
  culonglong             = cuint64;            pculonglong            = ^culonglong;

  cbool                  = longbool;           pcbool                 = ^cbool;

{$ifdef cpu64}
  clong                  = int64;              pclong                 = ^clong;
  cslong                 = int64;              pcslong                = ^cslong;
  culong                 = qword;              pculong                = ^culong;
{$else}
  clong                  = longint;            pclong                 = ^clong;
  cslong                 = longint;            pcslong                = ^cslong;
  culong                 = cardinal;           pculong                = ^culong;
{$endif}

{$ifndef FPUNONE}
  cfloat                 = single;             pcfloat                = ^cfloat;
  cdouble                = double;             pcdouble               = ^cdouble;
  clongdouble            = extended;           pclongdouble           = ^clongdouble;
{$endif}


    SInt8 = ShortInt;
    UInt8 = Byte;
    SInt16 = Integer;
    UInt16 = Word;
    SInt32 = LongInt;
    SInt64 = Int64;


    { the following type definitions are compiler dependant }
    { and system dependant                                  }

    dev_t    = cuint32;         { used for device numbers      }
    TDev     = dev_t;
    pDev     = ^dev_t;

    gid_t    = cuint32;         { used for group IDs           }
    TGid     = gid_t;
    pGid     = ^gid_t;
    TIOCtlRequest = cuLong;

{$if not defined(cpuarm) and not defined(aarch64) and not defined(iphonesim)}
    ino_t    = cuint32;         { used for file serial numbers }
{$else}
    ino_t    = cuint64;
{$endif}
    TIno     = ino_t;
    pIno     = ^ino_t;

    mode_t   = cuint16;         { used for file attributes     }
    TMode    = mode_t;
    pMode    = ^mode_t;

    nlink_t  = cuint16;         { used for link counts         }
    TnLink   = nlink_t;
    pnLink   = ^nlink_t;

    off_t    = cint64;          { used for file sizes          }
    TOff     = off_t;
    pOff     = ^off_t;

    pid_t    = cint32;          { used as process identifier   }
    TPid     = pid_t;
    pPid     = ^pid_t;

    size_t   = culong;          { as definied in the C standard}
    TSize    = size_t;
    pSize    = ^size_t;
    psize_t  = ^size_t;

    ssize_t  = clong;           { used by function for returning number of bytes }
    TsSize   = ssize_t;
    psSize   = ^ssize_t;

    uid_t    = cuint32;         { used for user ID type        }
    TUid     = Uid_t;
    pUid     = ^Uid_t;

    clock_t  = culong;
    TClock   = clock_t;
    pClock   = ^clock_t;

    time_t   = clong;           { used for returning the time  }
    // TTime    = time_t;    // Not allowed in system unit, -> unixtype

    pTime    = ^time_t;
    ptime_t  = ^time_t;

    wchar_t  = cint32;
    pwchar_t = ^wchar_t;
    wint_t   = cint32;

    socklen_t= cuint32;
    TSocklen = socklen_t;
    pSocklen = ^socklen_t;

    suseconds_t = cint32;


  csize_t                = size_t;      pcsize_t               = psize_t;



// csize_t is defined in the operatingsystem dependant ptypes.inc
// csize_t               = ptruint;            pcsize_t               = pptruint;

{ Zero - terminated strings }
PPChar              = ^PChar;
PPPChar             = ^PPChar;


TAnsiChar           = Char;
AnsiChar            = Char;
PAnsiChar           = PChar;
PPAnsiChar          = PPChar;
PPPAnsiChar         = PPPChar;

PWideChar           = ^WideChar;
PPWideChar          = ^PWideChar;
PPPWideChar         = ^PPWideChar;

PDWord              = ^DWord;
PLongWord           = ^LongWord; 
PShortString        = ^ShortString;
PAnsiString         = ^AnsiString; 
PInteger            = ^Integer;
PExtended           = ^Extended;
PCurrency           = ^Currency;
PVariant            = ^Variant;
PInt64              = ^Int64;
PQWord              = ^QWord;
TSystemCodePage     = Word;


  __off_t = longint;

const
  CP_NONE    = $FFFF;

Const 
  O_ACCMODE  = &00003;
  O_RDONLY   = &00000;
  O_WRONLY   = &00001;
  O_RDWR     = &00002;
  O_CREAT    = &00100;
  O_EXCL     = &00200;
  O_NOCTTY   = &00400;
  O_TRUNC    = &01000;
  O_APPEND   = &02000;
  O_NONBLOCK = &04000;
  O_NDELAY   = O_NONBLOCK;
  O_SYNC     = &010000;
  O_FSYNC    = O_SYNC;
  O_ASYNC    = &020000;

  O_DIRECT    = &0040000;
  O_DIRECTORY = &0200000;
  O_NOFOLLOW  = &0400000;

  O_DSYNC = O_SYNC;
  O_RSYNC = O_SYNC;

  O_LARGEFILE = &0100000;

  F_DUPFD   = 0;
  F_GETFD   = 1;
  F_SETFD   = 2;
  F_GETFL   = 3;
  F_SETFL   = 4;

  F_GETLK   = 5;
  F_SETLK   = 6;
  F_SETLKW  = 7;

  F_GETLK64  = 12;
  F_SETLK64  = 13;
  F_SETLKW64 = 14;

  F_SETOWN = 8;
  F_GETOWN = 9;

  F_SETSIG = 10;
  F_GETSIG = 11;

  F_SETLEASE = 1024;
  F_GETLEASE = 1025;
  F_NOTIFY = 1026;

  FD_CLOEXEC = 1;
  F_RDLCK = 0;
  F_WRLCK = 1;
  F_UNLCK = 2;
  F_EXLCK = 4;
  F_SHLCK = 8;

  LOCK_SH = 1;
  LOCK_EX = 2;
  LOCK_NB = 4;
  LOCK_UN = 8;

  LOCK_MAND = 32;
  LOCK_READ = 64;
  LOCK_WRITE = 128;
  LOCK_RW = 192;

  DN_ACCESS = $00000001;
  DN_MODIFY = $00000002;
  DN_CREATE = $00000004;
  DN_DELETE = $00000008;
  DN_RENAME = $00000010;
  DN_ATTRIB = $00000020;
  DN_MULTISHOT = $80000000;

  SEEK_SET = 0;
  SEEK_CUR = 1;
  SEEK_END = 2;

  PROT_READ     =  $1;          { page can be read }
  PROT_WRITE    =  $2;          { page can be written }
  PROT_EXEC     =  $4;          { page can be executed }
  PROT_NONE     =  $0;          { page can not be accessed }

  MAP_FAILED    = pointer(-1);  { mmap() has failed }
  MAP_SHARED    =  $1;          { Share changes }
  MAP_PRIVATE   =  $2;          { Changes are private }
  MAP_TYPE      =  $f;          { Mask for type of mapping }
  MAP_FIXED     = $10;          { Interpret addr exactly }

  MAP_ANONYMOUS =$1000;
  MAP_ANON	= MAP_ANONYMOUS;

Const 
  FAPPEND = O_APPEND;
  FFSYNC = O_FSYNC;
  FASYNC = O_ASYNC;
  FNONBLOCK = O_NONBLOCK;
  FNDELAY = O_NDELAY;

  POSIX_FADV_NORMAL = 0;
  POSIX_FADV_RANDOM = 1;
  POSIX_FADV_SEQUENTIAL = 2;
  POSIX_FADV_WILLNEED = 3;
  POSIX_FADV_DONTNEED = 4;
  POSIX_FADV_NOREUSE = 5;


Type 

TTYPEKIND = Record
end;

  jmp_buf = packed Record
    rbx,rbp,r12,r13,r14,r15,rsp,rip : qword;
{$ifdef CPU64}
    rsi,rdi : qword;
    xmm6,xmm7,xmm8,xmm9,xmm10,xmm11,xmm12,xmm13,xmm14,xmm15: Record
      m1,m2: qword;
    End;
    mxcsr: longword;
    fpucw: word;
    padding: word;
{$endif CPU64}
  End;
  pjmp_buf = ^jmp_buf;



PGuid = ^TGuid;
TGuid = packed Record
  Case integer Of 
    1 : (
         Data1 : DWord;
         Data2 : word;
         Data3 : word;
         Data4 : Array[0..7] Of byte;
        );
    2 : (
         D1 : DWord;
         D2 : word;
         D3 : word;
         D4 : Array[0..7] Of byte;
        );
    3 : ( { uuid fields according to RFC4122 }
         time_low : dword;   // The low field of the timestamp
         time_mid : word;
         // The middle field of the timestamp
         time_hi_and_version : word;
         // The high field of the timestamp multiplexed with the version number
         clock_seq_hi_and_reserved : byte;
         // The high field of the clock sequence multiplexed with the variant
         clock_seq_low : byte;
         // The low field of the clock sequence
         node : Array[0..5] Of byte;
         // The spatially unique node identifier
        );
End;


PExceptAddr = ^TExceptAddr;
  TExceptAddr = Record

  End;


TMsgStrTable = Record
  name   : pshortstring;
  method : codepointer;
End;

TStringMessageTable = Record
  count : longint;
  msgstrtable : array[0..0] Of tmsgstrtable;
End;

pstringmessagetable = ^tstringmessagetable;


pinterfacetable = ^tinterfacetable;
tinterfacetable = Record
end;

PVmt = ^TVmt;
PPVmt = ^PVmt;
TVmt = Record
  vInstanceSize: SizeInt;
  vInstanceSize2: SizeInt;
  vParentRef: {$ifdef VER3_0}PVmt{$else}PPVmt{$endif};
  vClassName: PShortString;
  vDynamicTable: Pointer;
  vMethodTable: Pointer;
  vFieldTable: Pointer;
  vTypeInfo: Pointer;
  vInitTable: Pointer;
  vAutoTable: Pointer;
  vIntfTable: PInterfaceTable;
  vMsgStrPtr: pstringmessagetable;
  vDestroy: CodePointer;
  vNewInstance: CodePointer;
  vFreeInstance: CodePointer;
  vSafeCallException: CodePointer;
  vDefaultHandler: CodePointer;
  vAfterConstruction: CodePointer;
  vBeforeDestruction: CodePointer;
  vDefaultHandlerStr: CodePointer;
  vDispatch: CodePointer;
  vDispatchStr: CodePointer;
  vEquals: CodePointer;
  vGetHashCode: CodePointer;
  vToString: CodePointer;
  Private 
    Function GetvParent: PVmt; inline;
  Public 
    property vParent: PVmt read GetvParent;
End;


Type 
TObject = class End;


type
TClass  = class of TObject;
PClass  = ^tclass; 
Int32   = Longint;  
UInt32  = Longword;  
RawByteString       = type AnsiString(CP_NONE);



Const 
  vtInteger       = 0;
  vtBoolean       = 1;
  vtChar          = 2;
{$ifndef FPUNONE}
  vtExtended      = 3;
{$endif}
  vtString        = 4;
  vtPointer       = 5;
  vtPChar         = 6;
  vtObject        = 7;
  vtClass         = 8;
  vtWideChar      = 9;
  vtPWideChar     = 10;
  vtAnsiString    = 11;
  vtCurrency      = 12;
  vtVariant       = 13;
  vtInterface     = 14;
  vtWideString    = 15;
  vtInt64         = 16;
  vtQWord         = 17;
  vtUnicodeString = 18;

const
  maxLongint  = $7fffffff;

Type 
  PVarRec = ^TVarRec;
  TVarRec = Record
    Case VType : sizeint Of 
{$ifdef ENDIAN_BIG}
      vtInteger       : ({$IFDEF CPU64}integerdummy1 : Longint;{$ENDIF CPU64}
                         VInteger: Longint);
      vtBoolean       : ({$IFDEF CPU64}booldummy : Longint;{$ENDIF CPU64}
                         booldummy1,booldummy2,booldummy3: byte; VBoolean:
                         Boolean);
      vtChar          : ({$IFDEF CPU64}chardummy : Longint;{$ENDIF CPU64}
                         chardummy1,chardummy2,chardummy3: byte; VChar: Char);
      vtWideChar      : ({$IFDEF CPU64}widechardummy : Longint;{$ENDIF CPU64}
                         wchardummy1,VWideChar: WideChar);
{$else ENDIAN_BIG}
      vtInteger       : (VInteger: Longint);
      vtBoolean       : (VBoolean: Boolean);
      vtChar          : (VChar: Char);
      vtWideChar      : (VWideChar: WideChar);
{$endif ENDIAN_BIG}
{$ifndef FPUNONE}
      vtExtended      : (VExtended: PExtended);
{$endif}
      vtString        : (VString: PShortString);
      vtPointer       : (VPointer: Pointer);
      vtPChar         : (VPChar: PAnsiChar);
      vtObject        : (VObject: TObject);
      vtClass         : (VClass: TClass);
      vtPWideChar     : (VPWideChar: PWideChar);
      vtAnsiString    : (VAnsiString: Pointer);
      vtCurrency      : (VCurrency: PCurrency);
      vtVariant       : (VVariant: PVariant);
      vtInterface     : (VInterface: Pointer);
      vtWideString    : (VWideString: Pointer);
      vtInt64         : (VInt64: PInt64);
      vtUnicodeString : (VUnicodeString: Pointer);
      vtQWord         : (VQWord: PQWord);
  End;

const
{$ifdef CPUAVR}
  filerecnamelength = 15;
{$else CPUAVR}
  filerecnamelength = 255;
{$endif CPUAVR}
type


  UnicodeChar         = WideChar;
  PUnicodeChar        = ^UnicodeChar;
  PUnicodeString      = ^UnicodeString;

  TFileTextRecChar    = {$if defined(FPC_ANSI_TEXTFILEREC) or not(defined(FPC_HAS_FEATURE_WIDESTRINGS))}AnsiChar{$else}UnicodeChar{$endif};
  PFileTextRecChar    = ^TFileTextRecChar;
 { using packed makes the compiler to generate ugly code on some CPUs, further
    using packed causes the compiler to handle arrays of text wrongly, see  see tw0754 e.g. on arm  }
  FileRec = {$ifdef VER2_6} packed {$endif} Record
    Handle    : THandle;
{$if defined(CPU8) or defined(CPU16)}
    Mode      : Word;
{$else}
    Mode      : longint;
{$endif}
    RecSize   : SizeInt;
    _private  : array[1..3 * SizeOf(SizeInt) + 5 * SizeOf (pointer)] of byte;
    UserData  : array[1..32] of byte;
    name      : array[0..filerecnamelength] of TFileTextRecChar;
  End;
  TFileRec=FileRec;

const
{$ifdef CPUAVR}
  TextRecNameLength = 16;
  TextRecBufSize    = 16;
{$else CPUAVR}
  TextRecNameLength = 256;
  TextRecBufSize    = 256;
{$endif CPUAVR}
type
  TLineEndStr = string [3];
  TextBuf = array[0..TextRecBufSize-1] of ansichar;
  TTextBuf = TextBuf;

  { using packed makes the compiler to generate ugly code on some CPUs, further
    using packed causes the compiler to handle arrays of text wrongly, see  see tw0754 e.g. on arm  }
  TextRec = {$ifdef VER2_6} packed {$endif} Record
    Handle    : THandle;
{$if defined(CPU8) or defined(CPU16)}
    Mode      : Word;
{$else}
    Mode      : longint;
{$endif}
    bufsize   : SizeInt;
    _private  : SizeInt;
    bufpos,
    bufend    : SizeInt;
    bufptr    : ^textbuf;
    openfunc,
    inoutfunc,
    flushfunc,
    closefunc : codepointer;
    UserData  : array[1..32] of byte;
    name      : array[0..textrecnamelength-1] of TFileTextRecChar;
    LineEnd   : TLineEndStr;
    buffer    : textbuf;
{$ifdef FPC_HAS_CPSTRING}
    CodePage  : TSystemCodePage;
{$endif}
  End;

  TTextRec=TextRec;

{$if defined(VER2) or defined(VER3_0)}
{$if defined(CPU16)}
{$define CPUINT16}
{$elseif defined(CPU32)}
{$define CPUINT32}
{$elseif defined(CPU64)}
{$define CPUINT64}
{$endif defined(CPU64)}
{$endif defined(VER2) or defined(VER3_0)}

{$if defined(CPUINT8)}
  ALUSInt = ShortInt;
  ALUUInt = Byte;
{$elseif defined(CPUINT16)}
  ALUSInt = SmallInt;
  ALUUInt = Word;
{$elseif defined(CPUINT32)}
  ALUSInt = Longint;
  ALUUInt = DWord;
{$elseif defined(CPUINT64)}
  ALUSInt = Int64;
  ALUUInt = QWord;
{$endif defined(CPUINT64)} 

PPtrUInt            = ^PtrUInt;


procedure FPC_INITIALIZEUNITS; compilerproc;
procedure FPC_LIBINITIALIZEUNITS(); compilerproc;

procedure FPC_DO_EXIT; compilerproc;

procedure _exit();assembler;

procedure fpc_fillmem(out data;len:sizeuint;b : byte);compilerproc;

// procedure Move(const source;var dest;count:SizeInt);

procedure FillByte (var x;count : {$ifdef FILLCHAR_HAS_SIZEUINT_COUNT}SizeUInt{$else}SizeInt{$endif};value : byte );

function SwapEndian(const AValue: Word): Word;{$ifdef SYSTEMINLINE}inline;{$endif}overload;
function SwapEndian(const AValue: DWord): DWord;{$ifdef SYSTEMINLINE}inline;{$endif}overload;

implementation


Function TVmt.GetvParent: PVmt;
Begin
  GetvParent := Nil;
End;

{$ifndef cpujvm}
function align(addr : Pointer;alignment : PtrUInt) : Pointer;{$ifdef SYSTEMINLINE}inline;{$endif}
  var
    tmp: PtrUInt;
  begin
    tmp:=PtrUInt(addr)+(alignment-1);
    result:=pointer(tmp-(tmp mod alignment));
  end;
{$endif}

{$ifndef FPC_SYSTEM_HAS_FILLCHAR}
Procedure FillChar(Var x;count:SizeInt;value:byte);

Var 
  pdest,pend : pbyte;
  v : ALUUInt;
Begin
  If count <= 0 Then
    exit;
  pdest := @x;
  If Count>4*sizeof(ptruint)-1 Then
    Begin
{$if sizeof(v)>=2}
      v := (value shl 8) Or value;
{$endif sizeof(v)>=2}
{$if sizeof(v)>=4}
      v := (v shl 16) Or v;
{$endif sizeof(v)>=4}
{$if sizeof(v)=8}
      v := (v shl 32) Or v;
{$endif sizeof(v)=8}
      { Align on native pointer size }
      pend := pbyte(align(pdest,sizeof(PtrUInt)));
      dec(count,pend-pdest);
      While pdest<pend Do
        Begin
          pdest^ := value;
          inc(pdest);
        End;
      { use sizeuint typecast to force shr optimization }
      pptruint(pend) := pptruint(pdest)+(sizeuint(count) Div sizeof(ptruint));
      While pdest<pend Do
        Begin
          pptruint(pdest)^ := v;
          inc(pptruint(pdest));
        End;
      count := count And (sizeof(ptruint)-1);
    End;
  pend := pdest+count;
  While pdest<pend Do
    Begin
      pdest^ := value;
      inc(pdest);
    End;
End;
{$endif FPC_SYSTEM_HAS_FILLCHAR}


function SwapEndian(const AValue: Word): Word;{$ifdef SYSTEMINLINE}inline;{$endif} overload;
begin
  Result := Word((AValue shr 8) or (AValue shl 8));
end;

function SwapEndian(const AValue: DWord): DWord;{$ifdef SYSTEMINLINE}inline;{$endif}overload;
begin
  Result := ((AValue shl 8) and $FF00FF00) or ((AValue shr 8) and $00FF00FF);
  Result := (Result shl 16) or (Result shr 16);
end;


procedure FillByte (var x;count : {$ifdef FILLCHAR_HAS_SIZEUINT_COUNT}SizeUInt{$else}SizeInt{$endif};value : byte );
begin
  FillChar(X,Count,VALUE);
end;

procedure fpc_fillmem(out data;len:sizeuint;b : byte);//inline;compilerproc;
begin
  FillByte(data,len,b);
end;

procedure _exit();[public, alias: '_exit'];assembler;nostackframe;
asm
{$IFDEF CPU64}
  mov $0,%rdi
  mov $0x2000001,%rax
  syscall
{$ENDIF}
end;

procedure FPC_INITIALIZEUNITS; assembler; nostackframe; [public, alias: 'FPC_INITIALIZEUNITS']; compilerproc;
asm
end;
procedure FPC_LIBINITIALIZEUNITS; assembler; nostackframe; [public, alias: 'FPC_LIBINITIALIZEUNITS']; compilerproc;
asm
end;

procedure PASCALMAIN; external name '_PASCALMAIN';

procedure Entry; assembler; nostackframe; [public, alias: '_FPC_SYSTEMMAIN'];
asm
 JMP PASCALMAIN;
end;

procedure LibEntry; assembler; nostackframe; [public, alias: '_FPC_LIBMAIN'];
asm
 JMP PASCALMAIN;
end;


procedure FPC_EMPTYINTF;assembler; nostackframe;  [public, alias: 'FPC_EMPTYINTF'];
asm
end;


procedure FPC_LIB_EXIT; [public, alias: 'FPC_LIB_EXIT']; compilerproc;
begin
  _exit();
end;

procedure FPC_DO_EXIT; [public, alias: 'FPC_DO_EXIT']; compilerproc;
begin
  _exit();
end;


end.
