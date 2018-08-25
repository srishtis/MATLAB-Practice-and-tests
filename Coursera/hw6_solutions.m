move_me([1,2,3,4],3);

halfsum([1,2;4,5;7,9]);

small_elements([1 1; 7 4; 6 5]);

approximate_e(3);

spiral_diag_sum(1);

tri=triangle_wave(20);

max_product([1 2 2 1 3 1],3);

pendulum(10,2.15);

%Q1: The function move_me is defined like this: function w = move_me(v,a). The first input
%argument v is a row-vector, while a is a scalar. The function moves every element of v that is equal
%to a to the end of the vector. For example, the command
%>> x = move_me([1 2 3 4],2);
%makes x equal to [1 3 4 2]. If a is omitted, the function moves occurrences of zeros.

% function to rearrange elements of a matrix
function w=move_me(v,a)
    %if there is no value of a, take a=0
   if ~exist('a','var'),a=0;end
   %v(v~=a)takes the part of the array without a, v(v==a) takes the part = a
   w=[v(v~=a) v(v==a)];
end

%Q2: Write a function called halfsum that takes as input an at most two-dimensional array A and
%computes the sum of the elements of A that are in the lower right triangular part of A, that is,
%elements in the counter-diagonal (going from the bottom left corner, up and to the right) and
%elements that are to the right of it. For example, if the input is [1 2; 3 4; 5 6; 7 8], then
%the function would return 21.

%function to compute sum of lower most right side triangle in an X*2 matrix
function u = halfsum(P)
    u1 = P(end:-1:1, 1:end);
    u2 = triu(u1);
    u = sum(u2(:));
end

%Q3: Write a function called small_elements that takes as input an array named X that is a matrix or
%a vector. The function identifies those elements of X that are smaller than the product of their two
%indexes. For example, if the element X(2,3) is 5, then that element would be identified because 5
%is smaller than 2 * 3. The output of the function gives the indexes of such elements found in
%column-major order. It is a matrix with exactly two columns. The first column contains the row
%indexes, while the second column contains the corresponding column indexes. For example, the
%statement indexes = small_elements([1 1; 0 4; 6 5], will make indexes equal
%to [2 1; 1 2; 3 2]. If no such element exists, the function returns an empty array.

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

%Q4: Write a function called approximate_e that uses the following formula to compute e, Euler’s
%number. Instead of going to infinity, the function stops at the smallest k for which the approximation differs
%from exp(1) (i.e., the value returned MATLAB’s built-in function) by no more than the positive
%scalar, delta, which is the only input argument. The first output of the function is the
%approximate value of e, while the second is k. (Note: if your program or the grader takes a long
%time, you may have created an infinite loop and need to hit Ctrl-C on your keyboard.) You are not
%allowed to use the built-in function factorial.

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

%Q5: Write a function called spiral_diag_sum that takes an odd positive integer n as an input and
%computes the sum of all the elements in the two diagonals of the n-by-n spiral matrix. For example,
%starting with the number 1 and moving to the right in a clockwise direction, a 5-by-5 spiral is
%formed as follows:
%21 22 23 24 25
%20 7 8 9 10
%19 6 1 2 11
%18 5 4 3 12
%17 16 15 14 13
%The sum of the red elements above is 101. Hint: the problem does not ask for the matrix itself.
%(Inspired by Project Euler.)

%function that takes an odd positive integer n as an input and computes the sum of all the elements in the two diagonals of the n-by-n spiral matrix
function out = spiral_diag_sum(n)
    A = 3:2:n; 
    out = 1 + sum( 4*A.^2 - 6*(A-1)); % The formula "f(n) = 4n^2-6(n-1)+f(n-2)"
end

%Q6: Write a function called triangle_wave that computes the sum
%Sum(k=0 to n) ((-1)^k* sin((2k+1)t)/(2k+1)^2
%for each of 1001 values of t uniformly spaced from 0 to 4π inclusive. The input argument is a scalar
%non-negative integer n, and the output argument is a row vector of 1001 such sums—one sum for
%each value of t. You can test your function by calling it with n == 20 or greater and plotting the
%result and you will see why the function is called “triangle_wave”.

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

%Q7: Write a function max_product that takes v a vector and n, a positive integer, as inputs and
%computes the largest product of n consecutive elements of v. It returns the product and the index
%of the element of v that is the first term of the product. If there are multiple such products in v,
%the function must return the one with the smallest starting index. As an example, the following call
%>> [product, ind] = max_product([1 2 2 1 3 1],3);
%will assign 6 to product and 3 to ind since the max 3-term product in the input vector is 2*1*3.
%If v has fewer than n elements, the function returns 0 and -1, respectively.

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

%Q8: Write a function called pendulum that is called like this: T = pendulum(L,a0) , where all arguments are
%scalars and a0 is a positive number less than π . The function calculates the period T of a simple pendulum,
%which is the time required for a weight attached to a rod of length L and negligible weight to start from rest, swing
%with no friction under the influence of gravity from an initial angle a0 , to – a0 and back to a0 again,
%as shown in the figure. The motion is determined by physics using the following definitions, where
%units [square brackets] are provided. 
%The function starts its calculation with the pendulum angle θ equal to a0 and then calculates a
%sequence of decreasing pendulum angles, each at a time separated from the one before it by ∆t =
%1 × 10 -6 s. It continues until the pendulum has passed its lowest point, at which θ = 0. The elapsed
%time equals T/4 .
%The calculation at each time step proceeds as follows: The angular acceleration α is set equal to
%−gsin θ ⁄ L . Then the angular velocity ωω is increased by the product of the angular acceleration
%and ∆t. That new angular velocity is then used to obtain a new θ by adding the product of the
%angular velocity and ∆t to the old θ.

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
