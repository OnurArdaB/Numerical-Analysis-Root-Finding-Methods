clc,clear all,close all
format longG
f = @(x)  x.^3 + 2*x.^2 + 10*x - 20;
low = [0,0,0,0,0,0];

high = [2.0,2.0,2.0,10.0,10.0,10.0];

tolerance = [1e-6,1e-8,1e-10,1e-6,1e-8,1e-10];

plot_it = 1;

figure(1)
fplot(f)
hAxis = gca;
hAxis.XAxisLocation = 'origin';
hAxis.YAxisLocation = 'origin';

for n= 1:3
    ModRegulaFalsi(f,low(n),high(n),tolerance(n),plot_it); 
    plot_it = plot_it + 2;
end

function ModRegulaFalsi(f,a,b,tol,plot_it)
disp('Modified Regula Falsi')
title('Function')
x_0_vec = [];
errV = [];
errV(end+1) = 1;
maxIter = 50;
i = 2;
disp('Iter              low                     high                    x0                      f(x0)');
while i<= maxIter
    fa = f(a);
    fb = f(b);
    
    c = (a*fb - b * fa)/(fb-fa);
    
    if fa * f(c) < 0
        k = abs((2*f(c))/(b-c));
        d = ((1+k)*a*fb-(b*fa)) / ((1+k)*fb - fa);
        if f(d)*fa<0
        b=d;
        else
        b=c;
        a=d;
        end
        fprintf('%2i \t %.16f \t %.16f \t %.16f \t %.16f \n', i-1, a, b, d,f(d)) ;
        x_0_vec(end+1) = d;
     else if fa * f(c)>0
        k = abs((0.5*f(c))/(b-c)); 
        d = ((1+k)*b*fa-(a*fb)) / ((1+k)*fa - fb);
        if f(d)*fa<0
            a=d;
        else
            a=c;
            b=d;
        end
            fprintf('%2i \t %.16f \t %.16f \t %.16f \t %.16f \n', i-1, a, b, d,f(d))     ;
            x_0_vec(end+1) = d;
         end
         
   end
   if abs(f(d))<tol
       Root = d;
       break
   else
       i = i+1;
   end
end

iter = i-1
iterations= 1:iter;
figure(1)
subplot(3,2,plot_it)
plot(iterations,f(x_0_vec(1:iter)))
title('Iteration vs f(x)')
xlabel('Iterations');
ylabel('f(x)');
subplot(3,2,plot_it + 1)
plot(iterations,x_0_vec)
title('Iteration vs X0')
xlabel('Iterations')
ylabel('x0')
end