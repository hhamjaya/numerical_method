function [p, n, x] = secant(f,a, b,TOL,MaxNiter)
    pa=a;
    pb=b;
    xa=f(pa);
    pvalue=0;
    x = [pa, pb]
    for n=1:MaxNiter
        xb=f(pb);
        p=pb - (pb-pa)*f(pb)/(f(pb)-f(pa));
        x(end+1) = p;
        if abs(p - pvalue)<TOL
            break
        end
        pa = pb;
        pb = p;
        end
    end
clear all; clc;

f=@(x) tanh(x);
Tol=1e-15; MaxIter=10;
p0=1.0
p1=1.2
% p1=2.4
[Error,Iteration,P_val]=secant(f,p0,p1,Tol,MaxIter)