clc,clear all ,close all 
func = @(x) x.^3 + 2 * x.^2 + 10 * x - 20;
x_LU = [];

low = [0,0,0,0,0,0];

high = [2.0,2.0,2.0,10.0,10.0,10.0];

tolerance = [1e-6,1e-8,1e-10,1e-6,1e-8,1e-10];

m_old=0;

plot_it = 1;

figure(1)
fplot(func)
hAxis = gca;
hAxis.XAxisLocation = 'origin';
hAxis.YAxisLocation = 'origin';
title('Function')

for n= 4:6
    x_LU = [low(n),high(n)];
    x = FalsePositionNM(func,x_LU,tolerance(n),plot_it) 
    plot_it = plot_it + 3;
end
function [xR,err,n,xRV,errV] = FalsePositionNM(AF,xb,ed,plot_it)
disp('False Position Method')
err = 1; % initial approximate relative error = 100%
k = 1; % initial counter
disp('Iter    low              high            x0              f(x0)');
func_vec = [];
while ed < err % compares desired versus calculated error
    xL = xb(1); % lower x

    xU = xb(2); % upper x

    fxL = AF(xL); % lower f(x)
    fxU = AF(xU); % upper f(x)
    xR = xU - ((fxU*(xL-xU))/(fxL-fxU)); % x root using false position method
    xRV(k+1) = xR; % stores the x root per iteration in a vector
    err = abs(xRV(k+1) - xRV(k)); % approximate relative error
    errV(k+1) = err; % stores the error into a vector
    fxR = AF(xR); % f(x root)
    func_vec(end+1) = fxR;
    % evaluate f(x) signs
    if fxL*fxR < 0
        xb = [xL xR]; % new guess x bracket = [xL xU]
    elseif fxR*fxU < 0
        xb = [xR xU]; % new guess x bracket = [xL xU]
    end
    %if k < 10
    fprintf('%2i \t %f \t %f \t %f \t %f \n', k, xb(1), xb(2), xR,fxR);
    %end
    k = k+1; % increase counter
end
n = k - 1; % number of iterations

xRV = xRV(2:end); % readjust x root vector

errV = errV(2:end); % readjust approximate absolute error vector
iterations= 1:n;
figure(2)
subplot(3,3,plot_it)
plot(iterations,func_vec)
title('Iteration vs f(x)')
xlabel('Iterations');
ylabel('f(x)');
subplot(3,3,plot_it + 1)
plot(iterations,xRV)
title('Iteration vs X0')
xlabel('Iterations')
ylabel('x0')
subplot(3,3,plot_it + 2)
plot(iterations,errV)
title('Iteration vs Error')
xlabel('Iterations')
ylabel('Error')
end