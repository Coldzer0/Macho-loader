# Macho loader - Mac OS x64

### this code work with mini FPC core librarys `<Bare Bones>` for `Mac OS` <br> the generated files `main & libtest.dylib` is `8kb` only .


## `< load macho from memory with socket connection >`

The macho loader requires access to some system functions <br>
(e.g., `NSCreateObjectFileImageFromMemory`, `NSLinkModule`)

<h3>
that are provided by libdyld.dylib. As we don't know the address of libdyld.dylib in memory .

- we first walk to the very top of the stack. 

- We then start walking downwards on the stack and we inspect <br> every pointer we find. 
- The trick is that the offset inside of libdyld.dylib must be <br> present as it's placed there by the dynamic linker as the <br> return function when main returns. 
- We find the offset, we resolve the functions and from then on, <br> it's standard loading of macho bundle .

### the main logic start at `"Core/loadfunctions.pas"` in `loadall()` .

### this works only with x64 macho files .

## Requirements
- FreePascal Compiler >= v3
- Mac OS <img src="https://static.xx.fbcdn.net/images/emoji.php/v9/e72/2/16/PACMAN.png" width="20">
- nodejs >> for the server.js - or make your own :P 

## How to Build

- Just run `./Build.sh` after installing FreePascal
- run `node server.js`
- run `./main`

## that's all - see you soon guys <img src="https://static.xx.fbcdn.net/images/emoji.php/v9/e72/2/16/PACMAN.png" width="20">
## Oh Contact : <`Coldzer0 [at] protonmail.ch`>
