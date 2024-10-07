<!-- vim-markdown-toc GFM -->

* [FromGccToCPP](#fromgcctocpp)
  * [`g++` Compiler and Linker](#g-compiler-and-linker)
      * [1. Header File / Preprocess Statement](#1-header-file--preprocess-statement)
      * [2. CPP File](#2-cpp-file)
      * [3. OBJ File / Machine Code File](#3-obj-file--machine-code-file)
  * [The difference between `gcc` and `g++`](#the-difference-between-gcc-and-g)
    * [1) Language](#1-language)
      * [1. `gcc`](#1-gcc)
      * [2. `g++`](#2-g)
    * [2) Linking](#2-linking)
      * [1. `gcc`](#1-gcc-1)
      * [2. `g++`](#2-g-1)
    * [3) Header File Handling](#3-header-file-handling)
      * [1. `gcc`](#1-gcc-2)
      * [2. `g++`](#2-g-2)
  * [How to compile one cpp file](#how-to-compile-one-cpp-file)
    * [Source files](#source-files)
    * [1) `g++ Main.cpp`](#1-g-maincpp)
      * [1. Usage](#1-usage)
      * [2. Output](#2-output)
    * [2) `g++ Main.cpp -o Main.exe`](#2-g-maincpp--o-mainexe)
      * [1. Usage](#1-usage-1)
      * [2. Output](#2-output-1)
    * [3) `g++ -E Main.cpp -o Main.i`](#3-g--e-maincpp--o-maini)
      * [1. Usage](#1-usage-2)
      * [2. Output](#2-output-2)
    * [4) `g++ -S Main.i`](#4-g--s-maini)
      * [1. Usage](#1-usage-3)
      * [2. Output](#2-output-3)
    * [5) `g++ -S Main.cpp`](#5-g--s-maincpp)
      * [1. Usage](#1-usage-4)
      * [2. Output](#2-output-4)
    * [6) `g++ -c Main.s`](#6-g--c-mains)
      * [1. Usage](#1-usage-5)
      * [2. Output](#2-output-5)
    * [7) `g++ -c Main.cpp`](#7-g--c-maincpp)
      * [1. Usage](#1-usage-6)
      * [2. Output](#2-output-6)
    * [8) `g++ Main.o -o Main.exe`](#8-g-maino--o-mainexe)
      * [1. Usage](#1-usage-7)
      * [2. Output](#2-output-7)
    * [9) `g++ -On Main.cpp -o Main.exe`](#9-g--on-maincpp--o-mainexe)
      * [1. Usage](#1-usage-8)
      * [2. Output](#2-output-8)
  * [How to compile multiple cpp files](#how-to-compile-multiple-cpp-files)
    * [Source files](#source-files-1)
    * [1) Compile all files in one command](#1-compile-all-files-in-one-command)
      * [1. Code](#1-code)
      * [2. Usage](#2-usage)
      * [3. Output](#3-output)
      * [4. Alternative: If all files are in one folder](#4-alternative-if-all-files-are-in-one-folder)
    * [2) Compile all files separately and then link them together](#2-compile-all-files-separately-and-then-link-them-together)
      * [1. Code](#1-code-1)
      * [2. Usage](#2-usage-1)
      * [3. Output](#3-output-1)
  * [How to compile and link a library](#how-to-compile-and-link-a-library)
    * [Source files](#source-files-2)
    * [1) Setup paths of header files](#1-setup-paths-of-header-files)
      * [1. Code](#1-code-2)
    * [2) How to link multiple static libraries](#2-how-to-link-multiple-static-libraries)
      * [1. Code](#1-code-3)
    * [3) How to create a static library](#3-how-to-create-a-static-library)
      * [1. Code](#1-code-4)
      * [2. Usage](#2-usage-2)
      * [3. Output](#3-output-2)
    * [4) How to link multiple dynamic libraries](#4-how-to-link-multiple-dynamic-libraries)
      * [1. Code](#1-code-5)
    * [5) How to create a dynamic library](#5-how-to-create-a-dynamic-library)
      * [1. Code](#1-code-6)
      * [2. Usage](#2-usage-3)
      * [3. Output](#3-output-3)
    * [6) How to link a static library explicitly](#6-how-to-link-a-static-library-explicitly)
      * [1. Code](#1-code-7)
      * [2. -Wl,-Bstatic](#2--wl-bstatic)
      * [3. -Wl,-Bdynamic](#3--wl-bdynamic)
      * [4. Situation](#4-situation)
      * [5. Usage](#5-usage)
      * [6. Output](#6-output)
    * [7) How to link a dynamic library explicitly](#7-how-to-link-a-dynamic-library-explicitly)
      * [1. Code](#1-code-8)
      * [2. Situation](#2-situation)
      * [3. Usage](#3-usage)
      * [4. Output](#4-output)
      * [5. Special Notes](#5-special-notes)
  * [`make` and Makefile](#make-and-makefile)
      * [1. `make`](#1-make)
      * [2. Makefile](#2-makefile)
    * [1) How `make` process Makefile](#1-how-make-process-makefile)

<!-- vim-markdown-toc -->

# FromGccToCPP

## `g++` Compiler and Linker

#### 1. Header File / Preprocess Statement

1. The compiler will copy and paste them into the object CPP file.

#### 2. CPP File

1. The compiler translates the CPP files into assembly code and then into machine code without
   performing any linking operations. Typically, there is one OBJ file per CPP file, but sometimes
   multiple CPP files may result in a single OBJ file. During the compilation phase, the compiler
   also optimizes your code.

#### 3. OBJ File / Machine Code File

1. All OBJ files will be combined into a single file by the linker. The C++ linker can perform certain
   optimizations, although its primary role is focused on linking object files and libraries rather
   than optimizing code.

## The difference between `gcc` and `g++`

### 1) Language

#### 1. `gcc`

1. Primarily the GNU C Compiler, but it can also compile C++ files if passed the appropriate flags.
   It defaults to treating source files as C code unless you specify C++.

#### 2. `g++`

1. A specialized driver for C++ compilation. It automatically links the C++ standard library and handles
   C++-specific extensions.

### 2) Linking

#### 1. `gcc`

1. When compiling C++ files with `gcc`, you must manually link the C++ standard library (e.g., -lstdc++).

#### 2. `g++`

1. Automatically links the C++ standard library without needing extra flags.

### 3) Header File Handling

#### 1. `gcc`

1. When used with C, `gcc` processes headers as C-specific (using .h headers for the most part).

#### 2. `g++`

1. Treats headers as C++ files and supports C++ header files (like `<iostream>` instead of `<stdio.h>`).

## How to compile one cpp file

### Source files

1. Main.cpp

### 1) `g++ Main.cpp`

#### 1. Usage

1. Preprocess, compile, and link Main.cpp to generate the executable file a.out.

#### 2. Output

1. a.out

### 2) `g++ Main.cpp -o Main.exe`

#### 1. Usage

1. Preprocess, compile, and link Main.cpp to generate an executable file.
2. The option `-o` specifies the name of the executable file.

#### 2. Output

1. Main.exe

### 3) `g++ -E Main.cpp -o Main.i`

#### 1. Usage

1. Preprocess Main.cpp to generate a preprocessed file.
2. The option `-o` specifies the name of the preprocessed file.

#### 2. Output

1. Main.i

### 4) `g++ -S Main.i`

#### 1. Usage

1. Compile the preprocessed file to generate an assembly file.

#### 2. Output

1. Main.s

### 5) `g++ -S Main.cpp`

#### 1. Usage

1. Preprocess and compile the source file to generate an assembly file.

#### 2. Output

1. Main.s

### 6) `g++ -c Main.s`

#### 1. Usage

1. Translate the assembly file into an object file.

#### 2. Output

1. Main.o

### 7) `g++ -c Main.cpp`

#### 1. Usage

1. Preprocess and compile the source file to generate an object file.

#### 2. Output

1. Main.o

### 8) `g++ Main.o -o Main.exe`

#### 1. Usage

1. Link the object file to generate an executable file.

#### 2. Output

1. Main.exe

### 9) `g++ -On Main.cpp -o Main.exe`

#### 1. Usage

1. Compile Main.cpp with optimization level `n` (where `0 ≤ n ≤ 3`). Higher values of n result in longer
   compile times and more aggressive optimizations.

#### 2. Output

1. Main.exe

## How to compile multiple cpp files

### Source files

1. Main.cpp
2. Fun.cpp

### 1) Compile all files in one command

#### 1. Code

```sh
g++ Main.cpp Fun.cpp -o Main.exe
```

#### 2. Usage

1. Compile Main.cpp and Fun.cpp into Main.o and Fun.o separately.
2. Link them to generate an executable file.

#### 3. Output

1. Main.o
2. Fun.o
3. Main.exe

#### 4. Alternative: If all files are in one folder

```sh
g++ *.cpp -o Main.exe
```

### 2) Compile all files separately and then link them together

#### 1. Code

```sh
g++ -c Main.cpp
g++ -c Fun.cpp
g++ -o Main.o Fun.o -o Main.exe
```

#### 2. Usage

1. Compile Main.cpp and Fun.cpp into Main.o and Fun.o with separate commands.
2. Link them to generate an executable file.

#### 3. Output

1. Main.o
2. Fun.o
3. Main.exe

## How to compile and link a library

### Source files

1. Main.cpp
2. Fun.cpp

### 1) Setup paths of header files

#### 1. Code

```sh
g++ Main.cpp Fun.cpp -o Main.exe -I/the/first/path/of/header/files \
    -I/the/second/path/of/header/files ...
```

### 2) How to link multiple static libraries

#### 1. Code

```sh
g++ Main.cpp -L/the/first/path/of/static/libraries \
    -L/the/second/path/of/static/libraries ... \
    -lxxx.a -lyyy.a ... -o Main.exe
```

### 3) How to create a static library

#### 1. Code

```sh
g++ -c Fun.cpp
ar rcs libFun.a Fun.o
g++ Main.cpp -L. -lFun -o Main.exe
```

#### 2. Usage

1. Use `g++` to compile Fun.cpp into an object file.
2. Use `ar` to create a static library from the object file.
3. Compile Main.cpp and link it with libFun.a to generate an executable file.

#### 3. Output

1. Fun.o
2. libFun.a
3. Main.exe

### 4) How to link multiple dynamic libraries

#### 1. Code

```sh
g++ Main.cpp -L/the/first/path/of/dynamic/libraries -L/the/second/path/of/dynamic/libraries ... \
-lxxx.a -lyyy.a ... -o Main.exe
```

### 5) How to create a dynamic library

#### 1. Code

```sh
g++ -c -fPIC Fun.cpp -o Fun.o
g++ -shared -o libFun.so Fun.o
g++ Main.cpp -L. -lFun -o Main.exe
```

#### 2. Usage

1. Use `g++ -c -fPIC` to compile Fun.cpp into an object file.
2. Use `g++ -shared` to create a dynamic library from the object file.
3. Compile Main.cpp and link it with libFun.so to generate an executable file.

#### 3. Output

1. Fun.o
2. libFun.so
3. Main.exe

### 6) How to link a static library explicitly

#### 1. Code

```sh
g++ -c Fun.cpp
ar rcs libFun.a Fun.o
g++ -c -fPIC Fun.cpp -o Fun.o
g++ -shared -o libFun.so Fun.o
g++ Main.cpp -L. -Wl,-Bstatic -lFun -Wl,-Bdynamic -o Main.exe
```

#### 2. -Wl,-Bstatic

Instructs the linker (ld) to search for static libraries (.a files).

#### 3. -Wl,-Bdynamic

Reverts the linker back to dynamic libraries, in case you are linking other dynamic libraries afterward.

#### 4. Situation

A static library has the same name as a dynamic library in the same folder.

#### 5. Usage

Create both a static library and a dynamic library. They have the same name. Link the static library explicitly.

#### 6. Output

1. Fun.o
2. libFun.a
3. libFun.so
4. Main.exe

### 7) How to link a dynamic library explicitly

#### 1. Code

```sh
g++ -c Fun.cpp
ar rcs libFun.a Fun.o
g++ -c -fPIC Fun.cpp -o Fun.o
g++ -shared -o libFun.so Fun.o
g++ Main.cpp -L. -lFun -o Main.exe
```

#### 2. Situation

1. A dynamic library has the same name as a static library in the same folder.

#### 3. Usage

1. Create both a static library and a dynamic library. They have the same name. Link the dynamic library explicitly.

#### 4. Output

1. Fun.o
2. libFun.a
3. libFun.so
4. Main.exe

#### 5. Special Notes

1. g++ links a dynamic library by default.

## `make` and Makefile

#### 1. `make`

1. The make command is a build automation tool primarily used for compiling and building projects in C,
   C++, and other programming languages. It simplifies the process of compiling code, linking libraries,
   and creating executables by reading instructions from a configuration file called a Makefile.

#### 2. Makefile

1. A Makefile consists of a set of rules, each specifying how to compile files, generate targets, or
   perform other tasks related to building the project. These rules may include shell commands as well
   as custom commands defined within the Makefile syntax.

### 1) How `make` process Makefile
