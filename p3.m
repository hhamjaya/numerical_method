% Matlab script for curve fitting
t = [0; 0.5; 1; 1.5; 2; 2.5; 3; 3.5; 4; 4.5; 5; 5.5];
y = [1.000; 0.994; 0.990; 0.985; 0.979; 0.977; 0.972; 0.969; 0.967; 0.960; 0.956; 0.952];
% Part (a): Use Linearization and Manual Normal Equations
Z = log(y);
% Compute sums needed for the normal equations
n = length(t);
sum_t = sum(t);
sum_z = sum(Z);
sum_tz = sum(t .* Z);
sum_t2 = sum(t .^2);
% Set up the normal equations
% [n sum_t ] [b] = [sum_z ]
% [sum_t sum_t2] [a] = [sum_tz]
% Create matrices
A = [n, sum_t; sum_t, sum_t2];
b_vec = [sum_z; sum_tz];
% Solve for coefficients
coefficients = A \ b_vec;
b = coefficients(1);
a = coefficients(2);
% Compute k and beta
k = -a; % since Z = a * t + b, and Z = log(y) = -k * t + log(beta)
beta = exp(b);
fprintf('Estimated parameters using manual normal equations:\n');
fprintf('Beta = %.6f\n', beta);
fprintf('k = %.6f\n', k);
% Part (b): Compute the RMS error
y_fitted = beta * exp(-k * t);
residuals = y - y_fitted;
RMS_error = sqrt(mean(residuals.^2));
fprintf('RMS error of the fit: %.6e\n', RMS_error);
% Part (c): Plot the data and the fitted curve
t_fit = linspace(min(t), max(t), 100);
y_fit = beta * exp(-k * t_fit);
figure;
plot(t, y, 'bo', 'MarkerFaceColor', 'b', 'DisplayName', 'Data Points');
hold on;
plot(t_fit, y_fit, 'r-', 'LineWidth', 2, 'DisplayName', 'Fitted Exponential Curve');
hold off;
xlabel('Time (years)');
ylabel('Intensity');
title('Least Squares Exponential Fit to Radioactivity Data');
legend('Location', 'best');
grid on;
% Part (d): Estimate the radioactive half-life
half_life = log(2) / k;
fprintf('Estimated radioactive half-life: %.6f years\n', half_life);