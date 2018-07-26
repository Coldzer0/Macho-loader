{

 this unit contains all socks functions & structures declarations that we need .

 Copyright(c) 2018 Coldzer0 .
 contact : <Coldzer0 [at] protonmail.ch> .
 License: GPLv2 .
}

unit sockets;

{$mode delphi}
{$Hints OFF}
{$INLINE ON}
{$SMARTLINK ON}

interface

type
    sockaddr_in = packed record
      sin_len: UInt8;
      sin_family: UInt8;
      sin_port: UInt16;
      sin_addr: UInt32;
      sin_zero: packed array[0..7] of UInt8;
    end;
    psockaddr = ^sockaddr_in;

    hostent = record
      h_name: PChar;      {/* official name of host *}
      h_aliases: PPChar;  {* alias list *}
      h_addrtype: cInt;   {* host address type *}
      h_length: cInt;     {* length of address *}
      h_addr_list: PPChar;{* list of addresses from name server *}
    end;

    THostEnt = hostent;
    PHostEnt = ^THostEnt;



var
  socket  : function(domain:longint; xtype:longint; protocol: longint):longint;
  connect : function(s:longint; name  : psockaddr; namelen : longword):longint;
  gethostbyname : function(name: PChar): PHostEnt; cdecl;

function htonl( host : cardinal):cardinal; inline;
function htons( host : word):word; inline;

const
  AF_INET     = 2;
  SOCK_STREAM = 1;

implementation

function htonl( host : cardinal):cardinal; inline;
begin
{$ifdef FPC_BIG_ENDIAN}
  htonl:=host;
{$else}
  htonl:=SwapEndian(host);
{$endif}
end;

function htons( host : word):word; inline;

begin
{$ifdef FPC_BIG_ENDIAN}
  htons:=host;
{$else}
  htons:=SwapEndian(host);
{$endif}
end;

end.

