from __future__ import absolute_import
from __future__ import print_function
import os
import sys
import math

# the next line can be removed after installation
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from veriloggen import *

dirConst= os.getcwd()

def mkRegChain(datawidth=1024, width=8):
    m = Module("NFA")
    max_sz=76
    clk = m.Input('clk')
    rst = m.Input('rst')
    din=m.Input('datain',max_sz*4)

    i=0
    com=m.Wire('comp',32)
    registers=[]
    
    with open(dirConst+'/signature128.txt','r') as f:
        for a in f:
            sz=len(a)
            l=m.Wire('w%d' %i,sz-1)
            # j=sz-1
            j=0
            a=str(a)
            for item in a:
                left=(max_sz-(j+1))*4
                right=((max_sz-j)*4)-1
                # left= (j-1)*4
                # right=(j)*4-1
                try:
                    b=int(item,16)
                    print(j,left,right)
                    m.Assign(l[j](Uor(din[left:right+1] ^ b )))
                    j=j+1
                except ValueError:
                    print ("value error")
            m.Assign(com[i](Unot(Uor(l))))
            i=i+1

    
    dout=m.OutputReg('dout',int(math.log(i, 2)) + 1)
    dout_wr=m.Wire('dout_wr',int(math.log(i, 2)) + 1) 

    m.Always(Posedge(clk))(
        If(rst)
            (dout(0))
        .Else
            (dout(dout_wr))
    )

    return m

if __name__ == '__main__':
    main = mkRegChain(datawidth=64)
    verilog = main.to_verilog('tmp.v')
