{
  Macho library - Just for test .

  Copyright(c) 2018 Coldzer0 .
  contact : <Coldzer0 [at] protonmail.ch> .
  License: GPLv2 .
}
library test;

{$mode Delphi}
{$OPTIMIZATION STACKFRAME}
{$SMARTLINK ON}

{$IFDEF Darwin}
    {$LINKLIB c}
{$ELSE}
    this_code_works_on_OSX_only
{$ENDIF} 

uses
  sysinit;

Function printf (Const fmt : PCHar; arg : Array Of Const) : size_t; cdecl; external;

function main() : boolean;
begin
 printf('that Do Evil stuff ^_^'#10,[]);
end;

exports
  main name '_main';

begin
 printf('im a good library :D'#10,[]); 
end.
