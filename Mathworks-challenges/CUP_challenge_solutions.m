%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Mathworks Cody: CUP Challenge by Ned Gulley    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Problem 1974. Length of a short side
%Calculate the length of the short side, a, of a right-angled triangle with hypotenuse of length c, and other short side of length b.
function a = calculate_short_side(b, c)
  a = sqrt((c^2)-(b^2))
end

%Problem 2015. Length of the hypotenuse
%Given short sides of lengths a and b, calculate the length c of the hypotenuse of the right-angled triangle.
function c = hypotenuse(a,b)
  c = sqrt(a^2+b^2)
end

%Problem 2016. Area of an equilateral triangle
%Calculate the area of an equilateral triangle of side x.
function y = equilateral_area(x)
  y = (sqrt(3)/4)*(x^2); 
end

%Problem 2017. Side of an equilateral triangle
%If an equilateral triangle has area A, then what is the length of each of its sides, x?
function x = side_length(A)
  x = sqrt((4*A)/sqrt(3));
end

%Problem 2018. Side of a rhombus
%If a rhombus has diagonals of length x and x+1, then what is the length of its side, y?
function y = rhombus_side(x)
  y = sqrt(((x/2)^2)+(((x+1)/2)^2));
end

%Problem 2019. Dimensions of a rectangle
%The longer side of a rectangle is three times the length of the shorter side. 
%If the length of the diagonal is x, find the width and length of the rectangle.
function [width, length] = findRectangleDimensions(x)
  width = x/(sqrt(10));
  length = (3*x)/(sqrt(10));
end

%Problem 2020. Area of an Isoceles Triangle
%An isosceles triangle has equal sides of length x and a base of length y. Find the area, A, of the triangle.
function ans = isocelesArea(x,y)
 (0.25*y*sqrt((4*x^2)-y^2));
end

%Problem 2021. Is this triangle right-angled?
%Given three positive numbers a, b, c, where c is the largest number, return true if the triangle with sides a, b and c is right-angled. 
%Otherwise, return false.
function ans = isRightAngled(a, b, c)
  if ((a^2)+(b^2)==(c^2))
      true;
  else
    false;
  end
end

%Problem 2022. Find a Pythagorean triple
%Given four different positive numbers, a, b, c and d, provided in increasing order: a < b < c < d, find if any three of them comprise sides of a right-angled triangle. 
%Return true if they do, otherwise return false.
function flag = isTherePythagoreanTriple(a, b, c, d)
  if ((a^2)+(b^2))==(c^2) || ((a^2)+(b^2))==(d^2) || ((a^2)+(c^2))==(d^2) || ((c^2)+(b^2))==(d^2)
      flag=true;
  else
    flag = false;
  end
end

%Problem 2023. Is this triangle right-angled?
%Given any three positive numbers a, b, c, return true if the triangle with sides a, b and c is right-angled. 
%Otherwise, return false.
function flag = isRightAngled(a,b,c)
  if ((a^2)+(b^2)==(c^2)) || ((b^2)+(c^2)==(a^2)) || ((a^2)+(c^2)==(b^2)) 
    flag = true;
  else
      flag= false;
end

%Problem 2024. Triangle sequence
%A sequence of triangles is constructed in the following way:
%1) the first triangle is Pythagoras' 3-4-5 triangle
%2) the second triangle is a right-angle triangle whose second longest side is the hypotenuse of the first triangle, and whose shortest side is the same length as the second longest side of the first triangle
%3) the third triangle is a right-angle triangle whose second longest side is the hypotenuse of the second triangle, and whose shortest side is the same length as the second longest side of the second triangle etc.
%Each triangle in the sequence is constructed so that its second longest side is the hypotenuse of the previous triangle and its shortest side is the same length as the second longest side of the previous triangle.
%What is the area of a square whose side is the hypotenuse of the nth triangle in the sequence?
function area = triangle_sequence(n)
  A1=9
  A2=16
  for k=1:n
      A=A1+A2
      A1=A2
      A2=A
  end
    area = A2;
end

%alternative solution to problem 2024
function area = triangle_sequence(n)
    i = 1;
    a = 3^2;
    b = 4^2;
    
    while i <= n
        area = a + b;
        a = b;
        b = area;
        i = i + 1;
    end
end
