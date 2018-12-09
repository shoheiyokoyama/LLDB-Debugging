import lldb

def achoo(debugger, command, result, internal_dict):
    print "Bless you"

def __lldb_init_module(debugger, dict):
    debugger.HandleCommand("command script add -f achoo.achoo achoo")
