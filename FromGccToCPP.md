<!-- vim-markdown-toc GFM -->

* [FromGccToCPP](#fromgcctocpp)
  * [g++ Compiler and Linker:](#g-compiler-and-linker)
  * [The difference between gcc and g++](#the-difference-between-gcc-and-g)
    * [1) Language:](#1-language)
    * [2) Linking:](#2-linking)
    * [3) Header File Handling:](#3-header-file-handling)
  * [How to compile one cpp file.](#how-to-compile-one-cpp-file)
    * [1) g++ Main.cpp](#1-g-maincpp)
    * [2) g++ Main.cpp -o Main.exe](#2-g-maincpp--o-mainexe)
    * [3) g++ -E Main.cpp -o Main.i](#3-g--e-maincpp--o-maini)
    * [4) g++ -S Main.i](#4-g--s-maini)
    * [5) g++ -S Main.cpp](#5-g--s-maincpp)
    * [6) g++ -c Main.s](#6-g--c-mains)
    * [7) g++ -c Main.cpp](#7-g--c-maincpp)
    * [8) g++ Main.o -o Main.exe](#8-g-maino--o-mainexe)
    * [9) g++ -On Main.cpp -o Main.exe](#9-g--on-maincpp--o-mainexe)
  * [How to compile multiple cpp files](#how-to-compile-multiple-cpp-files)
    * [1) Compile all files in one command](#1-compile-all-files-in-one-command)
    * [2) Compile all files separately and then link them together](#2-compile-all-files-separately-and-then-link-them-together)
  * [How to compile and link a library](#how-to-compile-and-link-a-library)
    * [1) Setup paths of header files](#1-setup-paths-of-header-files)
    * [2) How to link multiple static libraries](#2-how-to-link-multiple-static-libraries)
    * [3) How to create a static library](#3-how-to-create-a-static-library)
    * [4) How to link multiple dynamic libraries](#4-how-to-link-multiple-dynamic-libraries)
    * [5) How to create a dynamic library](#5-how-to-create-a-dynamic-library)
    * [6) How to link a static library explicitly](#6-how-to-link-a-static-library-explicitly)
    * [7) How to link a dynamic library explicitly](#7-how-to-link-a-dynamic-library-explicitly)

<!-- vim-markdown-toc -->

# FromGccToCPP

## g++ Compiler and Linker:

1. Header File / Preprocess Statement: The compiler will copy and paste them into the object CPP file.
2. CPP File: The compiler translates the CPP files into assembly code and then into machine code without
   performing any linking operations. Typically, there is one OBJ file per CPP file, but sometimes multiple
   CPP files may result in a single OBJ file. During the compilation phase, the compiler also optimizes
   your code.
3. OBJ File / Machine Code File: All OBJ files will be combined into a single file by the linker.
   The C++ linker can perform certain optimizations, although its primary role is focused on linking object
   files and libraries rather than optimizing code.

## The difference between gcc and g++

### 1) Language:

1. gcc: Primarily the GNU C Compiler, but it can also compile C++ files if passed the appropriate flags.
   It defaults to treating source files as C code unless you specify C++.
2. g++: A specialized driver for C++ compilation. It automatically links the C++ standard library and
   handles C++-specific extensions.

### 2) Linking:

1. gcc: When compiling C++ files with gcc, you must manually link the C++ standard library (e.g., -lstdc++).
2. g++: Automatically links the C++ standard library without needing extra flags.

### 3) Header File Handling:

1.gcc: When used with C, gcc processes headers as C-specific (using .h headers for the most part).
2.g++: Treats headers as C++ files and supports C++ header files (like <iostream> instead of <stdio.h>).

## How to compile one cpp file.

Source files: Main.cpp

### 1) g++ Main.cpp

1. Usage: Preprocess, compile, and link Main.cpp to generate the executable file a.out.
2. Output: a.out

### 2) g++ Main.cpp -o Main.exe

1. Usage: Preprocess, compile, and link Main.cpp to generate an executable file. The option `-o`
   specifies the name of the executable file.
2. Output: Main.exe

### 3) g++ -E Main.cpp -o Main.i

1. Usage: Preprocess Main.cpp to generate a preprocessed file. The option `-o` specifies the name of
   the preprocessed file.
2. Output: Main.i

### 4) g++ -S Main.i

1. Usage: Compile the preprocessed file to generate an assembly file.
2. Output: Main.s

### 5) g++ -S Main.cpp

1. Usage: Preprocess and compile the source file to generate an assembly file.
2. Output: Main.s

### 6) g++ -c Main.s

1. Usage: Translate the assembly file into an object file.
2. Output: Main.o

### 7) g++ -c Main.cpp

1. Usage: Preprocess and compile the source file to generate an object file.
2. Output: Main.o

### 8) g++ Main.o -o Main.exe

1. Usage: Link the object file to generate an executable file.
2. Output: Main.exe

### 9) g++ -On Main.cpp -o Main.exe

1. Usage: Compile Main.cpp with optimization level n (where 0 ≤ n ≤ 3). Higher values of n result in
   longer compile times and more aggressive optimizations.
2. Output: Main.exe

## How to compile multiple cpp files

Source files: Main.cpp, Fun.cpp

### 1) Compile all files in one command

1. Code:

```
g++ Main.cpp Fun.cpp -o Main.exe
```

2. Usage: Compile Main.cpp and Fun.cpp into Main.o and Fun.o separately, and then link them to generate
   an executable file.
3. Output: Main.o, Fun.o, Main.exe
4. Alternative: If all files are in one folder:

```
g++ *.cpp -o Main.exe
```

### 2) Compile all files separately and then link them together

1. Code:

```
g++ -c Main.cpp
g++ -c Fun.cpp
g++ -o Main.o Fun.o -o Main.exe
```

2. Usage: Compile Main.cpp and Fun.cpp into Main.o and Fun.o with separate commands, and then link
   them to generate an executable file.
3. Output: Main.o, Fun.o, Main.exe

## How to compile and link a library

Source files: Main.cpp, Fun.cpp

### 1) Setup paths of header files

1. Code:

```
g++ Main.cpp Fun.cpp -o Main.exe -I/the/first/path/of/header/files \
    -I/the/second/path/of/header/files ...
```

### 2) How to link multiple static libraries

1. Code:

```
g++ Main.cpp -L/the/first/path/of/static/libraries \-L/the/second/path/of/static/libraries ... \
    -lxxx.a -lyyy.a ... -o Main.exe
```

### 3) How to create a static library

1. Code:

```
g++ -c Fun.cpp
ar rcs libFun.a Fun.o
g++ Main.cpp -L. -lFun -o Main.exe
```

2. Usage: Use `g++` to compile Fun.cpp into an object file. Then, use `ar` to create a static library
   from the object file. Finally, compile Main.cpp and link it with libFun.a to generate an executable file.
3. Output: Fun.o, libFun.a, Main.exe

### 4) How to link multiple dynamic libraries

1. Code:

```
g++ Main.cpp -L/the/first/path/of/dynamic/libraries -L/the/second/path/of/dynamic/libraries ... \
-lxxx.a -lyyy.a ... -o Main.exe
```

### 5) How to create a dynamic library

1. Code:

```
g++ -c -fPIC Fun.cpp -o Fun.o
g++ -shared -o libFun.so Fun.o
g++ Main.cpp -L. -lFun -o Main.exe
```

2. Usage: Use `g++ -c -fPIC` to compile Fun.cpp into an object file. Then, use `g++ -shared` to create
   a dynamic library from the object file. Finally, compile Main.cpp and link it with libFun.so to generate an executable file.
3. Output: Fun.o, libFun.so, Main.exe

### 6) How to link a static library explicitly

1. Code:

```
g++ -c Fun.cpp
ar rcs libFun.a Fun.o
g++ -c -fPIC Fun.cpp -o Fun.o
g++ -shared -o libFun.so Fun.o
g++ Main.cpp -L. -Wl,-Bstatic -lFun -Wl,-Bdynamic -o Main.exe
```

2. -Wl,-Bstatic: Instructs the linker (ld) to search for static libraries (.a files).
   3.-Wl,-Bdynamic: Reverts the linker back to dynamic libraries, in case you are linking other dynamic libraries afterward.
3. Situation: A static library has the same name as a dynamic library in the same folder.
4. Usage: Create both a static library and a dynamic library. They have the same name. Link the static library explicitly.
5. Output: Fun.o, libFun.a, libFun.so, Main.exe

### 7) How to link a dynamic library explicitly

1. Code:

```
g++ -c Fun.cpp
ar rcs libFun.a Fun.o
g++ -c -fPIC Fun.cpp -o Fun.o
g++ -shared -o libFun.so Fun.o
g++ Main.cpp -L. -lFun -o Main.exe
```

2. Situation: A dynamic library has the same name as a static library in the same folder.
3. Usage: Create both a static library and a dynamic library. They have the same name. Link the dynamic library explicitly.
4. Output: Fun.o, libFun.a, libFun.so, Main.exe
5. Special Notes: g++ links a dynamic library by default.
