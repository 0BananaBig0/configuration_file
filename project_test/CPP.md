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

### 1) Declaration

#### General Explanation

1. Introduces **a name and type without allocating storage or providing an implementation**. It
   merely states that a function, class, struct, variable, instance, or template exists without
   concerning itself with a definition.

#### Forward Declaration

1.  It is **a declaration** of a class, function, or variable that **informs the compiler of its
    existence without providing the full definition** at that point. It allows the compiler to
    handle references to an entity (e.g., a class or a function) without needing to know all the
    details at that time. The complete definition is provided later in the code. be instantiated.

### 2) Definition

1.  A definition **provides a body** that implements a function, class, variable, struct, instance,
    or template. It includes **an actual implementation and allocates storage** for variables or
    instances.

### 3) Parameter

1.  A parameter is **a variable declared in a function definition**. It serves as a placeholder for
    the values that will be passed to the function when it is called. Parameters are used to receive
    input values within the function and specify the type of data the function expects.

### 4) Argument

1.  An argument is **an actual value, structure, instance, pointer, or reference passed to the
    function** when it is called. Arguments are the specific data supplied to the function's
    parameters.

### 5) Interface

1. In C++, the term "interface" does **not have a formal definition** like it does in some other
   programming languages (like Java). However, in C++, an interface is generally understood to be
   **a class that defines a set of pure virtual functions**, which means that it declares functions
   that must be implemented by derived classes but does not provide any implementation of its own.

### 6) Pointers and References

#### Pointers

1. In C++, a pointer is **a variable** that **stores the memory address of another variable**.
   Pointers enable dynamic memory allocation, efficient array handling, and the ability to pass
   large data structures to functions without copying them.

#### Reference

1. In C++, a reference is **an alias for an existing variable**. It allows you to create **another
   name for a variable** without making a copy of it. References are declared using an ampersand (&)
   in the declaration.
2. A reference **must be initialized** when it is declared and cannot be changed to refer to another
   variable later.
3. Unlike pointers, references **cannot be null**. They must always refer to a valid object.

## Some Small Knowledge

1. The performance of < is better than <=.
2. `std::endl` is a little slower than `"\n"` in debug mode. Otherwise, `std::endl` is faster.

## Memory Partitions

### Stack

1. Stores **local** variables and function call information (such as return addresses and
   parameters). The data stored in the stack is **lost** when it goes **out of scope**.
2. Follows a Last In, First Out (**LIFO**) structure. Stores data like an actual stack, pushing data
   into the stack and returning the stack pointer.
3. Memory **allocation** and **deallocation** happen **automatically** when functions are called and
   return. Allocating memory for data on the stack requires **only one CPU instruction**.
4. Its **size** is **predefined** to a default value according to the system and **cannot grow**.
5. Data stored on the stack are close together in memory, and therefore they can generally **fit
   onto one CPU cache line**.
6. **Fewer cache misses**.

### Heap (Dynamic Memory)

1. Used for dynamic memory allocation, which is **managed manually** by the programmer using new and
   delete.
2. Allows for variable-sized allocations that persist until explicitly deallocated.
3. Its **size** is **predefined** to a default value according to the system but **can grow and
   shrink** as the application progresses.
4. It maintains **a free list** to check if there is free memory available for the application to
   use.
5. If there is **not enough heap memory**, it will ask the system to **allocate more memory**. The
   **performance cost** of this allocation is **high**.
6. **More cache misses**.

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

### Notes

1. store data on stack > store data on heap > store pointers on stack > store pointers on heap.

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

##### Features

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

1. In cases where performance is very important, we should avoid using virtual functions as much as
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
   specific C++ concept. Additionally, the term "overwriting" typically refers to **the process of
   replacing an existing value in memory**. This can occur in various contexts, such as variables,
   function definitions, or data structures.

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

## enum

### Explanation

1. In C++, an enum (short for "enumeration") is a user-defined type that consists of a set of named
   integral constants, providing a way to define a collection of related constants with meaningful
   names. Enumerations improve code readability by replacing numeric values with descriptive names.

### Purpose

1. If we need to represent some states with integers, we can use an enum to group and represent
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
