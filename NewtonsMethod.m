clc,clear all,close all

format longG

f = @(x) x.^3 + 2 * x.^2 + 10 * x -20;
df = @(x) (3 * x.^2) + (4 * x) +10;

low = [0,0,0,0,0,0];

high = [2.0,2.0,2.0,10.0,10.0,10.0];

tolerance = [1e-6,1e-8,1e-10,1e-6,1e-8,1e-10];

m_old=0;

plot_it = 1;

for n= 1:3
    xRV = [low(n),high(n)];
    NewtonMethod(f,df,xRV,tolerance(n),plot_it); 
    plot_it = plot_it + 2;
end
function NewtonMethod(f,df,xRV,tol,plot_it)
disp('Newtons Method')
figure(1)
fplot(f)
hAxis = gca;
hAxis.YAxisLocation = 'origin';
hAxis.XAxisLocation = 'origin';
x0 =(xRV(1) + xRV(2)) / 2; % Initial guess
N = 10; % Maximum number of iterations
x = zeros(N + 1,1); % Preallocate solution vector where row => iteration
x(1) = x0; % Set initial guess
% Newton's Method algorithm
n = 2;
nfinal = N + 1; % Store final iteration if tol is reached before N iterations
while (n <= N + 1)
 fe = f(x(n - 1));
 fpe = df(x(n - 1));
 x(n) = x(n - 1) - fe/fpe;
 if (abs(fe) <= tol)
 nfinal = n; % Store final iteration
 break;
 end
 n = n + 1;
end

% Plot evolution of the solution
figure(2)
subplot(3,2,plot_it)
plot(0:nfinal-1,x(1:nfinal))
title('Iteration vs X0')
xlabel('Iterations')
ylabel('x0')
subplot(3,2,plot_it+1)
plot(0:nfinal-1,f(x(1:nfinal)))
title('Iteration vs f(x)')
xlabel('Iterations');
ylabel('f(x)');
end