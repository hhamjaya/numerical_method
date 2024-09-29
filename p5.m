t_interval = [0,100];
initial = 10;
%Calculation of numerical solution ODE45
[t,y_ode] = ode45(@eqns , t_interval , initial);
f_correct = @(x) (150./(1 + 14*exp(-0.06*x)));
fh = f_correct(t);
%Plotting of numerical solution ODE45
figure
plot(t,y_ode,'x-')
title('Numerical solution plotted against time ')
xlabel('time')
ylabel('y')
legend('y(t)')
legend('Location', 'best');
%Error of numerical solution ODE45
error_1= abs(fh-y_ode);
error_ode = norm(error_1,inf)
%Initial values of Runge-Kutta method
tao_interval = [1,2,3,4,5];
tao_f = @(n) 2.^-n;
tao = tao_f(tao_interval);
errors = [0,0,0,0,0];
%Runge-Kutta method
for i=1:(length(tao))
    x = 0:tao(i):100;
    y = zeros(1,length(x));
    f = @(t,y) y*(150-y)/2500;
    y(1) = 10;
    for j=1:(length(x)-1)
       k1 = f(x(j),y(j));
       k2 = f(x(j)+1*tao(i),y(j)+tao(i)*1*k1);
       k3 = f((x(j)+(0.5)*tao(i)),(y(j)+tao(i)*0.25*k1+tao(i)*0.25*k2));
       y(j+1) = y(j) + tao(i)*(1/6*k1+1/6*k2+2/3*k3);
    end
    fh = f_correct(x);
    error= abs(fh-y);
    n = norm(error,inf);
    errors(i) = n;
end


%Plotting error of Runge-Kutta method
figure
loglog(tao,errors,'-ob');
hold on
grid on
title('Runge-Kutta Method Error per stepsize (stepsize = {\tau})')
xlabel('{\tau}')
ylabel('Absolute Error')
loglog(tao,tao.^3,'-xr');
legend('Error per stepsize','O({\tau}^3)')
legend('Location', 'best');

%Function for IVP
function derivative_y = eqns(t,y)
derivative_y=y*(150-y)/2500;
end