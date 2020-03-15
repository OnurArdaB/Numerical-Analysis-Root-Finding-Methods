clc,clear all,close all
format longG
func = @(x) x.^3 + 2 * x.^2 + 10 * x -20;

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
    x = bisection(func, low(n), high(n), tolerance(n),n,m_old,plot_it); 
    plot_it = plot_it + 3;
end

function  m = bisection(f, low, high, tol,n,m_old,plot_it)
disp('Bisection Method'); 


x_lim_down = low;
x_lim_up = high;

f_result = [];
x_result = [];
iterations=[];
error = [];

% Evaluate both ends of the interval
y1 = f(low);
y2 = f(high);
i = 0; 

% Display error and finish if signs are not different
if y1 * y2 > 0
   disp('Have not found a change in sign. Will not continue...');
   m = 'Error'
   return
end 

% Work with the limits modifying them until you find a function close enough to zero.
disp('Iter    low              high            x0              f(x0)');
while (abs((high + low)/2) >= tol)
    i = i + 1;
    
    % Find a new value to be tested as a root
    
    m = low + (high - low)/2;
    y3 = f(m);
    if y3 == 0 || (high - low)/2<tol 
        fprintf('Root at x = %f \n\n', m);
        w = f(m);
        sprintf('\n x = %.16f produces f(x) = %.16f \n %i iterations\n',m,y3,i-1)
        sprintf('Approximation with tolerance = %.16f \n', vpa(tol))
        figure(2)
        subplot(3,3,plot_it)
        plot(iterations,f_result)
        
        title('Iteration vs f(x)')
        xlabel('Iterations');
        ylabel('f(x)');
        subplot(3,3,plot_it + 1)
        plot(iterations,x_result)
       
        title('Iteration vs X0')
        xlabel('Iterations')
        ylabel('x0')
        
        
        subplot(3,3,plot_it + 2)
        plot(iterations,error)
        
        title('Iteration vs Error')
        xlabel('Iterations')
        ylabel('Error')
        return
    end
    %if i<5
       sprintf('%2i \t %.16f \t %.16f \t %.16f \t %.16f \n', i-1, low, high, m,y3)   
    %end
    
    error(end + 1) = m-m_old;
    iterations(end+1) = i-1;
    x_result(end + 1) = m;
    f_result(end + 1) = y3;
   
    % Update the limits
    if y1 * y3 > 0
        low = m;
        m_old = m;
        y1 = y3;
    else
        high = m;
        m_old = m;
    end
end 

end
