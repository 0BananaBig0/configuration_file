## Preface

1. If you have sufficient experience with C++ projects, you can proceed with reading this additional
   summary. It may also be beneficial to revisit C++ tutorial videos and relearn the language from
   scratch.
2. Personally, I follow an influencer named Cherno, a game and game engine developer. He uploads
   numerous C++ tutorial series, from which I can learn various C++ techniques.
3. Additionally, if you have time, you can try implementing some standard libraries on your own. You
   don’t need to implement all their functions, just their core functionality. If you’re unsure how
   to implement them, you can search for online tutorials or examine the source code. Although the
   source code may be difficult to understand, studying it can still be beneficial.
4. Moreover, if you want to explore certain features or functions provided by C++, you can consult
   ChatGPT on topics like how to effectively use specific libraries or discover lesser-known
   functions. ChatGPT is a helpful tool for learning a wide range of topics. However, you shouldn't
   rely on it too heavily, as that might hinder your ability to study independently. Each time
   ChatGPT provides an answer, you should verify it and consider whether it is accurate, as ChatGPT
   does not guarantee 100% correctness. You should also read and internalize the results to retain
   the information.
5. You can also refer to C++ tutorial books, such as `<<C++ Primer Plus>>` and
   `<<The C++ Programming Language>>`.
6. Lastly, it’s important to note that different compilers have slightly different implementations
   of the Standard Template Library (STL). While they provide the same library, there may be minor
   variations in implementation. For instance, in std::vector, if the size exceeds its capacity, it
   grows by 50% in Clang, whereas it grows by 100% in GCC.

## Some Basic Concepts

1. Declaration: Introduces a name and type without allocating storage or providing an
   implementation. It merely states that a function, class, struct, variable, instance, or template
   exists without concerning itself with a definition.
2. Definition: A definition provides a body that implements a function, class, variable, struct,
   instance, or template. It includes an actual implementation and allocates storage for variables
   or instances.
3. Parameter: A parameter is a variable declared in a function definition. It serves as a
   placeholder for the values that will be passed to the function when it is called. Parameters are
   used to receive input values within the function and specify the type of data the function
   expects.
4. Argument: An argument is an actual value, pointer, or reference passed to the function when it is
   called. Arguments are the specific data supplied to the function's parameters.

## Memory Partitions

### Stack

1. Stores **local** variables and function call information (such as return addresses and
   parameters).
2. Follows a Last In, First Out (LIFO) structure.
3. Memory **allocation** and **deallocation** happen **automatically** when functions are called and
   return.

### Heap (Dynamic Memory)

1. Used for dynamic memory allocation, which is **managed manually** by the programmer using new and
   delete.
2. Allows for variable-sized allocations that persist until explicitly deallocated.
3. Heap memory does **not have a predefined size** and grows/shrinks at runtime.

### Global/Static Memory

1. Stores **global** variables and static variables (declared with the static keyword).
2. This partition persists for the **entire duration** of the program, from the start to its
   termination.

### Code Segment (Text Segment)

1. Stores the compiled program instructions (the executable code).
2. This section is usually **read-only** to prevent accidental modification of program instructions.

### BSS Segment (Block Started by Symbol)

1. Holds **uninitialized global and static variables**, which are initialized to **zero by
   default**.
2. Memory is **allocated** but **not explicitly initialized** by the programmer.

### Data Segment

1. Stores **initialized global and static variables**.
2. Unlike the BSS segment, variables here are **explicitly initialized** with a value by the
   programmer.

### Memory Partitioning in C++ Program Execution

1. Stack vs. Heap: The stack is **fast** and **automatically managed**, but **limited in size**. The
   heap allows for more flexible memory usage at the cost of **manual management**.
2. Global/Static vs. Local: Global and static variables have global lifetimes, while local variables
   (on the stack) have a shorter scope, limited to the block they are declared in.

## Function

### 1) Explanation

1. In C++, a function is a self-contained block of code that performs a specific task. It can take
   input values, called parameters, process them, and optionally return a result.

### 2) Advantages and Disadvantages

#### Advantages ( Why Use a Function )

1. **Code Reusability**: Functions allow you to write a piece of code once and reuse it multiple
   times throughout your program. This reduces redundancy and makes the code more maintainable.
2. Modularity: Functions enable you to break down complex problems into smaller, manageable pieces.
   Each function can focus on a specific task, which makes understanding and maintaining the code
   easier.
3. Easier Debugging: Since functions isolate specific tasks, it’s easier to identify and fix bugs.
   You can test each function independently to ensure it works correctly.
4. Improved Readability: Well-named functions make the code more readable. They serve as
   documentation by indicating what the function does, which can help other developers (or your
   future self) understand the code more quickly.
5. Abstraction: Functions help abstract away complex logic. Once a function is defined, you can use
   it without needing to understand its internal workings, allowing you to focus on higher-level
   programming.

#### Disadvantages

1. **Overhead**: Calling functions introduces a slight overhead due to the time taken for the call
   and return. This can impact performance in time-critical applications, particularly if functions
   are called excessively or are very small.
2. Complexity: Overusing functions or creating too many small functions can lead to unnecessary
   complexity. If functions are too granular, it may become challenging to trace program flow and
   understand how different parts interact.
3. Global State Management: Functions can complicate the management of global variables or states.
   If functions modify global variables, it can lead to unpredictable behavior and make debugging
   difficult.
4. Scope Issues: The scope of variables defined within functions can lead to issues if not managed
   properly. Local variables may be inaccessible outside the function, which can limit their
   usefulness.
5. Dependency Management: Functions can create dependencies between different parts of a program.
   Changes in one function may require updates to others that depend on it, which can lead to
   maintenance challenges.

### 3) Definition Syntax

```CPP
ReturnType functionName( parameter_list ) {
   // function body
};
```

### 4) Declaration Syntax

```CPP
ReturnType functionName( parameter_list );
```

### 5) Reference Syntax

```CPP
functionName( argument_list );
```

```CPP
ReturnType var_name = functionName( argument_list );
```

### 6) How to Pass an Argument to a Function

1. Primitive-type arguments: Pass their values to the function.
2. Class-type, struct-type, and other complex arguments: Pass their references to the function.
