function Problem1()
    interval = -50:50;
    f=@(x) tanh(x);
    % (a) Visualizing possible solution
    fh = f(interval);
    plot(interval, fh, 'blue')
    hold on
    plot(interval, zeros(101), 'black')
    title('Equation in the interval from -50 to 50')
    xlabel('x')
    ylabel('f')
    legend('f(x) = tanh(x)')
    legend('Location', 'best');
    saveas(gcf, 'question1.png')
end