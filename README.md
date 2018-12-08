# LLDB Debugging

# Contents

- [The LLDB command](#lldb-command)
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

## <a name="author"> Author

Shohei Yokoyama

- [GitHub](https://github.com/shoheiyokoyama)
- [Facebook](https://www.facebook.com/shohei.yokoyama.96)
- [Twitter](https://twitter.com/shoheiyokoyam)
- Gmail: shohei.yok0602@gmail.com
