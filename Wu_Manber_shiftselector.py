from __future__ import absolute_import
from __future__ import print_function
import sys
import os
import math

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from veriloggen import *

def mksftdvdcq(SHIFT_WIDTH,NOS_comps):
    m = Module('Wu_Manber_ShiftSelector')
    
    clk = m.Input('clk')
    rst = m.Input('rst')
    cmpshift=m.Input('comp_shift_wire',(NOS_comps*SHIFT_WIDTH))
    shift=m.Output('shift_wire',SHIFT_WIDTH)


    allwires=[]

    stgs=NOS_comps
    muxs = mkmux(SHIFT_WIDTH)

    for i in range(1,stgs+1):
        t=stgs*10+i
        l=m.Wire('shift_wire%d'%t,SHIFT_WIDTH)
        allwires.append(l)
        m.Assign(l(cmpshift[(i-1)*SHIFT_WIDTH:i*SHIFT_WIDTH]))


    stgs=NOS_comps/2


    while(stgs!=0):
        print(stgs)
        port=[]
        for i in range(1,stgs+1):
            t=stgs*10+i
            l=m.Wire('shift_wire%d'%t,SHIFT_WIDTH)
            print(len(allwires))
            allwires.append(l)
            x=allwires.pop(0)
            y=allwires.pop(0)
            ports=[clk,rst,x,y,l]
            m.Instance(muxs, 'muxcmp%d' %t, params=(), ports=ports)
        if(stgs == 1):
            stgs=0
        stgs=stgs/2
    m.Assign(shift(allwires.pop(0)))

    return m


def mkmux(WIDTH=8):
    m=Module('muxaltb')
    clk=m.Input('clk')
    rst = m.Input('rst')
    a=m.Input('a',WIDTH)
    b=m.Input('b',WIDTH)
    cr=m.OutputReg('c', WIDTH)
    m.Always(Posedge(clk))(
		If(rst)(
			cr(0)
            )
		.Else(
			If(a<b)(
				cr(a))
			.Else(cr(b))
			)
			)
    return m

if __name__ == '__main__':
    main = mksftdvdcq(SHIFT_WIDTH=5,NOS_comps=32)
    # main=mkmux(WIDTH=8)
    verilog = main.to_verilog('selectdvdcnq.v')
