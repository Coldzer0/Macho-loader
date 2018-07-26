{
  Macho loader . < load macho from memory with socket connection >
  Copyright(c) 2018 Coldzer0 .
  contact : <Coldzer0 [at] protonmail.ch> .
  License: GPLv2 .
}
program main;

{$mode Delphi}
{$OPTIMIZATION STACKFRAME}
{$SMARTLINK ON}

{$IFDEF Darwin}
    {$LINKLIB c}
{$ELSE}
    this_code_works_on_OSX_only
{$ENDIF} 

uses
  sysinit,
  ulibc,
  loadfunctions;

begin
  loadall;
end.
