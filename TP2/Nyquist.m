F = -22/(s+1)/(s+2)/s
eig(F)
nyquist(F)
FF=minreal(F/(1+F),0.1)
eig(FF)