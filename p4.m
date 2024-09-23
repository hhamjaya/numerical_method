% MATLAB function script for Boundary Value Problem - BVP
% MATLAB function script for Boundary Value Problem - BVP
function [x, y, E] = BVP(f, N, y_exact)
    % Solves the boundary value problem(with Tridiagonal MatrixAlgorithm):
    % Ref: https://en.wikipedia.org/wiki/Tridiagonal_matrix_algorithm
    %
    % Inputs:
    % f - function f(x)
    % N - number of discrete points
    % y_exact - function of exact values of y, for error calculation
    h = pi/N;
    x = (1:N-1) * h;
    % Building Triangular Matrix
    A = zeros(N-1, N-1);
    main_diagonal = -2/h^2 + 1/4;
    off_diagonal = 1/h^2;
    % Diagonal Filling
    A = diag(main_diagonal * ones(N-1, 1))+ ...
    diag(off_diagonal * ones(N-2, 1), 1) + ...
    diag(off_diagonal * ones(N-2, 1), -1);
    % Evaluating f(x) on storing it
    % A.x = b is A.y = Fx here
    b = f(x)';
    [L, U, P] = lu(A);
    y_temp = L\(P * b);
    y = U\y_temp;
    errors = abs(y - y_exact(x)');
    E = max(errors);
end

% MATLAB script for executing BVP for the given problem in P.4 section (b)
format long

k = 1:10;
N_k = 5 * 2.^k;  % N_k = 5*2^k for k = 1,2,...,10
h_k = pi./N_k;
E_k = zeros(1, 10);

y0 = 0; 
yN = 0;

fx = @(x) 3 - (6*x/ pi);

% Exact Solution
y_exact = @(x) 12*(1-cos(x/2) + sin(x/2) - 2*x/pi);

for i = 1:10
    [x, y, E] = BVP(fx, N_k(i), y_exact);
    E_k(i) = E;
    fprintf('Completed k=%d with error=%e\n', i, E);
end

figure;
loglog(h_k, E_k, 'bo-', 'LineWidth', 1.5);
hold on;
ref_line = h_k.^2;
loglog(h_k, ref_line, 'r--', 'LineWidth', 1.5, 'DisplayName', 'O(h^2) Reference');


grid on;
title('Convergence Analysis');
xlabel('Step size (h) - log scale');
ylabel('Maximum Error (E) - log scale');
legend('Location', 'best');

% observed order of convergence
p = polyfit(log(h_k), log(E_k), 1);
fprintf('Observed order of convergence: %.2f\n', p(1));