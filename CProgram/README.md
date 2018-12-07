# The LLDB Debugging in C program

## Compile c file

To compile the file `hello.c` with gcc, use the following command:

```bash
$ gcc -o hello -g hello.c
```

> NOTE: Add `-g` option to debug with LLDB


## Debug c program with LLDB

### Starting lldb

```bash
$ lldb hello
(lldb) target create "hello"
Current executable set to 'hello' (x86_64).
```

### Launch a program in LLDB

To launch a program in lldb, Use `process launch` or `run` command. 

```bash
(lldb) process launch
Process 23011 launched: 'Path/CProgram/hello' (x86_64)
Hello World
```

### Finish LLDB

```bash
(lldb) quit
```

## LLDB command

You can use LLDB debugging of programs with commands.
The LLDB commands are all of the form:

```bash
<noun> <verb> [-options [option-value]] [argument [argument...]]
```

### Breakpoint 

You can set breakpoints with the following command:

```bash
(lldb) breakpoint set --file hello.c --line 8
```
or 

```bash
(lldb) breakpoint set -f hello.c -l 8
```

Run the program

<p align="center">
  <img src="https://github.com/shoheiyokoyama/LLDBDebugging/blob/master/CProgram/Assets/lldb-run.png" width="750">
</p>

The set breakpoint interrupts execution and will give us an interactive prompt to mingle with the running proces. In this suspended state, it's possible to execute LLDB commands.

#### Step

`step` or `s` executes the very next instruction and suspends again.

```bash
(lldb) step
```

#### Continue

`continue` or `c`  execute all the instructions until it hits a next breakpoint or the process ends

```bash
(lldb) continue
```

#### Print object

```bash
(lldb) po name
"shoheiyokoyama"
```

#### The arguments and local variables

Show the arguments and local variables for the current frame with `frame variable` or `fr v`.

```bash
(lldb) frame variable
(int) argc = 1
(char **) argv = 0x00007ffeefbffa18
(char *) name = 0x0000000100000f64 "shoheiyokoyama"
(char *) language = 0x0000000100000f73 "Swift"
```

#### The stack backtrace

Show the stack backtrace for the current thread with `thread backtrace` or `bt`.

```bash
(lldb) thread backtrace
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
  * frame #0: 0x0000000100000f14 hello`main(argc=1, argv=0x00007ffeefbffa18) at hello.c:9
  frame #1: 0x00007fff6fdfc015 libdyld.dylib`start + 1
  frame #2: 0x00007fff6fdfc015 libdyld.dylib`start + 1
```

See [GDB TO LLDB COMMAND MAP](https://lldb.llvm.org/lldb-gdb.html), for more details.
