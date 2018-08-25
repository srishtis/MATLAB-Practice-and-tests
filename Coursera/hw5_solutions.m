v=16;
q=99;
eligible (v,q);

d=4;
a=20;
pay=fare(d,a);

v = [2,1,3];
sort3(v);

day_diff( 1, 30, 2, 1 );

holiday(1,1);

poly_val(-17,[],5000);

i1=3;
i2=6;
exp_average( i1,i2 );

fn=8;
D=152;
spherical_mirror_aberr( fn,D );

%Q1: Write a function called eligible that helps the admission officer of the Graduate School of Vanderbilt
%University decide whether the applicant is eligible for admission based on GRE scores. The function takes
%two positive scalars called v and q as input. They represent the percentiles of the verbal and quantitative
%portions of the GRE respectively. You do not need to check the input. The applicant is eligible if the average
%percentile is at least 92% and both of the individual percentiles are over 88%. The function returns the
%logical true or false .

% function to test eligibility using 2 inputs
function isEligible = eligible (v,q)
   avg = mean([v, q]);
   if avg >= 92 && v > 88 && q > 88
       fprintf('true\n');
       isEligible = true;
   else
       fprintf('false\n');
       isEligible = false;
   end
end

%Q2: Write a function called fare that computes the bus fare one must pay in a given city based on the distance
%travelled. Here is how the fare is calculated: the first mile is $2. Each additional mile up to a total trip
%distance of 10 miles is 25 cents. Each additional mile over 10 miles is 10 cents. Miles are rounded to the
%nearest integer other than the first mile which must be paid in full once a journey begins. Children 18 or
%younger and seniors 60 or older get a 20% discount. The inputs to the function are the distance of the
%journey and the age of the passenger in this order. Return the fare in dollars, e.g., 2.75 would be the result
%returned for a 4-mile trip with no discount.

%function to compute the fare
function p=fare(d,a)
b=round(d);
if (b<=0)
    f=2;
elseif (b==1)
    f=2;
elseif (1<b&& b<=10)
    f=2+(b-1)*0.25;
elseif (b>10)
    f = 4.25+(b-10)*0.1;
end
if (a<=18||a>=60)
    p=0.8*f;
else
    p=f;
end
end

%Q3: Write a function called sort3 that takes a 3-element vector as its sole arguments. It uses if-statements,
%possibly nested, to return the three elements of the vector as three scalar output arguments in non-
%decreasing order, i.e., the first output argument equals the smallest element of the input vector and the last
%output argument equals the largest element. NOTE: Your function may not use any built-in functions, e.g.,
%sort, min, max, median, etc.

% function to sort 3 elements
function [a,b,c] = sort3 (v)
    a=v(1);
    b=v(2);
    c=v(3);
   if a > b,  [a, b] = swap(a, b);  end
   if b > c,  [b, c] = swap(b, c);  end
   if a > b,  [a, b] = swap(a, b);  end
end

function [b, a] = swap(a, b)
end% empty function body

%Q4: Write a function called day_diff that takes four scalar positive integer inputs, month1, day1, month2,
%day2. These represents the birthdays of two children who were born in 2015. The function returns a
%positive integer scalar that is equal to the difference between the ages of the two children in days. Make
%sure to check that the input values are of the correct types and they represent valid dates. If they are
%erroneous, return -1. An example call to the function would be
%>> dd = day_diff(1,30,2,1);
%which would make dd equal 2. You are not allowed to use the built-in function datenum or datetime.
%Hint: store the number of days in the months of 2015 in a 12-element vector (e.g., 31, 28, 31, 30 ...) and use
%it in a simple formula.

%age difference function
function age_diff = day_diff( month1, day1, month2, day2 )
%DAY_DIFF compute the age difference in days
%   proper checking 
   M=[31,28,31,30,31,30,31,31,30,31,30,31];
      % Short-circuting!
   if isscalar(month1) && isscalar(day1) && isscalar(month2) && isscalar(month1) && ...
       month1 == fix(month1) && month1==fix(month1) && day1==fix(day1) && day2==fix(day2) && ...
       day1 > 0 && day2 > 0 && month1 <= 12 && month1 >= 1 && month2 <=12 && month2 >= 1 && ...
       M(month1) >= day1 && M(month2) >= day2
             d1 = day1 + sum(M(1:1:month1-1));
             d2 = day2 + sum(M(1:1:month2-1));
             dd = d2-d1;
               if dd <0
                   age_diff = dd*(-1);
               else 
                   age_diff = dd;
               end
   else 
        age_diff = -1;
    end
end

%Q5: Write a function called holiday that takes two input arguments called month and day ; both are scalar
%integers representing a month (1-12) and a day (1-31). You do not need to check that the input is valid. The
%function returns a logical true if the specified date is a holiday; if not, it returns false . For the purposes
%of this exercise, the following dates are considered holidays: January 1 st , July 4 th , December 25 th , and
%December 31 st .

%function to determine holidays
function isHoliday = holiday( month,day )
%HOLIDAY to determine if entered date is a holiday or not
%  holidays are: January 1st, July 4th, December 25th, and December 31st
   if (day == 1 && month == 1) || (day == 4 && month == 7) || (day == 25 && month == 12) || (day == 25 && month == 12) || (day == 31 && month == 12)
       fprintf('true\n');
       isHoliday = true;
   else
       fprintf('false\n');
       isHoliday = false;
   end
end

%Q6: Write a function called poly_val that is called like this p = poly_val(c0,c,x), where c0 and x are
%scalars, c is a vector, and p is a scalar. If c is an empty matrix, then p = c0. If c is a scalar, then p = c0
%+ c*x . Otherwise, p equals the polynomial,
%cc0 + cc(1)xx 1 + cc(2)xx 2 + ⋯ + cc(NN)xx NN ,
%where N is the length of the vector c. Hint: you may want to use the .^ operator.

%function to create a polynomial equation
function p = poly_val(c0,c,x)
    if isempty(c)
      p = c0;
    else
      p = c0 + power(x, 1:numel(c))*c(:);
    end
end

%Q7: Write a function called exp_average that computes the “exponentially weighted moving average,” or
%“exponential average” for short, of a sequence of scalars. The input sequence is provided to the function
%one element at a time and the function returns the current average each time. If we denote the n th element
%of the input sequence, that is, the function input at the n th invocation, by in n , then the rule for calculating
%the corresponding average out n that is to be returned by the function is:
%out 1 = in 1
%out n = b ∙ in n + (1 - b) ∙ out n-1
%where b is a coefficient between 0 and 1. You do not need to check b. In plain English, the current average
%depends on the current input and the previously computed average weighted by b and (1 - b), respectively.
%Here is how the function is expected to work. When called by two input arguments, the input sequence is
%reset, the first input argument is considered to be in 1 and the second input argument is the value of the
%coefficient b. When called with a single input argument, it is considered to be in t , that is, the current value of
%the input sequence. In both cases, the output is calculated according to the formula above. If the function is
%called for the very first time with a single input argument, the value of the coefficient b must default to 0.1.
%Hint: you should use two persistent variables to store the output and the coefficient b.

%function to compute “exponentially weighted moving average,” or “exponential average”
function [ avr ] = exp_average( i1,i2 )
  persistent b; 
  persistent a; 
      if nargin>1 && isempty(b)
          b=i2; a = i1 ; 
      elseif nargin>1 && ~isempty(b)
          b=i2; a=i1;
      elseif nargin<2 && isempty(a) && isempty(b)
          b=0.1; a = i1 ;
      elseif  nargin<2 && ~isempty(a) && ~isempty(b)
          a = b*i1+(1-b)*a;
      end
  avr = a;
end

%Q8: Write a function that is called like this: mbd = spherical_mirror_aberr(fn,D), where all
%arguments are scalars, fn is the “f-number” of a concave spherical mirror, D is its diameter in millimeters, and mbd is the mean blur
%diameter in millimeters. The f-number equals the focal length f of the mirror divided by its diameter. Ideally, all the
%rays of light from a distant object, illustrated by the parallel lines in the figure, would reflect off the mirror and
%then converge to a single focal point. The magnified view shows what actually happens. The light striking a vertical plane
%at a distance f from the mirror is spread over a circular disk. The light from the center of the mirror strikes the center of
%the disk, but light arriving from a point a distance x from the center of the mirror strikes the plane on a circle whose diameter d is equal to 
%2f tan(2θ) (1/cos θ − 1), 
%where
%θ = arcsin (x/2f) , which is the angle whose sine equals x/2f . The function calculates d for all values of
%x in the vector x = 0:delta_x:D/2, where delta_x = 0.01. Then it calculates the mean blur diameter using this weighted formula:
%mbd= (8*delta_x/D^2)* sum(xn*dn)
%where the sum includes all x(n)d(n), and returns it.

%function to compute spherical aberration
function  mbd  = spherical_mirror_aberr( fn,D )
%SPHERICAL_MIRROR_ABERR 
% fn is the “f-number” of a concave spherical mirror
% D is its diameter in millimeters
% mbd is the mean blur diameter in millimeters. 
%   Detailed explanation goes here
f=fn*D;
delta_x = 0.01;
x = 0:delta_x:D/2;
theta = asin(x/(2*f));
d=2*f*tan(2*theta).*(1./cos(theta)-1);
mbd = (8*delta_x/D^2)*x*d';
end
