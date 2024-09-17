% Function for Trapezoidal Rule
function I_trap = trapezoidal_rule(f, a, b, h)          
    x = a:h:b;                
    y = f(x);                 
    I_trap = (h / 2) * (y(1) + 2 * sum(y(2:end-1)) + y(end));
end

% Function for Simpson's Rule
function I_simp = simpson_rule(f, a, b, h)
    n = (b - a) / h;
    
    x = a:h:b;  
    if mod(n, 2) ~= 0
        error('Number of subintervals n must be even for Simpson''s rule.');
    end
    y = f(x);               

    I_simp = (h / 3) * (y(1) + ...
              4 * sum(y(2:2:end-1)) + ...
              2 * sum(y(3:2:end-2)) + y(end));
end

% Main Script
f = @(x) exp(-x.^2);
a = 0;
b = 1;
I_exact = integral(f, a, b);

K = 1:15;
h_values = 2.^(-K);
errors_trap = zeros(size(K)); 
errors_simp = zeros(size(K)); 
I_trap_values = zeros(size(K));
I_simp_values = zeros(size(K));

for idx = 1:length(K)
    h = h_values(idx);

    I_trap = trapezoidal_rule(f, a, b, h);
    I_trap_values(idx) = I_trap;
    errors_trap(idx) = abs(I_trap - I_exact);

    I_simp = simpson_rule(f, a, b, h);
    I_simp_values(idx) = I_simp;
    errors_simp(idx) = abs(I_simp - I_exact);
end



figure;
loglog(h_values, errors_trap, 'o-', 'LineWidth', 2);
hold on;
loglog(h_values, errors_simp, 's-', 'LineWidth', 2);

loglog(h_values, h_values.^2, '--', 'LineWidth', 1.5);
loglog(h_values, h_values.^4, '--', 'LineWidth', 1.5);

legend('Trapezoidal Rule Error', 'Simpson''s Rule Error', ...
       'Reference Line h^2', 'Reference Line h^4', 'Location', 'best');

xlabel('Step size h');
ylabel('Absolute Error');
title('Error vs. Step Size for Trapezoidal and Simpson''s Rules');
legend('Trapezoidal Rule Error', 'Simpson''s Rule Error', ...
       'Reference Line h^2', 'Reference Line h^4', 'Location', 'best');
hold off;
grid on;

ResultsTable = table(h_values', I_trap_values', errors_trap', I_simp_values', errors_simp', ...
    'VariableNames', {'h', 'I_trap', 'Error_trap', 'I_simp', 'Error_simp'});

disp(ResultsTable);