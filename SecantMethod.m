
clc,clear all,close all;
format longG;
maxiter = 100; % max number of iteration before get the answer
f = @(x) x.^3+2*x.^2+10*x-20

low = [0,0,0,0,0,0];

high = [2.0,2.0,2.0,10.0,10.0,10.0];

tolerance = [1e-6,1e-8,1e-10,1e-6,1e-8,1e-10];

plot_it = 1;

for n= 1:3
    SecantMet(f,tolerance(n),low(n),high(n),plot_it); 
    plot_it = plot_it + 2;
end

function SecantMet(f,tol,lower,higher,plot_it)
figure(1)
fplot(f,[-100,100]);
hAxis = gca;
hAxis.XAxisLocation = 'origin';        
hAxis.YAxisLocation = 'origin';
x_0_vec = [];
fx_0_vec = [];

maxiter=1000;
xn = (lower*f(higher) - higher*f(lower))/(f(higher) - f(lower));
disp('xn-2              f(xn-2)                 xn-1              f(xn-1)               xn              f(xn)');
disp(num2str([lower f(lower) higher f(higher) xn f(xn)],'%20.7f'));
flag = 1; 
x_0_vec(end + 1) = xn;
fx_0_vec(end + 1) = f(xn);
while abs(f(xn)) > tol
    lower = higher;
    higher = xn;
    xn = (lower*f(higher) - higher*f(lower))/(f(higher) - f(lower));
    x_0_vec(end + 1) = xn;
    disp(num2str([lower f(lower) higher f(higher) xn f(xn)],'%20.7f'));
    fx_0_vec(end + 1) = f(xn);
    flag = flag + 1;
    if(flag == maxiter)
        break;
    end
end
iterations = [1:flag];
figure(2)
subplot(3,2,plot_it);
plot(iterations,x_0_vec);
title('Iteration vs X0');
xlabel('Iterations')
ylabel('x0')
subplot(3,2,plot_it+1);
plot(iterations,fx_0_vec);
title('Iteration vs f(x)');
xlabel('Iterations')
ylabel('f(x)')
if flag < maxiter
    disp(['Root is x = ' num2str(xn)]);
    Root = xn
else
    disp('Root does not exist'); 
end
end