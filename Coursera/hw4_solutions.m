n=2;
m=3;
Q= intquad (n,m);

deg= [90 0 360];
sindeg(deg);

N= [3,4,5;7,8,10;-1,4,-7];
simple_stats(N);

nn=1;
odd_rms(nn);

lng=75;
seg=10;
fence(lng,seg);

inp_matrix= [1,0,1,0,0,0,1]';
zero_stat(inp_matrix);

n=5;
I=reverse_diag(n);

n=3;
sum3and5muls(n);

%Q1: Write a function called intquad that takes as its input arguments two scalar positive integers
%named n and m in that order. The function returns Q, a 2n-by-2m matrix. Q consists of four n-by-m
%submatrices. The elements of the submatrix in the top left corner are all 0s, the elements of the
%submatrix at the top right are 1s, the elements in the bottom left are 2s, and the elements in the
%bottom right are 3s.

% function to create a 2n by 2m matrix with specifications of specific integers at required positions
function Q= intquad (n,m)
    a = zeros(n,m); 
    b = ones(n,m); 
    c = b*2; 
    d = b*3; 
    Q = [a b ; c d];
end

%Q2: Write a function called sindeg that takes a matrix input called deg. The function returns a matrix
%of the same size as deg with each of its elements containing the sine of the corresponding element
%of deg. Note that the elements of deg are given in degrees and not radians. As a second output,
%the function returns a scalar that contains the average value of the first output. You are not
%allowed to use the sind and cosd built-in functions, but the use of any other function is
%acceptable.

% function to compute sin of input in deg without using sind or cosd
function [sin_ans,avg_sin]= sindeg (deg)
    rad= deg.*(pi/180);
    sin_ans = sin(rad);
    avg_sin = mean(mean(sin_ans));
    fprintf('mean of all sine values is %f\n',avg_sin);
end

%Q3: Write a function called simple_stats that takes a matrix N as an input and returns the matrix S
%as the output. S has the same number of rows as N. Each element of the first column of S contains
%the mean of the corresponding row of N. Similarly, the second column contains the median values;
%while the third column has the minimums. Finally, each element of the fourth column of S is equal
%to the maximum value of given row of N. (Hint: note that the grader will not test this with column
%vectors, but you should try to solve it for that case too. Remember, help is your friend.)

% function to compute simple statistics: mean, median, min and max in a matrix
function S = simple_stats(N)
    S = [mean(N,2),median(N,2),min(N,[],2),max(N,[],2)];
end

%Q4: Write a function called odd_rms that returns orms, which is the square root of the mean of the
%squares of the first nn positive odd integers, where nn is a positive integer and is the only input
%argument. For example, if nn is 3, your function needs to compute and return the square root of
%the average of the numbers 1, 9, and 25. You may use built-in functions including, for example,
%sum and sqrt, except for the built-in function rms, which is not allowed.

% function to compute root mean square of first nn positive odd integers
function orms = odd_rms(nn)
  orms = sqrt(mean((2*(1:nn) - 1).^2));
  fprintf('rms: %f\n',orms);
end

%Q5: Write a function called fence that takes two scalar inputs: lng, the length of a straight fence we
%need to build and seg, the length of one segment of fencing material. A segment needs to have a
%pole at both ends, but two neighboring segments always share a pole. The function returns two
%scalar outputs: the number of segments we need for the given length of fence and the number of
%poles needed. Note that a segment can be cut shorter if needed. For example, to build a 75m long
%straight fence using 10m segments, we need 8 segments. You may find the ceil built-in function
%handy.

% function to compute root mean square of first nn positive odd integers
function [n_seg,n_poles] = fence(lng,seg)
  n_seg = ceil(lng/seg);
  n_poles = n_seg+1;
  fprintf('number of segments: %f\n',n_seg);
  fprintf('number of poles: %f\n',n_poles);
end

%Q6: Write a function called zero_stat that takes a matrix as an input that only has 0 and 1 elements.
%The function needs to compute and return the percentage of 0 elements in the matrix. For
%example, if there are 10 zeros and 15 ones in a 5-by-5 matrix that is provided as an input to
%zero_stat, it would return 40 because 40% of the elements are zero.

% function to find percentage of zeros in an input matrix containing only 1 and 0
function pct_zero = zero_stat(inp_matrix)
    pct_one=(sum(inp_matrix(:))/numel(inp_matrix))*100;
    pct_zero=100-pct_one;
    fprintf('Percentage of zeros: %f\n',pct_zero);
end

%Q7: Write a function called reverse_diag that creates a square matrix whose elements are 0
%except for 1s on the reverse diagonal from top right to bottom left. The reverse diagonal of an n-
%by-n matrix consists of the elements at the following indexes: (1, n), (2, n-1), (3, n-2), ... (n, 1). The
%function takes one positive integer input argument named n, which is the size of the matrix, and
%returns the matrix itself as an output argument. Note that using the built-in functions eye and
%diag are not allowed. (Hint: you can index into a matrix with a single index and MATLAB will
%handle it as if it was a vector using column-major order. Note that the grader will not test for n = 1,
%but try to solve it for that case too.)

% function to create a matrix of dim n-by-n with all element 0 except for 1 on reverse diagonal
function I = reverse_diag(n)
    I = zeros(n);
    I(n:n-1:end-1) = 1;
end

%Q8: If we list all the natural numbers up to 15 that are multiples of 3 or 5, we get 3, 5, 6, 9, 10, 12 and
%15. The sum of these multiples is 60. Write a function called sum3and5muls that returns the sum
%of all the unique multiples of 3 or 5 up to n where n is a positive integer and the only input
%argument of the function. (Credit: Project Euler)

% function to find the sum of all the unique multiples of 3 or 5 up to 'n'
function sum_mult = sum3and5muls(n)
    sum_mult = sum(3:3:n)+sum(5:5:n)-sum(15:15:n);
    fprintf('Sum of all unique multiples of 3 and 5 till n is: %f\n',sum_mult);
end
    
