function [p, n] = bisection(f,a,b,TOL,MaxNiter)
    fa=f(a); fb=f(b);
    for n=1:MaxNiter
        p=(a+b)/2;
        if (b-a)/2<TOL
            break
        end
        fp=f(p);
        if fa*fp<0
            b=p; fb=fp;
        else
            a=p; fa=fp;
        end
    end
end
clear all; clc;
f=@(x) tanh(x);
a=-4; b=3; Tol=1e-15; MaxIter=100;

[error,number_iteration]=bisection(f,a,b,Tol,MaxIter)