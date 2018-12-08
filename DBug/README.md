# The Debugging with Xcode and LLDB

## The Debugging settings

You can configure the behavior settings when pausing in the debugger.

See Preferences / Befaviors / Pauses, for more details.

## The LLDB command

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

# DBug

DBug is an iOS project with examples of debugs.

## Evaluating variable with LLDB

With the following command,  you can change the behavior at runtime.

### `expression` or `expr`

Evaluate an expression on the current thread. Displays any returned value with LLDB's default formatting.

Syntax: `expression <cmd-options> -- <expr>`

```
(lldb) po variable
true
(lldb) expr variable = false
(lldb) po variable
false
```

### `print`

`print` command takes no arguments, unlike the `expression` command.
This is an abbreviation for `expression --`.

### `po`

`po` command is an abbreviation for `expression -O  --`.
`expression -O  --` ( --object-description ): Display using a language-specific description API, if possible.

### Change animation behavior

The `Dbag` project is an app that button moves according to the values ​​of `currentDirection` and `currentPoint`.

Before running the animation, you can change animation behavior by changing the value at runtime.

It's possible to change the value with the following command:

```
(lldb) expr currentPoint = .leftBottom
(lldb) expr currentDirection = .random
```

## Add Action



## Breakpoint

Click `Edit Breakpoint ...` to set breakpoints in detail.

### Condition



### Ignore

You can ignore the breakpoint by the `ignore` .
For example, if you add 2, the breakpoint is ignored twice and the breakpoint is reached the third time.

### Action

When the breakpoint is reached, processing is executed.

### Option

If `automatically continue after evaluating actions` is checked, processing will not stop at the breakpoint.






