#part-handler
# vi: syntax=python ts=4

import os
import base64

handler_version = 2

def list_types():
    # return a list of mime-types that are handled by this module
    return(["text/plain-base64"])

def handle_part(data, ctype, filename, payload, frequency):
    # data: the cloudinit object
    # ctype: '__begin__', '__end__', or the specific mime-type of the part
    # filename: the filename for the part, or dynamically generated part if
    #           no filename is given attribute is present
    # payload: the content of the part (empty for begin or end)
    if ctype == "__begin__":
       print "my handler is beginning, frequency=%s" % frequency
       return
    if ctype == "__end__":
       print "my handler is ending, frequency=%s" % frequency
       return

    print "==== received ctype=%s filename=%s ====" % (ctype, filename)
    
    if not os.path.exists(os.path.dirname(filename)):
        try:
            os.makedirs(os.path.dirname(filename))
        except OSError as exc:
            if exc.errno != errno.EEXIST:
                raise
    
    with open(filename, "w") as f:
        f.write(base64.b64decode(payload))
        
        if filename.endswith('.sh'):
            os.chmod(filename, 0755)
        
    print "==== end ctype=%s filename=%s" % (ctype, filename)