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

% function to create a 2n by 2m matrix with specifications of specific integers at required positions
function Q= intquad (n,m)
    a = zeros(n,m); 
    b = ones(n,m); 
    c = b*2; 
    d = b*3; 
    Q = [a b ; c d];
end

% function to compute sin of input in deg without using sind or cosd
function [sin_ans,avg_sin]= sindeg (deg)
    rad= deg.*(pi/180);
    sin_ans = sin(rad);
    avg_sin = mean(mean(sin_ans));
    fprintf('mean of all sine values is %f\n',avg_sin);
end

% function to compute simple statistics: mean, median, min and max in a matrix
function S = simple_stats(N)
    S = [mean(N,2),median(N,2),min(N,[],2),max(N,[],2)];
end

% function to compute root mean square of first nn positive odd integers
function orms = odd_rms(nn)
  orms = sqrt(mean((2*(1:nn) - 1).^2));
  fprintf('rms: %f\n',orms);
end

% function to compute root mean square of first nn positive odd integers
function [n_seg,n_poles] = fence(lng,seg)
  n_seg = ceil(lng/seg);
  n_poles = n_seg+1;
  fprintf('number of segments: %f\n',n_seg);
  fprintf('number of poles: %f\n',n_poles);
end

% function to find percentage of zeros in an input matrix containing only 1 and 0
function pct_zero = zero_stat(inp_matrix)
    pct_one=(sum(inp_matrix(:))/numel(inp_matrix))*100;
    pct_zero=100-pct_one;
    fprintf('Percentage of zeros: %f\n',pct_zero);
end

% function to create a matrix of dim n-by-n with all element 0 except for 1 on reverse diagonal
function I = reverse_diag(n)
    I = zeros(n);
    I(n:n-1:end-1) = 1;
end

% function to find the sum of all the unique multiples of 3 or 5 up to 'n'
function sum_mult = sum3and5muls(n)
    sum_mult = sum(3:3:n)+sum(5:5:n)-sum(15:15:n);
    fprintf('Sum of all unique multiples of 3 and 5 till n is: %f\n',sum_mult);
end
    
