%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Mathworks Cody: Cody Challenge by Cody Team    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%solutions of questions 1-19

%Problem 1. Times 2 - START HERE
function y = times2(x)
    y=2*x;
end

%Problem 2. Make the vector [1 2 3 4 5 6 7 8 9 10]
function x = oneToTen
  x = 1:1:10
end

%Problem 3. Find the sum of all the numbers of the input vector
function y = vecsum(x)
   y = sum(x)
end

%Problem 4. Make a checkerboard matrix
function a = checkerboard(n)  
    a = repmat(eye(2), n, n);  
    a = a(1:n, 1:n);  
end

%Problem 5. Triangle Numbers
function t = triangle(n)
 t = sum([1:1:n])
end

%Problem 6. Select every other element of a vector
function y = everyOther(x)
  y = x(1:2:end);
end

%Problem 7. Column Removal
function B = column_removal(A,n)
  A(:,n)=[]  
  B = A
end

%Problem 8. Add two numbers
function c = add_two_numbers(a,b)
  c = a+b;
end

%Problem 9. Who Has the Most Change?
function b = most_change(a)
  values= [0.25, 0.05, 0.10, 0.01]';
  amt_total= a*values;
  [~, b] = max(amt_total);
end

%Problem 10. Determine whether a vector is monotonically increasing
function tf = mono_increase(x)
  tf = false;
  if sum(diff(x)>0)==(length(x)-1)
      tf = true;
  end
end

%Problem 11. Back and Forth Rows
function b = back_and_forth(n)
  b = zeros(n, n); now = 1;  
for k = 1:n  
    if mod(k, 2)  
        b(k,:) = now:now+n-1;  
    else  
        b(k,:) = now+n-1:-1:now;  
    end  
    now = now + n; 
end

%Problem 12. Fibonacci sequence
function f = fib(n)
  a = 1; b = 1; f = 1;  
for k = 3:n  
  f = a + b; a = b; b = f; 
end
end

%Problem 13. Remove all the consonants
function s2 = refcn(s1)
  cons = ["b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z"];
    s2 = replace(s1,cons,"");
    s2 = replace(s2,upper(cons),"");
end

%%%% Alternative Solution:
function s2 = refcn(s1)
e='(?=[a-z])[^aeiou]'
s2=s1
s2(regexpi(s1,e))=[]
end

%Problem 14. Find the numeric mean of the prime numbers in a matrix.
function out = meanOfPrimes(in)
  out = sum(in(isprime(in)))/sum(sum(isprime(in)));
end

%Problem 15. Find the longest sequence of 1's in a binary sequence.
function y = lengthOnes(x)
  cnt = 0; y = 0;  
for k = 1:length(x)  
    if x(k) == '1'  
        cnt = cnt + 1;  
    else  
        y = max(y, cnt);  
        cnt = 0;  
    end  
end  
y = max(y, cnt); 
end

%Problem 16. Return the largest number that is adjacent to a zero
function y = nearZero(x)
  y = -inf;  
for k = 1:length(x)  
    if x(k) == 0  
        if k - 1 >= 1  
            y = max(y, x(k - 1));  
        end  
        if k + 1 <= length(x)  
            y = max(y, x(k + 1));  
        end  
    end  
end

%Problem 17. Find all elements less than 0 or greater than 10 and replace them with NaN
function y = cleanUp(x)
   x(x<0 | x>10)=NaN
   y = x;
end

%Problem 18. Bullseye Matrix
function a = bullseye(n)
    regexp '' '(?@d = (n+1)/2\na = zeros(n)+d\nfor i = 1:d\nt = i+1:n-i\na(t,t) = a(t,t)-1\nend)'
end

%Problem 19. Swap the first and last columns
function B = swap_ends(A)
    AL = A(:,1)
    AR = A(:,end)
    A(:,end) = AL
    A(:,1) = AR
    B = A
end