r=3;
circle(r,pi);

M=[1 2 3; 4 5 6; 7 8 9];
even_index(M);

v= [1 2 3];
flip_it(v);

N= [1,2,3,4,8;7,6,5,4,2;0,9,7,9,8;1,2,1,2,0];
n=3;
M=top_right(N,n);
M;

A=[1,2,5;4,7,8;3,0,6];
peri_sum(A);

km=[10000,40000,7000];
light_speed(km);

F1=[1 2 3]';
F2=[2 5 0]';
m=10;
accelerate(F1,F2,m);

rate = [6 6 2 3 2 8];
price = [3 2 4 8 9 5];
answer = income(rate, price);

%Q1: Write a function called circle that takes a scalar input r. It needs to return an output called
%area that is the area of a circle with radius r and a second output, cf that is the circumference of
%the same circle. You are allowed to use the built-in function pi. In fact, you need to use it to get
%the value of π as accurately as possible.

% function to compute the area and circumference of a circle
function [area, cf]= circle (r,pi)
    area= pi*r^2;
    cf=2*pi*r;
    fprintf('the circumference of the circle is %f\n',cf);
    fprintf('the area of the circle is %f\n', area);
end

%Q2: Write a function called even_index that takes a matrix, M, as input argument and returns a
%matrix that contains only those elements of M that are in even rows and columns. In other words, it
%would return the elements of M at indices (2,2), (2,4), (2,6), ..., (4,2), (4,4), (4,6), ..., etc. Note that
%both the row and the column of an element must be even to be included in the output. The
%following would not be returned: (1,1), (2,1), (1,2) because either the row or the column or both
%are odd. As an example, if M were a 5-by-8 matrix, then the output must be 2-by-4 because the
%function omits rows 1, 3 and 5 of M and it also omits columns 1, 3, 5, and 7 of M.

% function to extract element at even indices location in an input matrix
function out = even_index (M)
    out= M(2:2:end,2:2:end);
    fprintf('the elements at even indices are %f\n',out);
end

%Q3: Write a function called flip_it that has one input argument, a row vector v, and one output
%argument, a row vector w that is of the same length as v. The vector w contains all the elements of
%v, but in the exact opposite order. For example, is v is equal to [1 2 3] then w must be equal to
%[3 2 1]. You are not allowed to use the built-in function flip, fliplr, or flipud.

% function to creverse the order of elements in a row vector input
function w = flip_it(v)
    w = v(end:-1:1);
    fprintf('%f\t',w);
end 

%Q4: Write a function called top_right that takes two inputs: a matrix N and a scalar non-negative
%integer n, in that order, where each dimension of N is greater than or equal to n. The function
%returns the n-by-n square subarray of N located at the top right corner of N.

% function to extract the n-by-n top right matrix of an input matrix N
function M = top_right(N,n)
    M = N(1:n,end-n+1:end);
end

%Q5: Write a function called peri_sum that computes the sum of the elements of an input matrix A
%that are on the “perimeter” of A. In other words, it adds together the elements that are in the first
%and last rows and columns. Note that the smallest dimension of A is at least 2, but you do not need
%to check this. Hint: do not double count any elements!

% function to compute the sum of elements on boundary/ perimeter of a matrix
function x = peri_sum(A) 
    x = sum(A(1,:)) + sum(A(end,:)) + sum(A(:,1)) + sum(A(:,end)) - ( A(1,1) + A(1,end) + A(end,1) + A(end,end));
    fprintf('Sum of elements on the perimeter is %f\n',x);
end

%Q6: Write a function called light_speed that takes as input a row vector of distances in kilometers
%and returns two row vectors of the same length. Each element of the first output argument is the
%time in minutes that light would take to travel the distance specified by the corresponding element
%of the input vector. To check your math, it takes a little more than 8 minutes for sunlight to reach
%Earth which is 150 million kilometers away. The second output contains the input distances
%converted to miles. Assume that the speed of light is 300,000 km/s and that one mile equals 1.609
%km.

% function to convert km to miles and compute light speed in minutes
function [mins, mile] = light_speed(km)
    mile= km/1.609;
    mins = km/3e5/60;
    fprintf('Minutes: %f\n',mins);
    fprintf('Miles: %f\n',mile);
end

%Q7: Write a function that is called like this: amag = accelerate(F1,F2,m). F1 and F2 are
%three-element column vectors that represent two forces applied to a single object. The argument m
%equals the mass of the object in units of kilograms. The three elements of each force equal the x, y,
%and z components of the force in Newtons. The output variable amag is a scalar that is equal to the
%magnitude of the object’s acceleration. The function calculates the object’s acceleration vector a by
%using Newton’s law: F = ma, where F is the sum of F1 and F2. Then it returns the magnitude of a.
%Hint: we are talking about physical vectors here, so the Pythagorean theorem will come in handy.

% function to convert km to miles and compute light speed in minutes
function amag = accelerate(F1,F2,m)
    F = F1 + F2;
    amag=sqrt(sum(F.^2))/m;
    fprintf('acceleration of the body: %f\n',amag);
end

%Q8: Write a function called income that takes two row vectors of the same length as input arguments.
%The first vector, rate contains the number of various products a company manufactures per hour
%simultaneously. The second vector, price includes the corresponding per item price they sell the
%given product for. The function must return the overall income the company generates in a week
%assuming a 6-day work week and two 8-hour long shifts per day.

% function to calculate the income of a company based on price and rate inputs
function earn = income(rate, price)
    earn= (rate.*2*8*6)*price';
    fprintf('Total earnings of the company: %f\n',earn);
end
