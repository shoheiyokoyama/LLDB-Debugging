# The Debugging with Xcode and LLDB

## The Debugging settings

You can configure the behavior settings when pausing in the debugger.

See Preferences / Befaviors / Pauses, for more details.


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

You can execute arbitrary processing at runtime by setting a breakpoint with action.

 1. Click `Edit Breakpoint ...`  or double-click a breakpoint.
 2. Click `Add Action`
 3. Add command

## Breakpoint

Click `Edit Breakpoint ...`  or double-click a breakpoint to set breakpoints in detail.

### Condition



### Ignore

You can ignore the breakpoint by the `ignore` .
For example, if you add 2, the breakpoint is ignored twice and the breakpoint is reached the third time.

### Action

When the breakpoint is reached, processing is executed.

### Option

If `automatically continue after evaluating actions` is checked, processing will not stop at the breakpoint.

## Requirements

- Xcode 10.1
- Swift 4.2
