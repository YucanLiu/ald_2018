import math;
from decimal import *

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

def main():
	twiddle = cal_twiddle()
	for index in range(N):
		print 'w_r'+ str(index)+ '= '+str(twiddle[index].r)
		print 'w_i'+ str(index)+ '= '+ str(twiddle[index].i)

main()
