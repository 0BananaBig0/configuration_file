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

##### Characteristics

1. **A name** (identifier) is required.
2. **A type** is specified (determining the kind of value it can hold).
3. It **occupies memory** in the program.

#### Instance

##### Explanation

1. An instance is **a concrete occurrence** of **a particular data type**. This term is most
   commonly used in the context of user-defined types like **classes or structs**. When you create
   an instance of a class, you're creating an object of that class type.

##### Characteristics

1. Refers to **a specific occurrence** of **a class or struct**.
2. Instances of a class are often **called objects**.

#### Object

##### Explanation

1. An object is **a region of memory** that **has a type, value**, and, **in most cases, a name
   (optional)**. Every variable is an object, and every instance of a class is also an object. The
   term object is **more general** and refers to any instance of a type that occupies memory,
   whether it’s built-in (like int, double) or user-defined (like a class).
2. An object is **generally** defined as **an instance** of a data type that **occupies memory** and
   **has attributes (data members) and behaviors (methods)** when it comes to **user-defined types
   (classes)**.
3. For **built-in types** (like int, char, etc.), the term "object" can **also apply**.

##### Characteristics

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

1. A pointer is **a variable** that **stores the memory address of another variable**.
2. Pointers enable **dynamic memory allocation**, efficient array handling, and the ability to pass
   large data structures to functions without copying them.

#### Reference

1. A reference is **an alias for an existing variable**. It allows you to create **another name for
   a variable** without making a copy of it. References are declared using an ampersand (`&`) in the
   declaration.
2. A reference **must be initialized** when it is declared and cannot be changed to refer to another
   variable later.
3. Unlike pointers, references **cannot be null**. They must always refer to a valid object.
4. A reference is defined as a type. However, I believe it is **merely an alias**, not a distinct
   type, because `auto` cannot deduce a type as a reference without using `&`.
5. A reference is **neither a variable nor an object**.

### 5) Parameter

1.  A parameter is **a variable declared in a function definition**. It serves as a placeholder for
    the values that will be passed to the function when it is called.
2.  Parameters are used to **receive input values** within the function and specify the type of data
    the function expects.

### 6) Argument

1.  An argument is **an actual value, variable, object or reference passed to the function** when it
    is called. Arguments are the specific data supplied to the function's parameters.

### 7) Expression

#### Explanation

1. An expression is **any valid combination of variables, literals, operators, or function calls**
   that **evaluates to a value**. Expressions are the building blocks of C++ programs and can range
   from simple values like `42` to complex operations involving multiple variables and function
   calls. They are **evaluated at runtime** to produce a result, which may or may not be used
   further in the program.

#### Types of Expressions in C++

1. Literal Expressions
   - A literal (such as `42`, `a`, or `3.14`) is the simplest form of an expression. It evaluates to
     its own value.
2. Variable Expressions
   - A variable by itself is also an expression, and it evaluates to the value it stores. For
     example,
     ```CPP
     int x = 10;
     x; // Evaluates to 10.
     ```
3. Arithmetic Expressions
   - These use arithmetic operators (`+`, `-`, `*`, `/`, `%`) to produce numeric results. For
     example,
     ```CPP
     int y = 5 + 3 * 2; // Evaluates to 11.
     ```
4. Logical and Relational Expressions
   - Logical expressions (`&&`, `||`, `!`) produce a boolean result.
   - Relational expressions (`==`, `!=`, `<`, `>`, `<=`, `>=`) compare values and return true or
     false. For example,
     ```CPP
     bool result = (x > 0) && (y < 10); // Evaluates to true.
     ```
5. Assignment Expressions
   - An assignment operation is also an expression that returns the assigned value. For example,
     ```CPP
     int z;
     z = 20; // Evaluates to 20.
     ```
6. Function Call Expressions
   - A function call acts as an expression, with the result being the return value of the function.
     For example,
     ```CPP
     int absValue = std::abs(-5); // Evaluates to 5.
     ```
7. Conditional (Ternary) Expressions
   - A ternary expression evaluates a condition and returns one of two values based on the result.
     For example,
     ```CPP
     int max = (x > y) ? x : y; // Returns x if x > y, otherwise y.
     ```
8. Member Access Expressions
   - Accessing a member of an object or a struct is also an expression. For example,
     ```CPP
     struct Point { int x, y; };
     Point p = {3, 4};
     p.x; // Evaluates to 3.
     ```
9. Pointer Expressions
   - Dereferencing a pointer or using the & operator to take the address of a variable forms an
     expression. For example,
     ```CPP
     int* ptr = &x; // Evaluates to the address of x.
     *ptr; // Evaluates to the value of x (10).
     ```

### 8) Lvalue and Rvalue: Value Categories in C++

#### Lvalue (Left Value)

1. Refers to **an object or memory location** that **persists** beyond a single expression and
   occupies some **identifiable location** in memory (i.e., it has an address).
2. **Can** appear on the **left side** or the **right side** of an assignment
3. **Typically** refers to **variables**, **array elements**, or **dereferenced pointers**.
4. **Can take the address** of an lvalue using the address-of operator (`&`).

#### Rvalue (Right Value)

1. Refers to **temporary objects or values** that do **not persist** beyond the expression in which
   they are used and **does not have a specific location in memory** (it cannot be assigned a memory
   address).
2. **Cannot** appear on the **left-hand side** of an assignment.
3. **Examples** include **literals**, **temporary results** of expressions, and **return values** of
   functions without `&`.

#### Lvalue Reference (`Type&`)

##### Explanation

1. An lvalue reference is **a reference to a persistent object** (i.e., an object with a
   well-defined memory address, such as variables or class members). It binds only to lvalues —
   objects that can appear on the left side of an assignment.

##### Usage

1. **Modify the value** of an existing object.
2. **Pass objects** by reference to functions, **avoiding unnecessary copying**.

##### Notes

1. A **normal** reference **can't** store an **rvalue** **but** a **const reference can**. A
   **normal reference parameter** of a function **can't** accept **an rvalue** **but** a **const
   reference parameter can**.

#### How to Identify Whether a Value is an Lvalue or an Rvalue

1.  Define a normal reference for a value, if it can be store by a referenc, it is an lvalur.
    Otherwise, it is an rvalue.

#### Rvalue Reference (`Type&&`)

##### Explanation

1. An rvalue reference is **a reference to a temporary object (an rvalue)** that is about to expire.
   It can **bind only to rvalues**, such as the result of expressions or moved objects (e.g., via
   `std::move`). This makes rvalue references ideal for **move semantics**, allowing efficient
   transfer of resources.

##### Usage

1. Implement **move constructors** and **move assignment operators** to **avoid unnecessary
   copying**.
2. **Optimize performance** by transferring resources from one object to another.

#### Move Semantics

##### Explanation

1. Move semantics, introduced in C++11, **optimizes** program **performance** by transferring
   resources from one object to another instead of copying them. It uses **rvalue references**
   (`Type&&`) to **efficiently** move resources, such as dynamically allocated memory, from
   **temporary** or **"expired" objects** without incurring **the overhead of deep copies**.
2. Essentially, move semantics functions like **assigning one pointer to another**. Rather than
   copying data, **ownership** of the resources is transferred between objects, **reducing
   unnecessary copying** and **enhancing performance**.

##### Usage

1. **Rvalue references** (`Type&&`) bind to **temporary** or **"soon-to-expire" objects**.
2. These references allow you to **move resources**, **leaving the original object** in a valid but
   empty state.
3. The compiler may **optimize your code** when you use move semantics in **move constructors**,
   **move assignment operators**, and when **returning objects by value**.

#### `std::move`

##### Explanation

1. A utility function that **casts an object to an rvalue reference**, **enabling move semantics**.
2. It does **not perform any movement** itself **but indicates** that the object can be moved.

##### Usage

1. Everytime, if you want to assign **an object** that you want to **remove** after assigning to a
   variable, you can use `std::move`.
2. To deal with **double deletion**, **the original pointer** should point a **nullptr** after
   **`std::move`** moved its data to another pointer.

### 9) Interface

1. In C++, the term "interface" does **not have a formal definition** like it does in some other
   programming languages (like Java). However, in C++, an interface is generally understood to be
   **a class** that **defines a set of pure virtual functions**, which means that it declares
   functions that **must be implemented by derived classes** but does **not provide any
   implementation of its own**.

### 10) Keyword

1. A keyword is **a reserved word** that has a predefined meaning in the language and **cannot be
   used as an identifier** (such as a variable name, function name, etc.). Keywords are part of the
   C++ syntax and represent fundamental constructs or operations in the language.

### 11) Type Specifier

1. A type specifier is **used to define the type of a variable, function return value, or object**.
   Type specifiers tell the compiler what kind of data the variable will hold or the function will
   return. They are an essential part of variable declarations and type definitions.

## Some Small Knowledge

1. The performance of < is better than <=.
2. `std::endl` is a little slower than `"\n"` in debug mode. Otherwise, `std::endl` is faster.
3. Function argument evaluation order: Undefined. Differenct compilers with different flags have
   different evaluation orders, until C++17, an uncomplete definiton of the function argument
   evaluation order comes.

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

## `auto` and `decltype`

### `auto`

#### Explanation

1. `auto` is **a type specifier** that allows the compiler to **automatically deduce the type** of
   **a variable from its initializer**.
2. This feature, introduced in C++11, is especially useful for **simplifying complex type
   declarations, avoiding redundancy, and making code more readable**.

#### Syntax

```CPP
auto var_name = initializer;
```

#### Usage

1. Variable declarations: Declare variables without specifying their type.
2. Simplifying complex types.
3. Range-Based for Loops. For example, `for( auto var_name : object_name )`.
4. Lambda expressions.
5. Using `auto` with structured bindings. For example `for( auto [x, y] : object_pair_name )`.
   - Structured bindings, introduced in C++17, provide a way to unpack tuple-like objects (such as
     `std::pair`, `std::tuple`, and user-defined types with `std::get`) into individual named
     variables.

#### Characteristics

1. Type deduction: The type is **determined at compile time**a.
2. Copy behavior: auto creates **a copy of the original type** unless specified otherwise (e.g.,
   auto& for lvalue references).
3. Const qualifiers: If initialized with **a const value**, auto **deduces a non-const type**.
4. Initializer lists: When initialized with an initializer list, auto deduces the type to be the
   corresponding container type (e.g., `std::initializer_list`).
5. Type safety: auto maintains type safety by ensuring that the deduced type matches the
   initializer.
6. Simplicity: Reduces verbosity, especially for complex types like iterators or function objects.

#### Notes

1. `auto` can deduce whether a reference is `const` based on the initializer variable. However, for
   non-reference types, `auto` only deduces the type without adding `const`. Therefore, if you want
   variables **deduced with `auto` to be `const`**, you'd better **explicitly specify `const`**.
2. `auto` can deduce whether a type is a pointer based on the initializer.
   `auto var_name = ptr_name;` `<=>` `auto* var_name = ptr_name; \\ **Better**` However, if you use
   `auto` to **deduce a type with a pointer** as the initializer, you'd better **specify it
   explicitly with a star ( `*` )**.
3. `auto` **cannot deduce** whether a type is **a reference** based on the initializer. Therefore,
   If you want the type to be deduced as a reference, **specify it explicitly with `&`**.
   `auto & var_name = ini_name;`
4. Specifically, if the initializer is **a const char pointer** or **a const char array** (such as a
   string literal, "xxx"), auto deduces the variable to be **a const char pointer**.
5. If you **change the return types of your functions or APIs**, `auto` can help us reduce the
   amount of code that needs to be modified. However, the code will become less readable, and some
   bugs may occur because the compiler will not tell us where changes are needed to adapt to these
   new functions. Therefore, you should **avoid using `auto` in this case**.
6. **Use `auto`** when working with **an iterator**, as it can make the code more readable.
7. When calling a function whose **return type has a long name**, you can **use `auto`** to make the
   code more readable.

### `decltype`

#### Explanation

1. **A keyword** allows you to **query the type of an expression** at **compile time** **without
   evaluating it**. This is particularly useful in **template programming** and situations where
   **types are complex or unknown**.

#### Syntax

```CPP
decltype(expression)
```

#### Usage

1. Type deductions: Determine the type of a variable based on another variable.
2. Type deduction in templates.
3. Defining function pointers.
4. Use `decltype` to deduce return types of functions.
5. Using with `auto`.

#### Characteristics

1. The inference result is a **reference type** if the expression is an lvalue enclosed in
   parentheses.
2. Otherwise, the inference result is **the the actual type** of the expression.
3. No evaluation: `decltype` does **not evaluate the expression**; it merely inspects it to
   determine the type.
4. Type safety: Ensures that the deduced type is consistent with the expression, aiding in type-safe
   code.

#### Notes

1. **Use `decltype(expression)&`** instead of `decltype(expression)`, `decltype((expression))`, or
   `decltype((expression))&` if you want to deduce a result as **a reference type**, even if the
   expression is already a reference. Although these four expressions yield the same inference
   result, the first option is preferred.
2. **Add `const`** as a prefix to `decltype(expression)` if you want to **deduce a result as a const
   type**, even if the expression is already a const type.
3. **Use `decltype(expression)`** instead of `decltype(expression)*`, `decltype((expression))`, or
   `decltype((expression))*` if the expression is **a pointer**; the latter three do not yield the
   same inference result as the former.

## `using` and `typedef`

### `using`

#### Explanation

1. `using` is **a keyword** and has multiple uses, each serving a different purpose depending on the
   context. It can be used for **type aliasing**, **namespace introduction (not recommend)**, and
   **template aliasing**. It offers more flexibility compared to `typedef`, particularly when
   working with templates.

#### Syntax

```
using YourTypeName = Type;
```

#### Usage

1. Syntax simplicity.
2. Template aliases.
3. Function pointer declaration.
4. Alias for member types in classes.

### `typedef`

#### Explanation

1. `typedef` is **a keyword** used to **create an alias for a data type**, allowing you to define
   new names for existing types. This can improve code readability, simplify complex type
   definitions, and enhance maintainability by making it easier to manage changes in data types
   throughout your code.

#### Syntax

```CPP
typedef Type YourTypeName;
```

#### Usage

1. Syntax simplicity.
2. Function pointer declaration.
3. Alias for member types in classes.

## 'const', 'constexpr' and 'static'

### 1) `const`

#### Explanation

1. The `const` keyword in C++ is used to declare variables whose values cannot be changed after
   their initial assignment. This ensures that the variable remains constant for its lifetime,
   preventing accidental modifications.

#### Usage

##### (1) Const Variables

###### Syntax

`const Type var_name = value;`

###### Explanation

1. This declares a variable of type `Type` that cannot be reassigned after initialization.

##### (2) Const Pointers

###### Syntax

1. Pointer to constant value: `const Type* ptr_name;`
2. Constant pointer: `Type* const ptr_name;`

###### Explanation

1. `const Type* pointer_name;` means the value pointed to cannot be altered through this pointer.
2. `Type* const pointer_name;` means the pointer address itself cannot be changed after it is
   initialized.

##### (3) Const Member Functions

###### Syntax

```CPP
ReturnType functionName() const;
```

###### Explanation

1. Marks a member function that will not modify any member variables of the class or object.

##### (4) Const Function Parameters

###### Syntax

```CPP
void functionName( const Type param1, ... );
```

###### Explanation

1. This specifies that the function cannot modify the parameter `param` within its body.

##### (5) Const Return Values

###### Syntax

```CPP
const ReturnType functionName( ... ) {
    // Function body
}
```

###### Explanation

1. Returning a `const` value from a function indicates that the returned value cannot be modified by
   the caller.
2. However, if we assign a `const` return value to a non-const variable, we can modify the variable
   after the assignment is complete.

##### (6) Const Return Pointers

###### Syntax

```CPP
const returnType* functionName() {
    // Function body
}
```

###### Explanation

1. A function can return a pointer to a constant value, ensuring that the value being pointed to
   cannot be modified through the pointer.
2. If we want to assign a `const` return pointer to a variable, that variable must also be a pointer
   to `const`.

##### (7) Const Return References

###### Syntax

    ```CPP
    const returnType& functionName() {
        // Function body
    }
    ```

###### Explanation

1. A function can return a reference to a constant object, allowing efficient access to the object
   while ensuring it cannot be modified.
2. If we want to assign a `const` return reference to a variable, that variable must also be a
   `const` reference.

#### Characteristics

1. Ensures immutability at runtime; the variable’s value cannot change once set.
2. Enhances code readability; it clearly indicates which variables should not be altered.
3. Applicable to built-in types, class types, and can also be used with pointers.
4. Just a promise that we should keep something constant, but we can still break it.

### 2) `constexpr`

#### Explanation

1. The `constexpr` keyword is used to declare variables and functions that can be evaluated at
   compile-time. This feature allows the compiler to perform calculations and allocate memory for
   certain constructs even before the program runs.

#### Usage

##### (1) Constexpr Variables

###### Syntax

`constexpr Type var_name = value;`

###### Explanation

1. This declares a variable that must be initialized with a value that can be fully resolved at
   compile-time.

##### (2) Constexpr Functions

###### Syntax

```CPP
constexpr ReturnType functionName( parameters ) {
    // Function body
}

constexpr ReturnType var_name = functionName( ... );
```

###### Explanation

1. This declares a function that will be evaluated at compile-time if given compile-time constant
   arguments.

##### (3) Constexpr Constructors (C++11 and later):

###### Syntax

```CPP
class ClassType {
   public:
      // Initialize member variables at compile-time.
      constexpr ClassType( ... ): ... {};

   private:
      ...
};

constexpr ClassType obj_name( ... );
```

###### Explanation

1. This syntax defines a `constexpr` constructor that can be used to create instances of the class
   with constant expressions.

#### Characteristics

1. Enforces that certain values and calculations can be performed at compile-time, leading to
   significant performance improvements.
2. Must be assigned values that are determined at compile-time—this typically includes literal types
   or types with their own `constexpr` functions.
3. Enhances code readability by indicating that certain computations can be computed during
   compilation.

### 3) `static`

#### Explanation

1. The `static` keyword in C++ is used to change the storage duration and visibility of variables
   and functions. It alters how variables are initialized and where they can be accessed.

#### Usage

##### (1) Static Local Variables

###### Syntax

```CPP
ReturnType functionName() {
    static Type count = val; // Initialized only once and retains value between calls.
    ...
}
```

###### Explanation

1. When declared inside a function, a static local variable maintains its state between function
   calls. It is initialized only once and persists until the program ends.

##### (2) Static Class Members

###### Syntax

```CPP
class ClassType {
public:
    static Type staticMember; // Declaration of a static class member.
};

Type ClassType::staticMember = 0; // Providing definition and initialization for the static member.
```

###### Explanation

1. Static members of a class belong to the class itself rather than any object instance and can be
   accessed without an instance..
2. We should define it outside the class.

##### (3) Static Global Functions

###### Syntax

```CPP
static ReturnType functionName() {
    // Function body
}
```

###### Explanation

1. This function is limited in visibility to the file where it is defined, which helps to avoid name
   conflicts across different files.

##### (4) Static Member Function

###### Syntax

```CPP
class ClassName {
public:
    static ReturnType functionName( ... ) {
        // Function body
    }
};

ReturnType var_name = ClassName::functionName( ... );
```

###### Explanation

1. A static member function in C++ is a function that belongs to the class rather than any specific
   instance (object) of the class. This means it can be called without creating an instance of the
   class. Static member functions can only access static data members or other static member
   functions within the class.

#### Characteristics

1. Static local variables are initialized only once at the start of the program and retain their
   values across function calls.
2. Static members of a class are shared across all instances of that class, making them useful for
   keeping track of information common to all objects.
3. Static functions cannot be called from outside the file they are defined in, promoting
   encapsulation and modularity in code organization.

## Function

### 1) Explanation

1. A function is **a self-contained block of code** that **performs a specific task**. It can take
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
class ClassType {
   public:
      static void staticFunction() {   // Static member function
         std::cout << "Static function called." << std::endl;
      }
};

int main() {
   ClassType::staticFunction();   // Call static function without an instance
}
```

#### (7) `explicit`

##### Purpose

1. **Prevents implicit conversions and copy-initializations** that could lead to unexpected behavior
   or subtle bugs.

##### Example

```CPP
class ClassType {
   public:
      explicit ClassType( int x ) { /* constructor */
      }
};

void doSomething( ClassType obj ) {
   // do something
}

int main() {
   // doSomething(42);  // Error: no implicit conversion
   doSomething( ClassType( 42 ) );   // Explicit conversion is required
}
```

#### (8) `friend`

##### Purpose

1. Grants access to the class's **private and protected** members to a specific function or class.

##### Example

```CPP
class ClassType {
   private:
      int _secret;

   public:
      ClassType(): _secret( 42 ) {}

      friend void revealSecret( ClassType& obj );   // Friend function declaration
};

void revealSecret( ClassType& obj ) {   // Friend function definition
   std::cout << "Secret: " << obj._secret
             << std::endl;   // Access private member
}

int main() {
   ClassType obj;
   revealSecret( obj );   // Accesses the private member
}
```

#### (9) `constexpr`

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

#### (10) `noexcept`

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

#### (11) `using`

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

#### (12) `asm` or `__asm`

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
   a const function** can be considered overloaded. However, **the return type does not** play a
   role in distinguishing overloaded functions; you cannot overload functions solely based on
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

1. A lambda function is a way to define **an anonymous inline function** (i.e., a function without a
   name) directly in your code. It allows you to create small, simple function-like entities inline,
   making your code more concise and flexible.

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
   can be done by value (`=`) or by reference (`&`).
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

## Introduction to C++ STL

### 0) Explanation

1. The C++ Standard **Template** Library (STL) is a powerful collection of **template classes and
   functions** that provide generic and reusable components. It consists of various components that
   work together to simplify the development of complex programs.
2. Because it is a collection of **template classes and functions**, all **syntax** applicable to
   templates, classes, and functions can also be applied to it.
3. The C++ STL components are typically **defined in header files** because they rely heavily on
   templates.
4. Below are the six **basic** components of STL.

### 1) Containers

#### Explanation

1. Containers are **data structures** that store collections of objects. They manage the
   **storage**, **organization**, and **access of data**. Containers in STL can be broadly
   categorized into three types: sequence containers, associative containers, and unordered
   associative containers.

#### Types of Containers

1. Sequence Containers: Store elements in a linear order.
   - `std::vector`: A dynamic array that allows fast random access.
   - `std::list`: A doubly-linked list that allows efficient insertions and deletions.
   - `std::deque`: A double-ended queue that allows fast insertions and removals from both ends.
2. Associative Containers: Store elements in a specific order, typically based on keys.
   - `std::set`: A collection of unique keys that are sorted automatically.
   - `std::map`: A collection of key-value pairs where keys are unique and sorted.
3. Unordered Associative Containers: Store elements without a specific order, allowing for faster
   access.
   - `std::unordered_set`: A collection of unique keys with no order.
   - `std::unordered_map`: A collection of key-value pairs with no order.

#### Header File

`<vector>`, `<list>`, `<deque>`, `<set>`, `<map>`, `<unordered_set>`, `<unordered_map>`

### 2) Algorithms

#### Explanation

1. Algorithms are **a set of functions** that **operate on containers**. They provide a range of
   operations such as searching, sorting, transforming, and manipulating data within containers.

#### Common Algorithms

1. `std::sort`: Sorts the elements in a range.
2. `std::find`: Searches for a value in a range.
3. `std::copy`: Copies elements from one range to another.

#### Header File

`<algorithm>`

### 3) Iterators

#### Explanation

1. Iterators are **objects** that **allow traversal through the elements of a container**. They
   provide a uniform way to access container elements without exposing the underlying
   implementation.

#### Types of Iterators

1. Input Iterators: Read elements from a container.
2. Output Iterators: Write elements to a container.
3. Forward Iterators: Move forward in a container and allow reading and writing.
4. Bidirectional Iterators: Move in both directions (forward and backward).
5. Random Access Iterators: Provide direct access to elements using offsets.

#### Header File

`<iterator>`

### 4) Function Objects and Lambdas

#### Explanation

1. Function objects (functors) are **objects that can be called as if they were functions**. They
   can **store state** and are often used **in algorithms to customize their behavior**. Lambda
   expressions provide a concise way to define anonymous function objects.

#### Usage

1. Function objects can be created by overloading the `operator()`.
2. Lambda expressions can be defined using the syntax `[capture](parameters) { body; }`.
3. More information about lambdas is provided in Section
   [10) Lambda Functions](#10-lambda-functions).

#### Header File

`<functional>`

### 5) Input/Output (I/O)

#### Explanation

1. The I/O component of STL provides **facilities for reading and writing data**. It simplifies
   interactions with various input and output sources, such as files and standard input/output
   streams.

#### Common Classes

1. `std::istream`: For input streams (e.g., reading from the console).
1. `std::ostream`: For output streams (e.g., writing to the console).
1. `std::fstream`: For file input and output.

#### Header File

`<iostream>`, `<fstream>`, `<sstream>`

### 6) Utilities

#### Explanation

1. Utilities in STL provide **general-purpose functionality** that aids in programming tasks. This
   includes support for pairs, tuples, and smart pointers.

#### Common Utilities

1. `std::pair`: A simple container to store two values.
2. `std::tuple`: A fixed-size collection of heterogeneous values.
3. `std::unique_ptr`: A smart pointer that manages a dynamically allocated object.

#### Header File

`<utility>`, `<tuple>`, `<memory>`

## `enum`

### Explanation

1. An enum (short for "enumeration") is **a user-defined type** that consists of **a set of** named
   integral **constants**, providing a way to define a collection of related constants with
   meaningful names. Enumerations improve code readability by replacing numeric values with
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

## Array

### Explanation

1. An array is **a collection of elements**, all of **the same type**, that are stored in
   **contiguous memory** locations. Arrays are used to store **multiple values** in **a single
   variable**, making it easier to manage and manipulate data efficiently.

### Characteristics

#### 1) Homogeneous Data Types

1. All elements in an array must be of **the same data type** (e.g., all integers, all floats).

#### 2) Contiguous Memory Allocation

1. The elements of an array are stored in **consecutive memory** locations, which allows for
   **efficient access** using an index. The Contiguous memory **improves cache performance**.

### Raw Array

#### Explanation

1. A raw array in C++ refers to **a traditional C-style array** that is built into the language. It
   is **a fixed-size sequence** of elements of **the same type** and provides very minimal
   functionality compared to containers like `std::array` or `std::vector`.

#### Characteristics

1. The raw array is the **fastest** structure but **not safe** enough..
2. The **size** of a raw array is **defined at compile time** and **cannot be changed during
   runtime**. This means that once an array is declared, its size is fixed.

#### One-dimensional Raw Array

##### Declaration Syntax

```CPP
// No initialization, contain garbage values and behave unpredictably.
Type arr_name[size];
```

```CPP
Type* arr_ptr = new Type[size];
```

```CPP
Type arr_name[size];
Type* arr_ptr = arr_name;
```

##### Initialization Syntax

```CPP
// Aggregate Initialization
Type arr_name[size] = { val1, val2, ... };
```

```CPP
// Default Initialization
Type arr_name[size] = {};
```

```CPP
// Copy Initialization
Type arr_name1 = { {...}, {...}, ... };
Type arr_name2 = arr_name1;
```

```CPP
// Implicit Size: If the size isn't specified, it is inferred from the initializer list.
Type arr_name[] = { val1, val2, ... };
```

```CPP
Type* arr_ptr = new Type[size]{ ... };
```

##### Syntax for Deleting One-dimensional Raw Array Pointers

```CPP
delete[] arr_ptr;
```

#### Multidimensional Raw Array ( **Not Recommend** )

##### Declaration Syntax

```CPP
// No initialization, contain garbage values and behave unpredictably.
Type arr_name[size_x][size_y];
```

```CPP
// No initialization, contain garbage values and behave unpredictably.
Type arr_name[size_x][size_y][size_z];
```

```CPP
// `a2d` is an array that stores size_x pointers, each of which points to an array that stores size_y values.
Type** a2d = new Type*[size_x];
for( size_t i = 0; i < size_x; i++ ) {
   a2d[i] = new Type[size_y];
}
```

```CPP
Type*** a3d = new Type**[size_x];
for( size_t i = 0; i < size_x; i++ ) {
   a3d[i] = new Type*[size_y];
   for( size_t j = 0; j < size_y; j++ )
      a3d[i][j] = new Type[size_z];
}
```

##### Initialization Syntax

```CPP
// Aggregate Initialization
Type arr_name[size_x][size_y] = { { ... /* size_y */ }, { ... }, ... /* size_x */ };
```

```CPP
// Default Initialization
Type arr_name[size_x][size_y] = {};
```

```CPP
// Copy Initialization
Type arr_name1[size_x][size_y] = { { ... /* size_y */ }, { ... }, ... /* size_x */ };
Type arr_name2[size_x][size_y] = arr_name1;
```

```CPP
// Aggregate Initialization
Type arr_name[size_x][size_y][size_z] = {
   { { ... /* size_z */ }, { ... }, ... /* size_y */ },
   { { ... }, { ... }, ...},
   ... /* size_x */
};
```

```CPP
// Default Initialization
Type arr_name[size_x][size_y][size_z] = {};
```

```CPP
// Copy Initialization
Type arr_name1[size_x][size_y][size_z] = {
   { { ... /* size_z */ }, { ... }, ... /* size_y */ },
   { { ... }, { ... }, ...},
   ... /* size_x */
};
Type arr_name2[size_x][size_y][size_z] = arr_name1;
```

##### Syntax for Deleting Multidimensional Raw Array Pointers

```CPP
for( size_t i = 0; i < size_x; i++ ) {
   delete[] a2d[i];
}
delete[] a2d;
```

```CPP
for( size_t i = 0; i < size_x; i++ ) {
   for( size_t j = 0; j < size_y; j++ )
      delete[] a3d[i][j];
   delete[] a3d[i];
}
delete[] a3d;
```

### `std::array`

#### Explanation

1. `std::array` is **a container** from the C++ Standard Library that provides **a fixed-size
   array**. It is **a template class**, and all syntax applicable to template classes applies to it.

#### Characteristics

1.  `std::array` is **slower** than the raw array, but `std::array` is **safer** than a raw array.
2.  `std::array` is used like a raw array but **provides member functions** and allows us to use
    many standard C++ functions to manage it.
3.  In debug mode, `std::array` can **help us debug** like bounds checking, thanks to its debug
    macros and code.
4.  `std::array` is **a template**. We can use its functions to get its size, but it **doesn't store
    the size as a value**.
5.  The **size** of a `std::array` is **defined at compile time** and **cannot be changed during
    runtime**. This means that once an array is declared, its size is fixed.

#### A Simple Implementation of `std::array`

```CPP
template< typename T, size_t size > class Array {
      T _array[size]
};
```

#### One-dimensional `std::array`

##### Declaration Syntax

```CPP
// No initialization, contain garbage values and behave unpredictably.
std::array< Type, size > arr_name;
```

```CPP
std::array< Type, size >* arr_ptr = new std::array< Type, size >;
```

```CPP
std::array< Type, size > arr_name;
std::array< Type, size >* arr_ptr = &arr_name;
```

##### Initialization Syntax

```CPP
// Aggregate Initialization
std::array< Type, size > arr_name = { val1, val2, val3, ... };
```

```CPP
// Default Initialization
std::array< Type, size > arr_name = {};
```

```CPP
// Uniform Initialization (C++11 and later)
std::array< Type, size > arr{ val1, val2, val3, ... };
```

```CPP
// Class-type Constructor Initialization
std::array< Type, size > arr( { ... } );
```

```CPP
// Copy Initialization
std::array< Type, size > arr_name1 = { val1, val2, val3, ... };
std::array< Type, size > arr_name2 = arr_name1;
```

```CPP
std::array< Type, size >* arr_ptr = new std::array< Type, size >{ ... };
```

##### Syntax for Deleting One-dimensional `std::array` Pointers

```CPP
delete arr_ptr;
```

#### Multidimensional `std::array` ( **Not Recommend** )

##### Declaration Syntax

```CPP
// No initialization, contain garbage values and behave unpredictably.
std::array< std::array< Type, size_y >, size_x > arr_name;
```

```CPP
// No initialization, contain garbage values and behave unpredictably.
std::array< std::array< std::array< Type, size_z >, size_y >, size_x > arr_name;
```

##### Initialization Syntax

```CPP
// Aggregate Initialization
std::array< std::array< Type, size_y >, size_x > arr_name = { { { ... /* size_y */ }, { ... }, ... /* size_x */ } };
```

```CPP
// Default Initialization
std::array< std::array< Type, size_y >, size_x > arr_name = {};
```

```CPP
// Uniform Initialization (C++11 and later)
std::array< std::array< Type, size_y >, size_x > arr_name{ { { ...  /* size_y */}, { ... }, ... /* size_x */ } };
```

```CPP
// Copy Initialization
std::array< std::array< Type, size_y >, size_x > arr_name1 = { { { ... /* size_y */ }, { ... }, ... /* size_x */ } };
std::array< std::array< Type, size_y >, size_x > arr_name2  = arr_name1;
```

```CPP
// Aggregate Initialization
std::array< std::array< std::array< Type, size_z >, size_y >, size_x > arr_name = { {
   { { ... /* size_z */ }, { ... }, ... /* size_y */ },
   { { ... }, { ... }, ... },
   ... /* size_x */
} };
```

```CPP
// Default Initialization
std::array< std::array< std::array< Type, size_z >, size_y >, size_x > arr_name = {};
```

```CPP
// Uniform Initialization (C++11 and later)
std::array< std::array< std::array< Type, size_z >, size_y >, size_x > arr_name{ {
   { { ... /* size_z */ }, { ... }, ... /* size_y */ },
   { { ... }, { ... }, ...},
   ... /* size_x */
} };
```

```CPP
// Copy Initialization
std::array< std::array< std::array< Type, size_z >, size_y >, size_x > arr_name1 = {
   { { ... /* size_z */ }, { ... }, ... /* size_y */ },
   { { ... }, { ... }, ... },
   ... /* size_x */
};
std::array< std::array< std::array< Type, size_z >, size_y >, size_x > arr_name2 = arr_name1;
```

##### Member Functions

###### (1) Element Access

1. `at(size_t index)`: Returns **a reference** to the element at `index` **with bounds checking**.
   Throws `std::out_of_range` if the index is out of bounds.
2. `operator[](size_t index)`: Returns **a reference** to the element at `index` **without bounds
   checking**.
3. `front()`: Returns **a reference** to the **first element** in the array.
4. `back()`: Returns **a reference** to the **last element** in the array.
5. `data()`: Returns **a pointer** to **the underlying C-style array or the raw array**.

###### (2) Capacity

1. `size()`: Returns **the number** of elements in the array (constant time).
2. `max_size()`: Returns **the maximum number** of elements the array can hold (**same as `size()`**
   in practice).
3. `empty()`: Returns **true** if the array is **empty** (always false for `std::array` since the
   size is fixed and non-zero).

###### (3) Modifiers

1. `fill(const T& value)`: **Assigns** the specified **value** to **all elements** in the array.
2. `swap(std::array& other)`: **Swaps** the contents of the current array with other. Both arrays
   must have the same size and type.

###### (4) Iterators

1. `begin()`: Returns **an iterator** to the **first element** of the array.
2. `end()`: Returns **an iterator** to one past the **last element** of the array.
3. `cbegin()`: Returns **a const iterator** to the **first element**.
4. `cend()`: Returns **a const iterator** to one past the **last element**.
5. `rbegin()`: Returns **a reverse iterator** to the **last element**.
6. `rend()`: Returns **a reverse iterator** to one before the **first element**.
7. `crbegin()`: Returns **a const reverse iterator** to the **last element**.
8. `crend()`: Returns **a const reverse iterator** to one before the **first element**.

#### Notes

1. Do **not use an actual multidimensional array**. If you need a multidimensional array, flatten it
   and use a one-dimensional array instead. For example, `Type a2d[size_x * size_y];` and
   `Type* a2d = new Type[size_x * size_y];` Both examples create a two-dimensional array using a
   one-dimensional array..
2. When working with actual multidimensional arrays, **performance and memory issues** with pointers
   can arise depending on how the array is allocated and accessed, as **not all elements** may be
   **contiguous in memory**. This can lead to problems such as **memory fragmentation** and **cache
   misses**.
3. `size_t` is **an unsigned integer type** specifically designed to **represent the size** of
   objects or array indices. It is widely used to ensure **portability across platforms** and
   **avoid overflow issues** when working with memory sizes, since it matches the size of the
   addressable memory range on the system.
