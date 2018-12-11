# REPL and Debugger in Swift

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

The REPL will immediately execute Swift statements and the results are output interactively.

```
1> let name = "Swift REPL"
name: String = "Swift REPL"
2> print("Hello, \(name)")
Hello, Swift REPL
```


