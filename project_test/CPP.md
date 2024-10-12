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
5. You can also refer to C++ tutorial books or websites, such as `<<The C++ Programming Language>>`
   and `<<C++ Primer Plus>>`, [cppreference](https://en.cppreference.com/) ,
   [cplusplus](https://cplusplus.com/) and [tutorialspoint](https://www.tutorialspoint.com/) or a
   command `cppman` in Linux. When reading any tutorial, including this one, **focus on the basic
   concepts**, their definitions, explanations, and key characteristics, paying particular attention
   to the bold text, as these concepts often appear in other contexts.
6. Lastly, it’s important to note that different compilers have slightly different implementations
   of the Standard Template Library (STL). While they provide the same library, there may be minor
   variations in implementation. For instance, in std::vector, if the size exceeds its capacity, it
   grows by 50% in Clang, whereas it grows by 100% in GCC.

## Some Basic Concepts

### 1) Declaration

#### General Explanation

1. Introduces **a name and type without allocating storage or providing an implementation**. It
   merely states that a function, class, struct or variable exists without concerning itself with a
   definition.

#### Forward Declaration

1.  It is **a declaration** of a class, function, or variable that **informs the compiler of its
    existence without providing the full definition** at that point. It allows the compiler to
    handle references to an entity (e.g., a class or a function) without needing to know all the
    details at that time. The complete definition is provided later in the code.
2.  This is typically used to **improve compilation times**, **resolve circular dependencies**, or
    when the full details of the entity are not yet required.

### 2) Definition

1.  A definition **provides a body** that implements a function, class, struct or variable. It
    includes **an actual value or implementation** and **allocates storage for variables**.

### 3) Variable, Instance and Object

#### Variable

##### Explanation

1. A variable is **a named storage location** in memory that **holds a value**. It has a specific
   type (such as int, float, or a custom class) and is declared in the program to store data that
   can be accessed and modified.

##### Key Characteristics

1. **A name** (identifier) is required.
2. **A type** is specified (determining the kind of value it can hold).
3. It **occupies memory** in the program.

#### Instance

##### Explanation

1. An instance is **a concrete occurrence** of **a particular data type**. This term is most
   commonly used in the context of user-defined types like **classes or structs**. When you create
   an instance of a class, you're creating an object of that class type.

##### Key Characteristics

1. Refers to **a specific occurrence** of **a class or struct**.
2. Instances of a class are often **called objects**.

#### Object

##### Explanation

1. An object is **a region of memory** that **has a type, value**, and, **in most cases, a name
   (optional)**. Every variable in C++ is an object, and every instance of a class is also an
   object. The term object is **more general** and refers to any instance of a type that occupies
   memory, whether it’s built-in (like int, double) or user-defined (like a class).
2. An object is **generally** defined as **an instance** of a data type that **occupies memory** and
   **has attributes (data members) and behaviors (methods)** when it comes to **user-defined types
   (classes)**.
3. For **built-in types** (like int, char, etc.), the term "object" can **also apply**.

##### Key Characteristics

1. **An instance of any type** (built-in or user-defined).
2. **Occupies memory** and **has a type**.
3. **May or may not** have **a name** (temporary objects don’t have names).
4. Includes variables, class instances, dynamically allocated memory, and **temporary values**.

#### Relationships Between the Them

##### Variable

1. A variable is **a named object**. Every variable is an object, but not all objects are variables.
   A variable always refers to an object, but it also provides a name for it, allowing it to be used
   and modified in the code.

##### Instance

1. An instance is **a specific object** of **a class or user-defined type**. It represents a
   concrete realization of that class, holding data and having behaviors defined by the class. When
   you create an instance of a class, you are creating an object of that class.

##### Object

1. An object is **the most general term**. It refers to **any entity** that **occupies memory** and
   **has a type**. Objects can be variables, instances of classes, temporary objects, or even
   dynamically allocated memory that doesn't have a name (like objects created with new).

### 4) Pointer and Reference

#### Pointer

1. In C++, a pointer is **a variable** that **stores the memory address of another variable**.
2. Pointers enable **dynamic memory allocation**, efficient array handling, and the ability to pass
   large data structures to functions without copying them.

#### Reference

1. In C++, a reference is **an alias for an existing variable**. It allows you to create **another
   name for a variable** without making a copy of it. References are declared using an ampersand
   (`&`) in the declaration.
2. A reference **must be initialized** when it is declared and cannot be changed to refer to another
   variable later.
3. Unlike pointers, references **cannot be null**. They must always refer to a valid object.
4. In C++, a reference is defined as a type. However, I believe it is **merely an alias**, not a
   distinct type, because `auto` cannot deduce a type as a reference without using `&`.
5. A reference is **neither a variable nor an object**.

### 5) Parameter

1.  A parameter is **a variable declared in a function definition**. It serves as a placeholder for
    the values that will be passed to the function when it is called.
2.  Parameters are used to **receive input values** within the function and specify the type of data
    the function expects.

### 6) Argument

1.  An argument is **an actual value, variable, object or reference passed to the function** when it
    is called. Arguments are the specific data supplied to the function's parameters.

### 7) Interface

1. In C++, the term "interface" does **not have a formal definition** like it does in some other
   programming languages (like Java). However, in C++, an interface is generally understood to be
   **a class** that **defines a set of pure virtual functions**, which means that it declares
   functions that **must be implemented by derived classes** but does **not provide any
   implementation of its own**.

### 8) Keyword

1. A keyword in C++ is **a reserved word** that has a predefined meaning in the language and
   **cannot be used as an identifier** (such as a variable name, function name, etc.). Keywords are
   part of the C++ syntax and represent fundamental constructs or operations in the language.

### 9) Type Specifier

1. In C++, a type specifier is **used to define the type of a variable, function return value, or
   object**. Type specifiers tell the compiler what kind of data the variable will hold or the
   function will return. They are an essential part of variable declarations and type definitions.

### 10) `auto`

#### Explanation and Capabilities

1. In C++, `auto` is **a type specifier** that allows the compiler to **automatically deduce the
   type** of a variable from its initializer.
2. This feature, introduced in C++11, is especially useful for **simplifying complex type
   declarations, avoiding redundancy, and making code more readable**.
3. `auto` can deduce whether a reference is `const` based on the initializer variable. However, for
   non-reference types, `auto` only deduces the type without adding `const`. Therefore, if you want
   variables **deduced with `auto` to be `const`**, you'd better **explicitly specify `const`**.
4. `auto` can deduce whether a type is a pointer based on the initializer.
   `auto var_name = ptr_name;` `<=>` `auto* var_name = ptr_name; \\ **Better**` However, if you use
   `auto` to deduce a type with a pointer as the initializer, you must **specify it explicitly with
   a star ( `*` )**.
5. `auto` **cannot deduce** whether a type is **a reference** based on the initializer. Therefore,
   If you want the type to be deduced as a reference, **specify it explicitly with `&`**.
   `auto & var_name = ini_name;`
6. Specifically, if the initializer is **a const char pointer** or **a const char array** (such as a
   string literal, "xxx"), auto deduces the variable to be **a const char pointer**.

#### Situation and Usage

1. If you **change the return types of your functions or APIs**, `auto` can help us reduce the
   amount of code that needs to be modified. However, the code will become less readable, and some
   bugs may occur because the compiler will not tell us where changes are needed to adapt to these
   new functions. Therefore, you should **avoid using `auto` in this case**.
2. **Use `auto`** when working with **an iterator**, as it can make the code more readable.
3. When calling a function whose **return type has a long name**, you can **use `auto`** to make the
   code more readable.

### 11) `using` and `typedef`

#### `using`

##### Explanation

1. In C++, `using` is **a keyword** and has multiple uses, each serving a different purpose
   depending on the context. It can be used for **type aliasing**, **namespace introduction (not
   recommend)**, and **template aliasing**. It offers more flexibility compared to `typedef`,
   particularly when working with templates.

##### Syntax

```
using YourTypeName = Type;
```

##### Usage

1. Syntax Simplicity
2. Template Aliases
3. Function Pointer Declaration
4. Alias for Member Types in Classes

#### `typedef`

##### Explanation

1. In C++, `typedef` is **a keyword** used to **create an alias for a data type**, allowing you to
   define new names for existing types. This can improve code readability, simplify complex type
   definitions, and enhance maintainability by making it easier to manage changes in data types
   throughout your code.

##### Syntax

```
typedef Type YourTypeName;
```

##### Usage

1. Syntax Simplicity
2. Function Pointer Declaration
3. Alias for Member Types in Classes

## Some Small Knowledge

1. The performance of < is better than <=.
2. `std::endl` is a little slower than `"\n"` in debug mode. Otherwise, `std::endl` is faster.

## Memory Partitions

### **Stack**

#### Purpose

1. Stores **local variables** and **function call information** (such as return addresses and
   parameters).
2. Data is **lost** when it goes **out of scope**.

#### Allocation/Deallocation

1. **Automatically handled** by the compiler.
2. Memory for local variables is **allocated when a function is called** and **deallocated when the
   function exits**.
3. Allocating memory requires **only one CPU instruction**.

#### Lifetime

1. Local variables exist only for **the duration of the function call**.

#### Scope

1. Limited to **the function** where **the variables** are **declared**.

#### Size

1. **Limited size** (typically between **1 MB to 8 MB**, determined by the OS).
2. Prone to **stack overflow** for deep recursion or large allocations.
3. The size **cannot grow dynamically**.

#### Structure

1. Follows a **LIFO (Last In, First Out)** structure.
2. Memory is deallocated in reverse order of allocation.
3. Stores data like a physical stack, pushing new data and updating the **stack pointer**.

#### Performance

1. **Fast access** due to contiguous memory layout and minimal overhead.
2. Allocation and deallocation are **faster** than heap operations.

#### Other Characteristics

1. Data is **close together** in memory, **reducing cache misses**.
2. Fits well into **one CPU cache line** due to the locality of reference.

### **Heap (Dynamic Memory)**

#### Purpose

1. Stores **dynamically allocated objects** created during runtime.
2. Used when the amount of memory needed is not known in advance.

#### Allocation/Deallocation

1. **Manual allocation** using `new/delete` or `malloc/free`.
2. Memory needs to be **explicitly deallocated** to avoid **leaks**.

#### Lifetime

1. Exists until **explicitly deallocated** by the programmer.
2. Remains available even after the function that allocated it exits, as long as the pointer is
   preserved.

#### Scope

1. **Global scope** if the pointer to allocated memory is retained.
2. Accessible from **anywhere** in the program through the pointer.

#### Size

1. **Predefined** to a default value according to the system but **can grow and shrink** as the
   application progresses.
2. Limited by **system memory** and subject to **fragmentation**.
3. Large allocations are possible, unlike the stack.

#### Structure

1. **Unstructured** memory, allocated and freed in any order.
2. Can lead to **fragmentation** if memory is not carefully managed.

#### Performance

1. **Slower** than stack due to non-contiguous memory and overhead of managing free space.
2. Fragmentation can impact performance over time.

#### Other Characteristics

1. Maintains **a free list** to check if there is free memory available for the application to use.
2. If there is **not enough heap memory**, it will ask the system to **allocate more memory**. The
   **performance cost** of this allocation is **high**.
3. **More cache misses**.

### Global/Static Memory or Data Segment

#### Purpose

1. Stores **global, static, and constant variables**.
2. Retains values throughout the **entire program lifecycle**.

#### Allocation/Deallocation

1. **Allocated at program startup** and **deallocated at program termination**.

#### Lifetime

1. Exists for the **entire duration** of the program.
2. Retains values across function calls.

#### Scope

1. **Global scope**: Accessible from any part of the program.

#### Size

1. Depends on the **size and number** of variables.
2. Limited by the **linker and system memory**.

#### Structure

1. Includes:

   - **Initialized Data Segment**: Stores variables with **explicit initial** values.
   - **BSS (Uninitialized Data Segment, Block Started by Symbol)**: Stores variables with **no
     initial** values, which are initialized to **zero by default**.

   - **Character Constant Area**: Stores **string literals** and **constants**.

2. Organized as **a continuous memory block** for static, global and const variables/values.

#### Performance

1. **Fast access** due to fixed memory locations.
2. Avoids runtime allocation overhead.

#### Other Characteristics

1. **Persistent values** can introduce side effects if not managed properly.
2. Typically **read-only** for constants to prevent accidental modification.

### Code Segment

#### Purpose

1. Stores **compiled instructions** (machine code) of the program.

#### Allocation/Deallocation

1. **Allocated at program startup** and remains until the program ends.
2. Managed by the **OS and loader**.

#### Lifetime

1. Exists for the **entire runtime** of the program.

#### Scope

1. Not applicable; **read-only** segment.

#### Size

1. Depends on the **size of the compiled code**.
2. Limited by **system memory** and linker constraints.

#### Structure

1. A **contiguous block** of machine instructions.
2. Organized for **sequential execution** by the CPU.

#### Performance

1. **Fast execution** due to CPU caching and sequential access.
2. Code segment is often **optimized** for cache utilization.

#### Other Characteristics

1. **Read-only** to prevent accidental or malicious modification.
2. Supports **function-level optimizations** during compilation.

### Memory Mapping Segment

#### Purpose

1. Used for **mapping files or shared libraries** into memory.
2. Enables efficient access to large files without loading them entirely into RAM.

#### Allocation/Deallocation

1. Managed by the **OS** using functions like `mmap`.
2. Deallocated when the **file is closed** or the mapping is removed.

#### Lifetime

1. Varies based on **file or library usage**.

#### Scope

1. Accessible globally from **any part** of the program.

#### Size

1. Depends on the **size of the mapped file or library**.

#### Structure

1. Divided into **read-only** and **read-write** segments.
2. Supports **lazy loading**, where only accessed portions are loaded.

#### Performance

1. **Efficient** for large files as only necessary parts are loaded.
2. Reduces memory usage compared to loading the entire file.

#### Other Characteristics

1. Enables **shared access** across processes for libraries or files.
2. Requires **OS-level support** for memory mapping.

### Memory Partitioning in C++ Program Execution

1. Stack vs. Heap: The stack is **fast** and **automatically managed**, but **limited in size**. The
   heap allows for more flexible memory usage at the cost of **manual management**.
2. Global/Static vs. Local: Global and static variables have global lifetimes, while local variables
   (on the stack) have a shorter scope, limited to the block they are declared in.

### Notes

1. store data on stack > store data on heap > store pointers on stack > store pointers on heap.

## Function

### 1) Explanation

1. In C++, a function is **a self-contained block of code** that **performs a specific task**. It
   can take input values, called parameters, process them, and optionally return a result.

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
   are called excessively or are very small, except in the case of an **inline** function.
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
ReturnType funcName( parameter_list ) {
   // function body
};
```

### 4) Declaration Syntax

```CPP
ReturnType funcName( parameter_list );
```

### 5) Reference Syntax

```CPP
funcName( argument_list );
```

```CPP
ReturnType var_name = funcName( argument_list );
```

### 6) How to Pass an Argument to a Function

1. **Primitive**-type arguments: Pass their **values** to the function.
2. **Class**-type, **struct**-type, and other **complex arguments**: Pass their **references or
   pointers** to the function.

### 7) Keywords Related to Functions

#### (1) `inline`

##### Purpose

1. Suggests to the compiler to replace the function call with the function body to reduce call
   overhead. Please note that this is **just a suggestion**. The compiler will decide whether or not
   to expand the inline function depending on the situation. If you want to force the compiler to
   unfold the function all the time, you should understand more about the compiler's behavior.

##### Example

```
inline int add( int a, int b ) { return a + b; }

int main() {
   int result = add( 5, 3 );   // Function call may be replaced with (5 + 3)
}
```

##### Advantages

1. Reduced function call overhead.
2. Fast execution.

##### Disadvantages

1. Code bloat.
2. Increased compilation time.
3. Debugging difficult.

#### (2) `virtual`

##### Purpose

1. Allows a member function in a base class to be overridden in derived classes, enabling
   **polymorphism**.

##### Example

```CPP
class Base {
   public:
      virtual void show() {   // Virtual function
         std::cout << "Base class show function called." << std::endl;
      }
};

class Derived: public Base {
   public:
      void show() override {   // Override base class function
         std::cout << "Derived class show function called." << std::endl;
      }
};

int main() {
   Base* b = new Derived();
   b->show();   // Calls Derived's show()
   delete b;
}
```

##### Characteristics

###### Summary

1. **Dynamic** binding: Virtual functions enable dynamic (or late) binding, meaning the function
   that gets called is determined at **runtime** based on the type of the object being referenced,
   not the type of the pointer/reference.
2. Base class declaration: To declare a function as virtual, you use the virtual keyword in the base
   class.
3. Overriding in derived classes: Derived classes can override virtual functions to provide their
   specific implementations.
4. **Base class pointers**: You can use a base class pointer to point to derived class objects. When
   you call a virtual function through the base class pointer, the derived class's version of the
   function is invoked.
5. Destructor: If a class contains **virtual functions**, it is a good practice to declare its
   **destructor as virtual**. This ensures that the derived class's destructor is called when an
   object is deleted through a base class pointer, preventing resource leaks.
6. Performance: Virtual functions introduce **a slight performance overhead** due to dynamic
   dispatch, as the program must look up the correct function to call at runtime. This is generally
   acceptable in exchange for the flexibility they provide.
7. Pure virtual functions: You can declare a virtual function as pure virtual by using `= 0`. This
   makes the **class abstract**, meaning it cannot be instantiated directly.

###### Advantages

1. **Polymorphism**: Virtual functions enable polymorphic behavior, allowing a program to treat
   objects of different derived classes through a base class pointer or reference. This makes it
   easier to write flexible and reusable code.
2. **Dynamic** binding: They provide dynamic (or late) binding, where the method that gets executed
   is determined at runtime based on the actual object type, rather than the type of
   reference/pointer. This allows for more dynamic and adaptable code structures.
3. Extensibility: Virtual functions make it easier to extend code. New derived classes can be added
   with their implementations of virtual functions without modifying existing code.
4. Interface Design: They allow the design of interfaces through abstract classes, promoting better
   software design practices. This encourages the implementation of consistent interfaces across
   different derived classes.
5. Improved code organization: By using virtual functions, you can organize your code better,
   separating interface from implementation and promoting code clarity and maintenance.

###### Disadvantages

1. Performance overhead: Virtual functions introduce **a performance penalty** due to the dynamic
   dispatch mechanism. The program must go through the **V table** to look up the correct function
   to call at runtime, which can be slower than static binding.
2. **Memory overhead**: Each class that uses virtual functions typically includes **a virtual table
   (vtable)**, which adds some memory overhead. Each object of such classes contains a pointer to
   the vtable, increasing the size of the object.
3. Complexity: The use of virtual functions can increase the complexity of code, particularly for
   developers who are not familiar with object-oriented principles. Understanding how virtual
   functions work is crucial to avoid pitfalls like object slicing.
4. **Debugging Challenges**: Debugging issues related to virtual functions can be more challenging,
   especially when it comes to understanding the flow of execution and object lifetimes in the
   presence of polymorphism.
5. Potential for Resource Leaks: If a base class has virtual functions, its destructor should also
   be virtual to ensure proper cleanup of derived class resources. Failing to declare a virtual
   destructor can lead to resource leaks.

###### Notes

1. In cases where performance is very important, you should avoid using virtual functions as much as
   possible.

#### (3) `override`

##### Purpose

1. Indicates that a member function is intended to override a virtual function in a base class,
   providing **better error checking**.

##### Example

```CPP
class Base {
   public:
      virtual void display() { std::cout << "Base display" << std::endl; }
};

class Derived: public Base {
   public:
      void display()
         override {   // Ensures that this function overrides a base class function
         std::cout << "Derived display" << std::endl;
      }
};
```

##### Notes

1. You should always use the override keyword when overriding functions in a derived class, as it
   helps prevent errors.

#### (4) `final`

##### Purpose

1. Prevents further overriding of a virtual function in derived classes or **prevents a class from
   being inherited**.

##### Example

```CPP
class Base {
   public:
      virtual void show() final {   // Cannot be overridden
         std::cout << "Base show function." << std::endl;
      }
};

class Derived: public Base {
   public:
      // void show() override {}  // Error: cannot override final function
};
```

#### (5) `const`

##### Purpose

1. Indicates that a member function does **not modify** any member variables of the class.

##### Example

```CPP
class Counter {
public:
    int count;
    Counter(int c) : count(c) {}

    int getCount() const { // Const member function
        return count; // This function cannot modify class members
    }
};
```

#### (6) `static`

##### Purpose

1. Indicates that the function can be called without an instance of the class; it has internal
   linkage in a **global** context.

##### Example

```CPP
class MyClass {
   public:
      static void staticFunction() {   // Static member function
         std::cout << "Static function called." << std::endl;
      }
};

int main() {
   MyClass::staticFunction();   // Call static function without an instance
}
```

#### (7) `explicit`

##### Purpose

1. **Prevents implicit conversions and copy-initializations** that could lead to unexpected behavior
   or subtle bugs.

##### Example

```CPP
class MyClass {
   public:
      explicit MyClass( int x ) { /* constructor */
      }
};

void doSomething( MyClass obj ) {
   // do something
}

int main() {
   // doSomething(42);  // Error: no implicit conversion
   doSomething( MyClass( 42 ) );   // Explicit conversion is required
}
```

#### (8) `friend`

##### Purpose

1. Grants access to the class's **private and protected** members to a specific function or class.

##### Example

```CPP
class MyClass {
   private:
      int _secret;

   public:
      MyClass(): _secret( 42 ) {}

      friend void revealSecret( MyClass& obj );   // Friend function declaration
};

void revealSecret( MyClass& obj ) {   // Friend function definition
   std::cout << "Secret: " << obj._secret
             << std::endl;   // Access private member
}

int main() {
   MyClass obj;
   revealSecret( obj );   // Accesses the private member
}
```

#### (9) `template`

##### Purpose

1. Allows the creation of generic functions or classes that can operate with **any data type**.

##### Example

```CPP
template< typename T > T add( T a, T b ) { return a + b; }

int main() {
   std::cout << "Int addition: " << add( 5, 3 )
             << std::endl;   // Calls add<int>
   std::cout << "Double addition: " << add( 5.5, 3.2 )
             << std::endl;   // Calls add<double>
}
```

#### (10) `constexpr`

##### Purpose

1. Specifies that the function can be **evaluated at compile time**, allowing for constant
   expressions.

##### Example

```CPP
constexpr int square( int x ) {
   return x * x;   // Can be evaluated at compile time
}

int main() {
   constexpr int value = square( 5 );   // Compile-time evaluation
   std::cout << "Square: " << value << std::endl;
}
```

#### (11) `noexcept`

##### Purpose

1. Indicates that a function does **not throw exceptions**, allowing the compiler to **optimize**
   calls to the function.

##### Example

```CPP
void safeFunction() noexcept {   // Indicates no exceptions will be thrown
                                 // Function implementation
}

int main() { safeFunction(); }
```

#### (12) `using`

##### Purpose

1. Brings a base class's function into the derived class's scope, especially useful for overloaded
   functions.

##### Example

```CPP
class Base {
   public:
      void show() { std::cout << "Base show" << std::endl; }

      void show( int i ) {
         std::cout << "Base show with int: " << i << std::endl;
      }
};

class Derived: public Base {
   public:
      using Base::show;   // Bring Base::show into scope

      void show( double d ) {   // Overload in Derived
         std::cout << "Derived show with double: " << d << std::endl;
      }
};

int main() {
   Derived d;
   d.show();         // Calls Base::show()
   d.show( 10 );     // Calls Base::show(int)
   d.show( 10.5 );   // Calls Derived::show(double)
}
```

#### (13) `decltype`

##### Purpose

1. Determines the type of an expression at **compile time**, often used with function templates.

##### Example

```CPP
template< typename T > decltype( auto ) func( T&& arg ) {
   return arg;   // The return type is deduced based on the type of arg
}
```

#### (14) `asm` or `__asm`

##### Purpose

1. Allows embedding **assembly code** within a C++ function.

##### Example

```CPP
void asmFunction() {
   asm( "movl $1, %eax" );   // Simple assembly instruction
}

int main() { asmFunction(); }
```

### 8) The Difference Between Hiding, Overloading, Overriding, and Overwriting

#### (1) Hiding (Name Hiding)

##### Explanation

1. Hiding occurs when **a derived class** declares a function (or variable) with **the same name**
   as a function (or variable) in **the base class**, regardless of the parameters. The base class
   function is hidden in the derived class scope, even if the signatures (parameter types) differ.
   This can lead to confusion or errors because the base class function is no longer accessible
   directly from the derived class.

##### Example

```CPP
class Base {
   public:
      void show() { std::cout << "Base class show" << std::endl; }
};

class Derived: public Base {
   public:
      void show( int x ) {
         std::cout << "Derived class show with a value " << x << std::endl;
      }
};

int main() {
   Derived d;
   d.show();   // Error: Base::show() is hidden by Derived::show(int)
}
```

##### How to Access Hidden Function

```CPP
   d.Base::show();   // Calls Base class show()
```

#### (2) Overloading

##### Explanation

1. Overloading occurs when **two or more functions** in **the same scope** have **the same name**
   but **different parameter types or numbers of parameters**. Additionally, **a normal function and
   a const function** can be considered overloaded in C++. However, **the return type does not**
   play a role in distinguishing overloaded functions; you cannot overload functions solely based on
   different return types. Overloading is resolved at compile time (static polymorphism). C++ allows
   overloading based on the number of arguments, their types, or both.

##### Example

```CPP
class Example {
   public:
      void func( int x ) {
         std::cout << "Function with int: " << x << std::endl;
      }

      void func( double x ) {
         std::cout << "Function with double: " << x << std::endl;
      }

      void func( int x, double y ) {
         std::cout << "Function with int and double: " << x << ", " << y
                   << std::endl;
      }
};
```

#### (3) Overriding

##### Explanation

1. Overriding occurs when **a derived class** provides **its own implementation** of **a virtual
   function ( or a pure virtual function )** that is **already defined** in the base class. The
   function in the derived class must have **the same signature** as the base class's virtual
   function. Overriding is resolved at runtime (dynamic polymorphism).

##### Example

```CPP
class Base {
   public:
      virtual void show() { std::cout << "Base class show" << std::endl; }
};

class Derived: public Base {
   public:
      void show() override {   // This function overrides Base::show
         std::cout << "Derived class show" << std::endl;
      }
};

int main() {
   Base* obj = new Derived();
   obj->show();   // Calls Derived class show (runtime polymorphism)
}
```

#### (4) Overwriting (Not a C++ Term)

##### Explanation

1. Overwriting is **not a formal term in C++**. However, it is sometimes colloquially used to
   describe a situation where **a function or variable in a derived class replaces or redefines a
   function or variable from a base class**. This serves as a general description rather than a
   specific C++ concept. Additionally, the term "overwriting" typically refers to the process of
   **replacing an existing value in memory**, which includes assigning a new value to an existing
   variable to replace the old value and writing data to unintended memory locations, often
   resulting in undefined behavior or memory corruption. This can occur in various contexts, such as
   variables, function definitions, or data structures.

##### Example

```CPP
class Base {
   public:
      int _x = 10;
};

class Derived: public Base {
   public:
      int _x = 20;   // Overwrites Base::x
};
```

### 9) Function Pointers

#### Explanation and Usage

1. A function pointer is **a variable** that **stores the address of a function** in C or C++.
2. It allows you to call a function indirectly through its pointer, enabling dynamic function calls
   and making it possible to implement callback mechanisms.

#### (1) Declaration and Definition Syntax

```CPP
   // The implicit conversion occurs.
   auto func_ptr_name = funcName;
```

```CPP
   // This syntax is equivalent to the syntax mentioned above.
   // The implicit conversion does not occur.
   auto func_ptr_name = &funcName;
```

```CPP
   // This syntax is equivalent to the syntax mentioned above.
   // The implicit conversion occurs.
   ReturnType ( *func_ptr_name )( parameter_type_list ) = funcName;
```

```CPP
   // This syntax is equivalent to the syntax mentioned above.
   // The implicit conversion does not occur.
   ReturnType ( *func_ptr_name )( parameter_type_list ) = &funcName;
```

#### (2) Declaration and Assignment Syntax

```CPP
   ReturnType ( *func_ptr_name )( parameter_type_list );
   // The implicit conversion occurs.
   func_ptr_name = funcName;
```

```CPP
   // This syntax is equivalent to the syntax mentioned above.
   // The implicit conversion does not occur.
   ReturnType ( *func_ptr_name )( parameter_type_list );
   func_ptr_name = &funcName;
```

#### (2) Syntax for Function Calls Using Function Pointers

```CPP
   // A function whose return type isn't `void`
   auto result = func_ptr_name( arguement_list );
```

```CPP
   // This syntax is equivalent to the syntax mentioned above.
   ReturnType result = func_ptr_name( arguement_list );
```

```CPP
   // A function whose return type is `void`
   func_pt_name( arguement_list );
```

#### (3) Syntax for Function Pinter Declaration Using `typedef`

```CPP
   typedef ReturnType ( *FuncPtrName )( parameter_types );
   FuncPtrName func_ptr_name;
```

#### (4) Syntax for Function Pinter Declaration Using `using`

```CPP
   using FuncPtrName = ReturnType ( * )( parameter_types );
   FuncPtrName func_ptr_name;
```

### 10) Lambda Functions

#### Why Use Lambda Functions

1.  If functionA wants to call functionB **at a particular point**, you could pass a pointer to
    functionB into functionA. However, using traditional method to implement functionB may be
    **overkill**, so you should use a lambda instead.
2.  Some **C++ standard libraries require** function pointers; you can pass a lambda as a pointer to
    them.

#### Explanation

1. A lambda function in C++ is a way to define **an anonymous inline function** (i.e., a function
   without a name) directly in your code. It allows you to create small, simple function-like
   entities inline, making your code more concise and flexible.

#### Syntax

##### Code for Passing It as a Variable

```CPP
   [capture]( parameters ) -> ReturnType { body };
```

##### Code for Defining It as a Function

```CPP
   auto functionName =  [capture]( parameters ) -> ReturnType { body };
```

#### Explanation

1. capture: Specifies which variables from the surrounding scope are captured by the lambda. This
   can be done by value (=) or by reference (&).
2. parameters: The parameters for the lambda function, similar to any regular function.
3. ReturnType (**optional**): The return type of the lambda. If omitted, C++ will attempt to deduce
   it automatically.
4. body: The function body where the logic of the lambda resides.

#### Capture Clause

##### Explanation

1. Capture by value (`=`): Copies the variable and makes it accessible inside the lambda.
2. Capture by reference (`&`): Allows the lambda to modify the variable in the outer scope.
3. Default capture: Default capture in a lambda function allows you to specify how variables from
   the surrounding scope are captured **without explicitly listing each one**. You can set **a
   default capture mode for all variables**, which **can be overridden for specific variables** if
   needed.

##### Example 1: Capture Nothing

```CPP
   auto functionName =  []( parameters ) -> ReturnType { body };
```

##### Example 2: A Default Capture Mode `[=]` - Capture All Variables by Value

```CPP
   // A default capture mode[=]: captures all variables by value.
   auto functionName =  [=]( parameters ) -> ReturnType { body };
```

##### Example 3: A Default Capture Mode `[&]` - Capture All Variables by Value

```CPP
   // A default capture mode[&]: captures all variables by value.
   auto functionName =  [&]( parameters ) -> ReturnType { body };
```

##### Example 4: Specify Some Variables Captured by Value

```CPP
   auto functionName =  [var1, var2, ...]( parameters ) -> ReturnType { body };
```

##### Example 5: Specify Some Variables Captured by Reference

```CPP
   auto functionName =  [&var1, &var2, ...]( parameters ) -> ReturnType { body };
```

##### Example 6: Specify Some Variables Captured by Reference and Others by Value

```CPP
   // In the capture list, the default capture must appear first.
   auto functionName =  [=, &var1, &var2, ...]( parameters ) -> ReturnType { body };
```

##### Example 7: Specify Some Variables Captured by Value and Others by Reference

```CPP
   // In the capture list, the default capture must appear first.
   auto functionName =  [&, =var1, =var2, ...]( parameters ) -> ReturnType { body };
```

##### Example 8: Specify Some Variables Captured by Reference and Some by Value

```CPP
   auto functionName =  [&var1, &var2, ..., varn1, varn2, ...]( parameters ) -> ReturnType { body };
```

## enum

### Explanation

1. In C++, an enum (short for "enumeration") is **a user-defined type** that consists of **a set
   of** named integral **constants**, providing a way to define a collection of related constants
   with meaningful names. Enumerations improve code readability by replacing numeric values with
   descriptive names.

### Purpose

1. If you need to represent some states with integers, you can use an enum to group and represent
   them.

### Examples of Unscoped Enumeration

```CPP
enum Color {
   Red,         // 0
   Green = 3,   // 3
   Blue         // 4
};

Color myColor = Green;
```

### Examples of Scoped Enumeration ( C++11 )

```CPP
enum class Color : char {
   Red = 'r',
   Green = 'g',
   Blue = 'b'
};

Color myColor = Color::Green;
```

### The Difference Between `enum` ( Unscoped Enumeration ) and `enum class` ( Scoped Enumeration )

#### 1) Syntax

#### 2) Namespace Scoping

1.  `enum`: Enum values injected into enclosing scope.
2.  `enum class`: Enum values scoped within the enum type.

#### 3) Type Safety

1.  `enum`: Implicitly converts to int.
2.  `enum class`: No implicit conversions.

#### 4) Underlying Type

1.  `enum`: Cannot specify underlying type explicitly.
2.  `enum class`: Can specify underlying type (e.g., `enum class Color : unsigned int`).

#### 5) Forward Declaration

1.  `enum`: Not allowed.
2.  `enum class`: Allowed.

#### 6) Bitwise Operations

1. `enum`: Allowed without extra effort.
2. `enum class`: Not allowed without operator overloading.
