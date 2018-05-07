import math
import numpy as np
import struct

N = 32

class complex:
	def __init__(self, r, i):
		self.r = r
		self.i = i

def cal_twiddle():
	twiddle = []
	for index in range(N):
		twiddle.append(complex((math.cos(2*math.pi*index / N)), (-math.sin(2 * math.pi * index / N))))
	return twiddle




def to_twoscomplement(bits, value):
	if value < 0:
		value = ( 1<<bits ) + value
	else:
		value = value
	formatstring = '{:0%ib}' % bits
	return formatstring.format(value)

def main():
	twiddle = cal_twiddle()
	result = []
	n = 16
	for index in range(N):
		result.append(to_twoscomplement(16,int(twiddle[index].r*(2**8))))
		result.append(to_twoscomplement(16, int(twiddle[index].i*(2**8))))
		# print 'w_r'+ str(index)+ '= ' + to_twoscomplement(16,int(twiddle[index].r*(2**8)))
		# print 'w_i'+ str(index)+ '= '+ to_twoscomplement(16, int(twiddle[index].i*(2**8)))
	verilog_twiddle = ''
	for r in result:
		verilog_twiddle = verilog_twiddle + r
	print verilog_twiddle


main()
