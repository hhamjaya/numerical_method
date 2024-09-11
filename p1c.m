% Matlab script for solving a nonlinear algebraic equation problem with newton-raphson method
function [p, n, x] = newton(f,df,p0,TOL,MaxNiter)
    p=p0;
    x=[p];
    for n=1:MaxNiter
        fp=f(p);
        dfp=df(p);
        dp=fp/dfp;
        p=p-dp;
        x(end+1) = p;
        if abs(dp)<TOL
            break
        end
    end
end
clear all; clc;
f=@(x) tanh(x);
df=@(x) 1-(tanh(x))^2;
Tol=1e-15; MaxIter=7;
p0=1
% p0=1.1
[Error,Iteration,P_val]=newton(f,df,p0,Tol,MaxIter)