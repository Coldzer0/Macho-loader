{

 this unit contains all libc functions & structures declarations that we need .

 Copyright(c) 2018 Coldzer0 .
 contact : <Coldzer0 [at] protonmail.ch> .
 License: GPLv2 .
}
Unit ulibc;

{$mode Delphi}{$H+}
{$inline on}
{$SMARTLINK ON}
{$packrecords c}

Interface
type
  liblongint=longint;
  pliblongint=^liblongint;

  timespec = record
    tv_sec   : int64;
    tv_nsec  : int64;
  end;
  ptimespec= ^timespec;
  Ttimespec= timespec;

  //Function  printf(Const fmt : PCHar; arg : Array Of Const) : size_t; cdecl; external;

var
  {==================== Memory Mangment ================================}
  //Function malloc (Size : ptruint) : Pointer;cdecl; external;
  //Procedure free (P : pointer); cdecl; external;
  //function realloc (P : Pointer; Size : ptruint) : pointer;cdecl; external;
  //Function calloc (unitSize,UnitCount : ptruint) : pointer;cdecl; external;
  mmap : function (addr:pointer;len:qword;prot:longint;flags:longint;fd:longint;ofs:int64):pointer; cdecl;// external;
{=====================================================================}
  errno  : function : pliblongint;
  nanosleep : function (const rqtp: ptimespec; rmtp: ptimespec): longint;cdecl;//external;// clib name 'nanosleep';
  //sleep : function (seconds : cuint): cuint;// cdecl;
{=====================================================================}

//Function strlen (P : pchar) : size_t; cdecl; // external;

{=====================================================================}
  open  : function (path: pchar; flags : longint):longint; varargs; cdecl;
  lseek : function (fd: longint; offset: longint; whence: longint): longint; cdecl;// external;
  read  : function (fd: longint; buf: Pointer; nbytes : qword): int64; cdecl; //external;
  close : function (fd : longint): longint; cdecl;// external;
  //write : function (fd: longint;buf:pchar; nbytes : TSize): TSSize; cdecl; // external;
{=====================================================================}
//function dlsym (module : Pointer; name : PChar): Pointer; cdecl;external;
//Function chmod(path : pChar; Mode : TMode): longint; cdecl; external;

Implementation



End.
