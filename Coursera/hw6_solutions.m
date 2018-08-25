move_me([1,2,3,4],3);

halfsum([1,2;4,5;7,9]);

small_elements([1 1; 7 4; 6 5]);

approximate_e(3);

spiral_diag_sum(1);

tri=triangle_wave(20);

max_product([1 2 2 1 3 1],3);

pendulum(10,2.15);

% function to rearrange elements of a matrix
function w=move_me(v,a)
    %if there is no value of a, take a=0
   if ~exist('a','var'),a=0;end
   %v(v~=a)takes the part of the array without a, v(v==a) takes the part = a
   w=[v(v~=a) v(v==a)];
end

%function to compute sum of lower most right side triangle in an X*2 matrix
function u = halfsum(P)
    u1 = P(end:-1:1, 1:end);
    u2 = triu(u1);
    u = sum(u2(:));
end

%function to indicate indices of all elements in a matrix where product of indices is greater than the element
function y = small_elements(v)
    [r,c] = size(v);
    n=0;
    y = [];
    for j = 1:c
      for i = 1:r
          if v(i,j) < i*j
              n = n+1;
              y = [y; i j];            
          end
       end
    end
end

%function to compute euler's number
function [approx_e, k] = approximate_e (delta)
% Set the variables for the while loop.
   k = 0;
   fact = 1;
   approx_e=1;
   while abs(approx_e - exp(1)) > delta
    %  The counter k is necesary for factorial calculus. If you put it after
    %  the approx_e, it will add an addional number since the condition will be
    %  reevaluated.
       k=k+1;
        % For factorial calculus one could use: 
        % fact = fact * (1/k) or prod([1 : n]) 
        % fact and approx_e is calculated to recursive method.
       fact = fact * (1/k);
       approx_e = approx_e + fact; 
   end
   approx_e;
   k;
end

%function that takes an odd positive integer n as an input and computes the sum of all the elements in the two diagonals of the n-by-n spiral matrix
function out = spiral_diag_sum(n)
    A = 3:2:n; 
    out = 1 + sum( 4*A.^2 - 6*(A-1)); % The formula "f(n) = 4n^2-6(n-1)+f(n-2)"
end

%function to computes the sum as per the given formula
function S = triangle_wave(n)                                      
   t = linspace(0, 4*pi, 1001);
   S = zeros(size(t));   % Pre-allocation
   k = 0:n;              % Not 1:n
   for tIndex = 1 : length(t) 
      numerator   = ((-1) .^ k) .* sin(t(tIndex) .* (2 * k + 1));
      denominator = (2 .* k + 1) .^ 2;
      S(tIndex)   = sum(numerator ./ denominator);
   end
end

% max product function
function [p,index]=max_product(v,n)
a=length(v);
if(n>a)
    p=0;
    index=-1;
else
x=[];
for i=1:a-n+1
    x(:,i)=prod(v(i:1:i+n-1))
end
p=max(x);
a=(x==p);
n=0;
for k=1:length(a)
    if(a(k)==1)
        in=k;
        break;
    end
end
index=in;
end

% pendulum function
function [T] = pendulum(L,a0)
      T = 0;
      if L > 0
          dt = 1.e-6;
          a_velocity = 0; 
          g = 9.8;
          theta = abs(a0); 
          while theta > 0
              a_acceleration = g*sin(theta)/L;
              a_velocity = a_velocity + dt * a_acceleration;
              theta = theta - dt * a_velocity;
              T = T + dt;
          end
      T = T*4;
      end
end