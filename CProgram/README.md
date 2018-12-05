# The LLDB Debugging in C program

## Compile c file

To compile the file `hello.c` with gcc, use the following command:

```
$ gcc -o hello -g hello.c
```

> NOTE: Add `-g` option to debug with LLDB


## Debug c program with LLDB

You can use LLDB debugging of programs with commands.
The LLDB commands are all of the form:

```
<noun> <verb> [-options [option-value]] [argument [argument...]]
```

First, start LLDB

```
$ lldb hello
(lldb) target create "hello"
Current executable set to 'hello' (x86_64).
```

### Breakpoint 

You can set breakpoints with the following command:

```
(lldb) breakpoint set --file hello.c --line 8
```
or 

```
(lldb) breakpoint set -f hello.c -l 8
```

Run the program

```
(lldb) run hello.c
```

or

```
(lldb) run
```


