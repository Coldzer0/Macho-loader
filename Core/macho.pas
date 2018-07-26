
Unit macho;

{
   * Copyright (c) 1999-2008 Apple Inc.  All Rights Reserved.
   *
   * @APPLE_LICENSE_HEADER_START@
   *
   * This file contains Original Code and/or Modifications of Original Code
   * as defined in and that are subject to the Apple Public Source License
   * Version 2.0 (the 'License'). You may not use this file except in
   * compliance with the License. Please obtain a copy of the License at
   * http://www.opensource.apple.com/apsl/ and read it before using this
   * file.
   *
   * The Original Code and all software distributed under the License are
   * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
   * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
   * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
   * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
   * Please see the License for the specific language governing rights and
   * limitations under the License.
   *
   * @APPLE_LICENSE_HEADER_END@
    }

{ converted by Dmitry Boyarintsev 2009 }

{$mode objfpc}{$H+}
{$SMARTLINK ON}
Interface

{$IFDEF FPC}
{$PACKRECORDS C}
{$PACKENUM 4}
{$ENDIF}


// mach/$arch/machine.h
// $arch can be: i386, x86_64, ppc, arm
// currently used is i386

Type 
  integer_t = Integer;
  uint8_t   = Byte;

  int16_t   = SmallInt;
  uint16_t  = Word;

  uint32_t  = LongWord;
  int32_t   = Integer;

  uint64_t  = QWord;

  // mach/thread_status.h

{$ifdef i386}

{$endif i386}

  // mach/machine.h

Type 
  cpu_type_t       = integer_t;
  cpu_subtype_t    = integer_t;
  cpu_threadtype_t = integer_t;

Const 
  CPU_STATE_MAX  = 4;

  CPU_STATE_USER  = 0;
  CPU_STATE_SYSTEM = 1;
  CPU_STATE_IDLE  = 2;
  CPU_STATE_NICE  = 3;

  {* Capability bits used in the definition of cpu_type. }
  CPU_ARCH_MASK   = $ff000000; { mask for architecture bits }
  CPU_ARCH_ABI64 = $01000000; { 64 bit ABI }

  {	Machine types known by all. }

  CPU_TYPE_ANY    = -1;
  CPU_TYPE_VAX    = 1;
  CPU_TYPE_MC680x0 = 6;
  CPU_TYPE_X86    = 7;
  CPU_TYPE_I386    = CPU_TYPE_X86;  { compatibility }
  CPU_TYPE_X86_64   = CPU_TYPE_X86 or CPU_ARCH_ABI64;
  // skip CPU_TYPE_MIPS		= 8;
  CPU_TYPE_MC98000 = 10;
  CPU_TYPE_HPPA     = 11;
  CPU_TYPE_ARM    = 12;
  CPU_TYPE_ARM64          = CPU_TYPE_ARM or CPU_ARCH_ABI64;
  CPU_TYPE_MC88000 = 13;
  CPU_TYPE_SPARC  = 14;
  CPU_TYPE_I860    = 15;
  // skip	CPU_TYPE_ALPHA		= 16;	*/

  CPU_TYPE_POWERPC   = 18;
  CPU_TYPE_POWERPC64 = CPU_TYPE_POWERPC or CPU_ARCH_ABI64;


{*
 *	Machine subtypes (these are defined here, instead of in a machine
 *	dependent directory, so that any program can get all definitions
 *	regardless of where is it compiled).
 *}

{*
 * Capability bits used in the definition of cpu_subtype.
 *}
  CPU_SUBTYPE_MASK  = $ff000000; { mask for feature flags }
  CPU_SUBTYPE_LIB64 = $80000000; { 64 bit libraries }



{*
 *	Object files that are hand-crafted to run on any
 *	implementation of an architecture are tagged with
 *	CPU_SUBTYPE_MULTIPLE.  This functions essentially the same as
 *	the "ALL" subtype of an architecture except that it allows us
 *	to easily find object files that may need to be modified
 *	whenever a new implementation of an architecture comes out.
 *
 *	It is the responsibility of the implementor to make sure the
 *	software handles unsupported implementations elegantly.
 *}
  CPU_SUBTYPE_MULTIPLE    = -1;
  CPU_SUBTYPE_LITTLE_ENDIAN = 0;
  CPU_SUBTYPE_BIG_ENDIAN  = 1;


{*
 *     Machine threadtypes.
 *     This is none - not defined - for most machine types/subtypes.
 *}
  CPU_THREADTYPE_NONE = 0;


{*
 *	VAX subtypes (these do *not* necessary conform to the actual cpu
 *	ID assigned by DEC available via the SID register).
 *}

  CPU_SUBTYPE_VAX_ALL = 0;
  CPU_SUBTYPE_VAX780 = 1;
  CPU_SUBTYPE_VAX785 = 2;
  CPU_SUBTYPE_VAX750 = 3;
  CPU_SUBTYPE_VAX730 = 4;
  CPU_SUBTYPE_UVAXI   = 5;
  CPU_SUBTYPE_UVAXII = 6;
  CPU_SUBTYPE_VAX8200 = 7;
  CPU_SUBTYPE_VAX8500 = 8;
  CPU_SUBTYPE_VAX8600 = 9;
  CPU_SUBTYPE_VAX8650 = 10;
  CPU_SUBTYPE_VAX8800 = 11;
  CPU_SUBTYPE_UVAXIII = 12;


{*
 * 	680x0 subtypes
 *
 * The subtype definitions here are unusual for historical reasons.
 * NeXT used to consider 68030 code as generic 68000 code.  For
 * backwards compatability:
 * 
 *	CPU_SUBTYPE_MC68030 symbol has been preserved for source code
 *	compatability.
 *
 *	CPU_SUBTYPE_MC680x0_ALL has been defined to be the same
 *	subtype as CPU_SUBTYPE_MC68030 for binary comatability.
 *
 *	CPU_SUBTYPE_MC68030_ONLY has been added to allow new object
 *	files to be tagged as containing 68030-specific instructions.
 *}

  CPU_SUBTYPE_MC680x0_ALL  = 1;
  CPU_SUBTYPE_MC68030     = 1; { compat }
  CPU_SUBTYPE_MC68040     = 2;
  CPU_SUBTYPE_MC68030_ONLY = 3;

  {* I386 subtypes *}

  CPU_SUBTYPE_I386_ALL      =  3 + (0 shl 4);
  CPU_SUBTYPE_386         =  3 + (0 shl 4);
  CPU_SUBTYPE_486         =  4 + (0 shl 4);
  CPU_SUBTYPE_486SX        =  4 + (8 shl 4);
  // 8 << 4 = 128
  CPU_SUBTYPE_586         =  5 + (0 shl 4);
  CPU_SUBTYPE_PENT          =  5 + (0 shl 4);
  CPU_SUBTYPE_PENTPRO        =  6 + (1 shl 4);
  CPU_SUBTYPE_PENTII_M3      =  6 + (3 shl 4);
  CPU_SUBTYPE_PENTII_M5      =  6 + (5 shl 4);
  CPU_SUBTYPE_CELERON     =  7 + (6 shl 4);
  CPU_SUBTYPE_CELERON_MOBILE =  7 + (7 shl 4);
  CPU_SUBTYPE_PENTIUM_3    =  8 + (0 shl 4);
  CPU_SUBTYPE_PENTIUM_3_M   =  8 + (1 shl 4);
  CPU_SUBTYPE_PENTIUM_3_XEON =  8 + (2 shl 4);
  CPU_SUBTYPE_PENTIUM_M    =  9 + (0 shl 4);
  CPU_SUBTYPE_PENTIUM_4    = 10 + (0 shl 4);
  CPU_SUBTYPE_PENTIUM_4_M   = 10 + (1 shl 4);
  CPU_SUBTYPE_ITANIUM     = 11 + (0 shl 4);
  CPU_SUBTYPE_ITANIUM_2     = 11 + (1 shl 4);
  CPU_SUBTYPE_XEON       = 12 + (0 shl 4);
  CPU_SUBTYPE_XEON_MP      = 12 + (1 shl 4);

  CPU_SUBTYPE_INTEL_FAMILY_MAX =  15;
  CPU_SUBTYPE_INTEL_MODEL_ALL = 0;

  {* X86 subtypes. *}

  CPU_SUBTYPE_X86_ALL   = 3;
  CPU_SUBTYPE_X86_64_ALL = 3;
  CPU_SUBTYPE_X86_ARCH1  = 4;


  CPU_THREADTYPE_INTEL_HTT = 1;

  {*	Mips subtypes. *}

  CPU_SUBTYPE_MIPS_ALL   = 0;
  CPU_SUBTYPE_MIPS_R2300 = 1;
  CPU_SUBTYPE_MIPS_R2600 = 2;
  CPU_SUBTYPE_MIPS_R2800 = 3;
  CPU_SUBTYPE_MIPS_R2000a = 4; {* pmax *}
  CPU_SUBTYPE_MIPS_R2000 = 5;
  CPU_SUBTYPE_MIPS_R3000a = 6; { 3max *}
  CPU_SUBTYPE_MIPS_R3000 = 7;

  {* MC98000 (PowerPC) subtypes *}
  CPU_SUBTYPE_MC98000_ALL = 0;
  CPU_SUBTYPE_MC98601     = 1;


{*
 *	HPPA subtypes for Hewlett-Packard HP-PA family of
 *	risc processors. Port by NeXT to 700 series. 
 *}

  CPU_SUBTYPE_HPPA_ALL  = 0;
  CPU_SUBTYPE_HPPA_7100  = 0; {* compat *}
  CPU_SUBTYPE_HPPA_7100LC = 1;

  {* MC88000 subtypes. *}

  CPU_SUBTYPE_MC88000_ALL = 0;
  CPU_SUBTYPE_MC88100     = 1;
  CPU_SUBTYPE_MC88110     = 2;

  {* SPARC subtypes  *}
  CPU_SUBTYPE_SPARC_ALL  = 0;

  {* I860 subtypes *}
  CPU_SUBTYPE_I860_ALL =  0;
  CPU_SUBTYPE_I860_860 =  1;

  {* PowerPC subtypes *}

  CPU_SUBTYPE_POWERPC_ALL  = 0;
  CPU_SUBTYPE_POWERPC_601  = 1;
  CPU_SUBTYPE_POWERPC_602  = 2;
  CPU_SUBTYPE_POWERPC_603  = 3;
  CPU_SUBTYPE_POWERPC_603e = 4;
  CPU_SUBTYPE_POWERPC_603ev = 5;
  CPU_SUBTYPE_POWERPC_604  = 6;
  CPU_SUBTYPE_POWERPC_604e = 7;
  CPU_SUBTYPE_POWERPC_620  = 8;
  CPU_SUBTYPE_POWERPC_750  = 9;
  CPU_SUBTYPE_POWERPC_7400 = 10;
  CPU_SUBTYPE_POWERPC_7450 = 11;
  CPU_SUBTYPE_POWERPC_970  = 100;

  {* ARM subtypes *}
  CPU_SUBTYPE_ARM_ALL       = 0;
  CPU_SUBTYPE_ARM_V4T       = 5;
  CPU_SUBTYPE_ARM_V6        = 6;
  CPU_SUBTYPE_ARM_V5TEJ     = 7;
  CPU_SUBTYPE_ARM_XSCALE  = 8;


{*
 *	CPU families (sysctl hw.cpufamily)
 *
 * These are meant to identify the CPU's marketing name - an
 * application can map these to (possibly) localized strings.
 * NB: the encodings of the CPU families are intentionally arbitrary.
 * There is no ordering, and you should never try to deduce whether
 * or not some feature is available based on the family.
 * Use feature flags (eg, hw.optional.altivec) to test for optional
 * functionality.
 *}
  CPUFAMILY_UNKNOWN    = 0;
  CPUFAMILY_POWERPC_G3 = $cee41549;
  CPUFAMILY_POWERPC_G4 = $77c184ae;
  CPUFAMILY_POWERPC_G5 = $ed76d8aa;
  CPUFAMILY_INTEL_6_13 = $aa33392b;
  CPUFAMILY_INTEL_6_14 = $73d67300;
  { "Intel Core Solo" and "Intel Core Duo" (32-bit Pentium-M with SSE3) }
  CPUFAMILY_INTEL_6_15 = $426f69ef;  { "Intel Core 2 Duo" }
  CPUFAMILY_INTEL_6_23 = $78ea4fbc;  { Penryn }
  CPUFAMILY_INTEL_6_26 = $6b5a4cd2;  { Nehalem }
  CPUFAMILY_ARM_9      = $e73283ae;
  CPUFAMILY_ARM_11     = $8ff620d8;
  CPUFAMILY_ARM_XSCALE = $53b005f5;

  CPUFAMILY_INTEL_YONAH   = CPUFAMILY_INTEL_6_14;
  CPUFAMILY_INTEL_MEROM   = CPUFAMILY_INTEL_6_15;
  CPUFAMILY_INTEL_PENRYN = CPUFAMILY_INTEL_6_23;
  CPUFAMILY_INTEL_NEHALEM = CPUFAMILY_INTEL_6_26;

  CPUFAMILY_INTEL_CORE  = CPUFAMILY_INTEL_6_14;
  CPUFAMILY_INTEL_CORE2  = CPUFAMILY_INTEL_6_15;

  // mach/vm_prot.h

Type 
  vm_prot_t = Integer;

Const 
  VM_PROT_NONE  = $00;

  VM_PROT_READ  = $01; {* read permission *}
  VM_PROT_WRITE  = $02; {* write permission *}
  VM_PROT_EXECUTE = $04; {* execute permission *}

  PROT_READ     =  $1;          { page can be read }
  PROT_WRITE    =  $2;          { page can be written }
  PROT_EXEC     =  $4;          { page can be executed }
  PROT_NONE     =  $0;          { page can not be accessed }

  MAP_ANONYMOUS =$1000;
  MAP_ANON	= MAP_ANONYMOUS;

  MAP_FAILED    = pointer(-1);  { mmap() has failed }
  MAP_SHARED    =  $1;          { Share changes }
  MAP_PRIVATE   =  $2;          { Changes are private }
  MAP_TYPE      =  $f;          { Mask for type of mapping }
  MAP_FIXED     = $10;          { Interpret addr exactly }

{*
 *	The default protection for newly-created virtual memory
 *}

  VM_PROT_DEFAULT = VM_PROT_READ or VM_PROT_WRITE;

{*
 *	The maximum privileges possible, for parameter checking.
 *}

  VM_PROT_ALL  = VM_PROT_READ or VM_PROT_WRITE or VM_PROT_EXECUTE;


{*
 *	An invalid protection value.
 *	Used only by memory_object_lock_request to indicate no change
 *	to page locks.  Using -1 here is a bad idea because it
 *	looks like VM_PROT_ALL and then some.
 *}

  VM_PROT_NO_CHANGE = $08;


{*
 *      When a caller finds that he cannot obtain write permission on a
 *      mapped entry, the following flag can be used.  The entry will
 *      be made "needs copy" effectively copying the object (using COW),
 *      and write permission will be added to the maximum protections
 *      for the associated entry.
 *}

  VM_PROT_COPY = $10;



{*
 *	Another invalid protection value.
 *	Used only by memory_object_data_request upon an object
 *	which has specified a copy_call copy strategy. It is used
 *	when the kernel wants a page belonging to a copy of the
 *	object, and is only asking the object as a result of
 *	following a shadow chain. This solves the race between pages
 *	being pushed up by the memory manager and the kernel
 *	walking down the shadow chain.
 *}

  VM_PROT_WANTS_COPY = $10;



{ Constant for the magic field of the mach_header (32-bit architectures)  the mach magic number  }

Const 
  MH_MAGIC = $feedface;
  MH_CIGAM = $cefaedfe; { NXSwapInt(MH_MAGIC)  }

Type 

{* The 64-bit mach header appears at the very beginning of object files for
   * 64-bit architectures. }
  mach_header_64 = Record
    magic      : uint32_t;      { mach magic number identifier  }
    cputype    : cpu_type_t;    { cpu specifier  }
    cpusubtype : cpu_subtype_t; { machine specifier  }
    filetype   : uint32_t;      { type of file  }
    ncmds      : uint32_t;      { number of load commands  }
    sizeofcmds : uint32_t;      { the size of all the load commands  }
    flags      : uint32_t;      { flags  }
    reserved   : uint32_t;      { reserved  }
  End;
  pmach_header_64 = ^mach_header_64;

  { Constant for the magic field of the mach_header_64 (64-bit architectures)  }
  { the 64-bit mach magic number  }

Const 
  MH_MAGIC_64 = $feedfacf;
  MH_CIGAM_64 = $cffaedfe; { NXSwapInt(MH_MAGIC_64)  }


{* The layout of the file depends on the filetype.  For all but the MH_OBJECT
   * file type the segments are padded out and aligned on a segment alignment
   * boundary for efficient demand pageing.  The MH_EXECUTE, MH_FVMLIB, MH_DYLIB,
   * MH_DYLINKER and MH_BUNDLE file types also have the headers included as part
   * of their first segment.
   *
   * The file type MH_OBJECT is a compact format intended as output of the
   * assembler and input (and possibly output) of the link editor (the .o
   * format).  All sections are in one unnamed segment with no segment padding.
   * This format is used as an executable format when the file is so small the
   * segment padding greatly increases its size.
   *
   * The file type MH_PRELOAD is an executable format intended for things that
   * are not executed under the kernel (proms, stand alones, kernels, etc).  The
   * format can be executed under the kernel but may demand paged it and not
   * preload it before execution.
   *
   * A core file is in MH_CORE format and can be any in an arbritray legal
   * Mach-O file.
   *
   * Constants for the filetype field of the mach_header }

Const 
  MH_OBJECT     = $1; { relocatable object file  }
  MH_EXECUTE    = $2; { demand paged executable file  }
  MH_FVMLIB     = $3; { fixed VM shared library file  }
  MH_CORE       = $4; { core file  }
  MH_PRELOAD    = $5; { preloaded executable file  }
  MH_DYLIB      = $6; { dynamically bound shared library  }
  MH_DYLINKER   = $7; { dynamic link editor  }
  MH_BUNDLE     = $8; { dynamically bound bundle file  }
  MH_DYLIB_STUB = $9; { shared library stub for static  }
  MH_DSYM       = $a; { linking only, no section contents   }
                      { companion file with only debug sections  }

Const 
  { Constants for the flags field of the mach_header  }

  MH_NOUNDEFS     = $1;   { the object file has no undefined references  }
  MH_INCRLINK     = $2;
{ the object file is the output of an  incremental link against a base file and can't be link edited again  }
  MH_DYLDLINK     = $4;
{ the object file is input for the dynamic linker and can't be staticly link edited again  }
  MH_BINDATLOAD   = $8;
{ the object file's undefined references are bound by the dynamic linker when loaded.  }
  MH_PREBOUND     = $10;
  { the file has its dynamic undefined references prebound.  }
  MH_SPLIT_SEGS   = $20;
  { the file has its read-only and read-write segments split  }
  MH_LAZY_INIT    = $40;
{ the shared library init routine is to be run lazily via catching memory faults to its writeable segments (obsolete)  }
  MH_TWOLEVEL     = $80;  { the image is using two-level name space bindings  }
  MH_FORCE_FLAT   = $100;
  { the executable is forcing all images to use flat name space bindings  }
  MH_NOMULTIDEFS  = $200;
{ this umbrella guarantees no multiple defintions of symbols in its sub-images so the two-level namespace hints can always be used.  }
  MH_NOFIXPREBINDING = $400;
  { do not have dyld notify the prebinding agent about this executable  }
  MH_PREBINDABLE     = $800;
{ the binary is not prebound but can have its prebinding redone. only used when MH_PREBOUND is not set.  }
  MH_ALLMODSBOUND    = $1000;
{ indicates that this binary binds to  all two-level namespace modules of                }

{ its dependent libraries. only used  when MH_PREBINDABLE and MH_TWOLEVEL are both set.  }
  MH_SUBSECTIONS_VIA_SYMBOLS = $2000;
{ safe to divide up the sections into sub-sections via symbols for dead code stripping  }
  MH_CANONICAL      = $4000;
  { the binary has been canonicalized via the unprebind operation  }
  MH_WEAK_DEFINES   = $8000;
  { the final linked image contains external weak symbols  }
  MH_BINDS_TO_WEAK  = $10000; { the final linked image uses weak symbols  }
  MH_ALLOW_STACK_EXECUTION = $20000;
  { When this bit is set, all stacks in the task will be given stack }

  {	execution privilege.  Only used in MH_EXECUTE filetypes.        }
  MH_ROOT_SAFE = $40000;
{ When this bit is set, the binary declares it is safe for use in processes with uid zero  }
  MH_SETUID_SAFE = $80000;
{ When this bit is set, the binary declares it is safe for use in processes when issetugid() is true  }
  MH_NO_REEXPORTED_DYLIBS = $100000;
{ When this bit is set on a dylib, the static linker does not need to examine dependent dylibs to see if any are re-exported  }
  MH_PIE = $200000;
{ When this bit is set, the OS will load the main executable at a random address.  Only used in MH_EXECUTE filetypes.  }


Type 
  load_command = Record
    cmd     : uint32_t; { type of load command  }
    cmdsize : uint32_t; { total size of command in bytes  }
  End;
  pload_command = ^load_command;


{
   * After MacOS X 10.1 when a new load command is added that is required to be
   * understood by the dynamic linker for the image to execute properly the
   * LC_REQ_DYLD bit will be or'ed into the load command constant.  If the dynamic
   * linker sees such a load command it it does not understand will issue a
   * "unknown load command required for execution" error and refuse to use the
   * image.  Other load commands without this bit that are not understood will
   * simply be ignored.
    }

Const 
  LC_REQ_DYLD   = $80000000;

{ Constants for the cmd field of all load commands, the type  }

Const 
  LC_SEGMENT        = $1;  { segment of this file to be mapped }
  LC_SYMTAB         = $2;  { link-edit stab symbol table info  }
  LC_SYMSEG         = $3;  { link-edit gdb symbol table info (obsolete)  }
  LC_THREAD         = $4;  { thread  }
  LC_UNIXTHREAD     = $5;  { unix thread (includes a stack)  }
  LC_LOADFVMLIB     = $6;  { load a specified fixed VM shared library  }
  LC_IDFVMLIB       = $7;  { fixed VM shared library identification  }
  LC_IDENT          = $8;  { object identification info (obsolete)  }
  LC_FVMFILE        = $9;  { fixed VM file inclusion (internal use)  }
  LC_PREPAGE        = $a;  { prepage command (internal use)  }
  LC_DYSYMTAB       = $b;  { dynamic link-edit symbol table info  }
  LC_LOAD_DYLIB     = $c;  { load a dynamically linked shared library  }
  LC_ID_DYLIB       = $d;  { dynamically linked shared lib ident  }
  LC_LOAD_DYLINKER  = $e;  { load a dynamic linker  }
  LC_ID_DYLINKER    = $f;  { dynamic linker identification  }
  LC_PREBOUND_DYLIB = $10;
  { modules prebound for a dynamically linked shared library  }
  LC_ROUTINES       = $11; { image routines  }
  LC_SUB_FRAMEWORK  = $12; { sub framework  }
  LC_SUB_UMBRELLA   = $13; { sub umbrella  }
  LC_SUB_CLIENT     = $14; { sub client  }
  LC_SUB_LIBRARY    = $15; { sub library  }
  LC_TWOLEVEL_HINTS = $16; { two-level namespace lookup hints  }
  LC_PREBIND_CKSUM  = $17; { prebind checksum  }
  LC_LOAD_WEAK_DYLIB = $18 or LC_REQ_DYLD;
{ load a dynamically linked shared library that is allowed to be missing  (all symbols are weak imported). }
  LC_SEGMENT_64   = $19; { 64-bit segment of this file to be mapped  }
  LC_ROUTINES_64  = $1a; { 64-bit image routines  }
  LC_UUID         = $1b; { the uuid  }
  LC_RPATH        = $1c or LC_REQ_DYLD; { runpath additions  }
  LC_CODE_SIGNATURE     = $1d; { local of code signature  }
  LC_SEGMENT_SPLIT_INFO = $1e; { local of info to split segments  }
  LC_REEXPORT_DYLIB     = $1f or LC_REQ_DYLD; { load and re-export dylib  }
  LC_LAZY_LOAD_DYLIB    = $20; { delay load of dylib until first use  }
  LC_ENCRYPTION_INFO    = $21; { encrypted segment information  }

Type 
  lc_str = Record
    Case longint Of 
      0 : ( offset : uint32_t );
      1 : ( ptr : ^char );
  End;


{
   * The 64-bit segment load command indicates that a part of this file is to be
   * mapped into a 64-bit task's address space.  If the 64-bit segment has
   * sections then section_64 structures directly follow the 64-bit segment
   * command and their size is reflected in cmdsize.
    }
  { for 64-bit architectures  }

  segment_command_64 = Record
    cmd      : uint32_t;              { LC_SEGMENT_64  }
    cmdsize  : uint32_t;              { includes sizeof section_64 structs  }
    segname  : array[0..15] Of char;  { segment name  }
    vmaddr   : uint64_t;              { memory address of this segment  }
    vmsize   : uint64_t;              { memory size of this segment  }
    fileoff  : uint64_t;              { file offset of this segment  }
    filesize : uint64_t;              { amount to map from the file  }
    maxprot  : vm_prot_t;             { maximum VM protection  }
    initprot : vm_prot_t;             { initial VM protection  }
    nsects   : uint32_t;              { number of sections in segment  }
    flags    : uint32_t;              { flags  }
  End;
  psegment_command_64 = ^segment_command_64;


Type 

  dylib = Record
    name                  : lc_str;   { library's path name  }
    timestamp             : uint32_t; { library's build time stamp  }
    current_version       : uint32_t; { library's current version number  }
    compatibility_version : uint32_t; { library's compatibility vers number }
  End;


  dylib_command = Record
    cmd     : uint32_t;
    { LC_ID_DYLIB, LC_LOAD_DYLIB,WEAK_DYLIB, LC_REEXPORT_DYLIB  }
    cmdsize : uint32_t; { includes pathname string  }
    dylib   : dylib;    { the library identification  }
  End;
  pdylib_command = ^dylib_command;


{* The symtab_command contains the offsets and sizes of the link-edit 4.3BSD
   * "stab" style symbol table information as described in the header files
   * <nlist.h> and <stab.h>.
    }

  symtab_command = Record
    cmd     : uint32_t;  { LC_SYMTAB  }
    cmdsize : uint32_t;  { sizeof(struct symtab_command)  }
    symoff  : uint32_t;  { symbol table offset  }
    nsyms   : uint32_t;  { number of symbol table entries  }
    stroff  : uint32_t;  { string table offset  }
    strsize : uint32_t;  { string table size in bytes  }
  End;
  psymtab_command = ^symtab_command;

Type 

  {* This is the symbol table entry structure for 64-bit architectures.}
  nlist_64 = Record
    n_un : Record
      Case longint Of 
        0 : ( n_strx : uint32_t ); { index into the string table  }
    End;
    n_type  : uint8_t;  { type flag, see below  }
    n_sect  : uint8_t;  { section number or NO_SECT  }
    n_desc  : uint16_t; { see <mach-o/stab.h>  }
    n_value : uint64_t; { value of this symbol (or stab offset)  }
  End;
  pnlist_64 = ^nlist_64;

Implementation

End.
