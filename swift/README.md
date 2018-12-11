# The REPL and Debugger in Swift

The LLDB debugger supports the Swift programming language & REPL. You can launch the LLVM debugger (LLDB) with swift compiler by using the xcrun command.

### [REPL and Debugger](https://swift.org/lldb/#why-combine-the-repl-and-debugger)

> The Swift.org community makes use of [the LLDB debugger](https://github.com/apple/swift-lldb) to provide a rich REPL as well as the debugging environment for the Swift Language. Swift is tightly coupled to the version of the Swift compiler embedded in the debugger. Tight integration of compiler and debugger enables accurate inspection of Swift types as well as full-featured expression evaluation in the context of a rapidly evolving language.

## Hello Swift REPL

First, run `xcrun swift`. You can see  the Swift REPL.

```
$ xcrun swift
Welcome to Apple Swift version 4.2.1 (swiftlang-1000.11.42 clang-1000.11.45.1). Type :help for assistance.
  1>  
```

The REPL will immediately execute Swift statements and the result is output interactively.

```
1> let name = "Swift REPL"
name: String = "Swift REPL"
2> print("Hello, \(name)")
Hello, Swift REPL
```

### Multi-Line Editing

The REPL also provides convenient features for dealing with multi-line input like most class or function declarations.

```
$ xcrun swift
Welcome to Apple Swift version 4.2.1 (swiftlang-1000.11.42 clang-1000.11.45.1). Type :help for assistance.
  1> func sayHello() {
  2.     print("Hello Swift REPL")
  3. }
  4. sayHello()
Hello Swift REPL
```

## Compile and Debugginng

The swiftc compiler can compile swift code and produces excutable file. For `hello.swift`, `hello` is generated. for multiple files, `main` is generated. If you want to specify file name, add `-o` option.

```
$ xcrun swiftc hello.swift
$ ./hello
Hello Swift REPL
```

for LLDB Debugging:

```
xcrun swiftc -g hello.swift

$ xcrun swiftc -g hello.swift
$ lldb hello
(lldb) target create "hello"
Current executable set to 'hello' (x86_64).
(lldb) breakpoint set --file hello.swift --line 2
Breakpoint 1: where = hello`hello.sayHello() -> () + 4 at hello.swift:2, address = 0x0000000100000e64
(lldb) run
Process 36902 launched: '/path/hello' (x86_64)
Process 36902 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x0000000100000e64 hello`sayHello() at hello.swift:2
   1   	func sayHello() {
-> 2   	    print("Hello Swift REPL")
   3   	}
   4   	
   5   	sayHello()
Target 0: (hello) stopped.
```

As for more information concerning `xcrun`, `swiftc`, run help command.

```
$ xcrun --help
$ swiftc -help
```



