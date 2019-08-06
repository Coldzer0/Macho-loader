#!/bin/sh

# Build Script - by Coldzer0 .
# Skype : Coldzer01
# Release Build - "8 kb" samllest size i can get .

if [ ! -d "lib" ]; then
  mkdir lib
fi
rm -rf lib/*.ppu lib/*.o lib/*.s link.res ppas.sh

fpc -n -O3 -Os -OoDFA -OoREGVAR -OoREMOVEEMPTYPROCS -OoTAILREC -OoFASTMATH -OoLOOPUNROLL -g- -Xs -XX -CX -Scigm -Sd -Cg -Rintel -FuSystem/ -FUlib/ test.pas
# Generate asm files ..
fpc -n -O3 -Os -OoDFA -OoREGVAR -OoREMOVEEMPTYPROCS -OoTAILREC -OoFASTMATH -OoLOOPUNROLL -g- -Xs -XX -CX -Scigm -Sd -Cg -Rintel -a -s -FuCore/ -FuSystem/ -FUlib/ main.pas 
# remove FPC marker from code .
line=$(grep -nr .fpc, lib/main.s | cut -d : -f 2)
$(ex -sc "${line}d4|x" lib/main.s)
# run build script ..
./ppas.sh 

echo "clean"
rm -rf lib/*.ppu lib/*.o lib/*.s link.res ppas.sh # clean .
echo "strip"
strip main # strip the file .
echo "all done :D !"
