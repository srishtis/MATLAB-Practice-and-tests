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

% function to compute the area and circumference of a circle
function [area, cf]= circle (r,pi)
    area= pi*r^2;
    cf=2*pi*r;
    fprintf('the circumference of the circle is %f\n',cf);
    fprintf('the area of the circle is %f\n', area);
end

% function to extract element at even indices location in an input matrix
function out = even_index (M)
    out= M(2:2:end,2:2:end);
    fprintf('the elements at even indices are %f\n',out);
end

% function to creverse the order of elements in a row vector input
function w = flip_it(v)
    w = v(end:-1:1);
    fprintf('%f\t',w);
end 

% function to extract the n-by-n top right matrix of an input matrix N
function M = top_right(N,n)
    M = N(1:n,end-n+1:end);
end

% function to compute the sum of elements on boundary/ perimeter of a matrix
function x = peri_sum(A) 
    x = sum(A(1,:)) + sum(A(end,:)) + sum(A(:,1)) + sum(A(:,end)) - ( A(1,1) + A(1,end) + A(end,1) + A(end,end));
    fprintf('Sum of elements on the perimeter is %f\n',x);
end

% function to convert km to miles and compute light speed in minutes
function [mins, mile] = light_speed(km)
    mile= km/1.609;
    mins = km/3e5/60;
    fprintf('Minutes: %f\n',mins);
    fprintf('Miles: %f\n',mile);
end

% function to convert km to miles and compute light speed in minutes
function amag = accelerate(F1,F2,m)
    F = F1 + F2;
    amag=sqrt(sum(F.^2))/m;
    fprintf('acceleration of the body: %f\n',amag);
end

% function to calculate the income of a company based on price and rate inputs
function earn = income(rate, price)
    earn= (rate.*2*8*6)*price';
    fprintf('Total earnings of the company: %f\n',earn);
end