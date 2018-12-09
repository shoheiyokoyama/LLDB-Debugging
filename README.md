# LLDB Debugging

<img src="https://github.com/shoheiyokoyama/LLDBDebugging/blob/master/Assets/DragonFull.png" width="300" align="left">

# The LLDB Debugger

The LLDB Debugger (LLDB) is an open-source software debugger that is a next generation, high-performance. It features a REPL, along with C++ and Python plugins.

A debugger allows you to pause a program at a specific moment of its execution, inspect the values of variables, execute custom instructions, and then manipulate the advancement of the program as you see fit. 

LLDB is the default debugger in Xcode on Mac OS X and supports debugging C, Objective-C and C++ on the desktop and iOS devices and simulator.

# Contents

- [The LLDB Debugging in C program](https://github.com/shoheiyokoyama/LLDBDebugging/tree/master/CProgram#the-lldb-debugging-in-c-program)
- [The Debugging with Xcode and LLDB](https://github.com/shoheiyokoyama/LLDBDebugging/tree/master/DBug#the-debugging-with-xcode-and-lldb)
- [The LLDB command](#lldb-command)
- [Config file](#config-file)
- [Custom LLDB command using python](#custom-lldb-command-ussing-python)
- [References](#references)
- [Platform support](#platform-support)
- [Author](#author)


## <a name="lldb-command"> The LLDB command

The LLDB commands are all of the form:

```
<noun> <verb> [-options [option-value]] [argument [argument...]]
```

You can see the debugger commands with the help command.

```
(lldb) help
Debugger commands:
apropos           -- List debugger commands related to a word or subject.
breakpoint        -- Commands for operating on breakpoints (see 'help b' for
shorthand.)
bugreport         -- Commands for creating domain-specific bug reports.
command           -- Commands for managing custom LLDB commands.
disassemble       -- Disassemble specified instructions in the current
target.  Defaults to the current function for the
current thread and stack frame.
expression        -- Evaluate an expression on the current thread.  Displays
any returned value with LLDB's default formatting.
frame             -- Commands for selecting and examing the current thread's
stack frames.
gdb-remote        -- Connect to a process via remote GDB server.  If no host
is specifed, localhost is assumed.

...
```

Also, can see more detailed commands by adding commands and subcommand options (`help <command> <subcommand>`).

```
(lldb) help breakpoint
Commands for operating on breakpoints (see 'help b' for shorthand.)

Syntax: breakpoint <subcommand> [<command-options>]

The following subcommands are supported:

clear   -- Delete or disable breakpoints matching the specified source
file and line.
command -- Commands for adding, removing and listing LLDB commands
executed when a breakpoint is hit.
delete  -- Delete the specified breakpoint(s).  If no breakpoints are
specified, delete them all.
disable -- Disable the specified breakpoint(s) without deleting them.  If
none are specified, disable all breakpoints.
enable  -- Enable the specified disabled breakpoint(s). If no breakpoints
are specified, enable all of them.

...
```

There are more command sample at [GDB TO LLDB COMMAND MAP](https://lldb.llvm.org/lldb-gdb.html)

## <a name="config-file"> Config file

`~/.lldbinit` is loaded when CLI is started. (for Xcode, `~/.lldbinit-Xcode` is loaded)

It's useful to set module import and alias settings in this file.

- alias: `command alias b breakpoint`
- unalias: `command unalias b`
- file import: `command script import path/xxx.py`

##  <a name="custom-lldb-command-ussing-python"> Custom LLDB command using python

You can create new commands by using python function.

To write a python function that implements a new LLDB command define the function to take four arguments as follows:

```python
def command_function(debugger, command, result, internal_dict):
    # Your code goes here
```

The below function will get run when the module is loaded allowing you to add whatever commands you want into the current debugger. 

```python
def __lldb_init_module(debugger, internal_dict):
    # Command Initialization code goes here
```

> NOTE: this function will only be run when using the LLDB command command script import, it will not get run if anyone imports your module from another module. 

Add the following script, to add a new command.

```
command script add -f filename.function_name command_name
```

| Argument | Type | Description |
|---|---|---|
| debugger | lldb.SBDebugger | The current debugger object |
| command | python string | A python string containing all arguments for your command. If you need to chop up the arguments try using the shlex module's shlex.split(command) to properly extract the arguments. |
| result | lldb.SBCommandReturnObject | A return object which encapsulates success/failure information for the command and output text that needs to be printed as a result of the command. The plain Python "print" command also works but text won't go in the result by default (it is useful as a temporary logging facility). |
| internal_dict | python dict object | The dictionary for the current embedded script session which contains all variables and functions. |

See [LLDB Python Reference](https://lldb.llvm.org/python-reference.html) for more information.

## <a name="platform-support"> Platform support

- Mac OS X desktop user space debugging for i386 and x86-64
- iOS simulator debugging on i386
- iOS device debugging on ARM
- Linux local user-space debugging for i386, x86-64 and PPC64le
- FreeBSD local user-space debugging for i386 and x86-64
- Windows local user-space debugging for i386 (*)

## <a name="references"> References

- [The LLDB Debugger](https://lldb.llvm.org/index.html)
- [LLDB Quick Start Guide](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/gdb_to_lldb_transition_guide/document/Introduction.html#//apple_ref/doc/uid/TP40012917-CH1-SW1)
- [Advanced Debugging with Xcode and LLDB](https://developer.apple.com/videos/play/wwdc2018/412/)
- [Dancing in the Debugger — A Waltz with LLDB](https://www.objc.io/issues/19-debugging/lldb-debugging/#lldb)

## <a name="author"> Author

Shohei Yokoyama

- [GitHub](https://github.com/shoheiyokoyama)
- [Facebook](https://www.facebook.com/shohei.yokoyama.96)
- [Twitter](https://twitter.com/shoheiyokoyam)
- Gmail: shohei.yok0602@gmail.com
