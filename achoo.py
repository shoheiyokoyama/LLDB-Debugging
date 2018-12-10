import lldb

# 🤧
def achoo(debugger, command, result, internal_dict):
    print "Bless you"

def __lldb_init_module(debugger, internal_dict):
    # command script add -f filename.function_name command_name
    debugger.HandleCommand("command script add -f achoo.achoo achoo")
