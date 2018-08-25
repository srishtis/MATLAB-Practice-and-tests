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

%function to create a polynomial equation
function p = poly_val(c0,c,x)
    if isempty(c)
      p = c0;
    else
      p = c0 + power(x, 1:numel(c))*c(:);
    end
end

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