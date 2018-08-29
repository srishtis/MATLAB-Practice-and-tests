%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Mathworks Cody: Cody Challenge by Cody Team    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%solutions of questions 40-59

%Problem 40. Reverse Run-Length Encoder
function y = RevCountSeq(x)
y = [];
for i = 1:2:length(x)
    for j = 1:1:x(i)
        y = [y x(i+1)];
    end
end
  disp(y)
end

%%%% Alternative solution:
function y = RevCountSeq(x)
  y = [];
for k = 1:2:length(x)
    y = [y x(k+1)*ones(1, x(k))];
end
end

%Problem 41. Cell joiner
function out_str = cellstr_joiner(in_cell, delim)
  out_str = in_cell{1};  
for k = 2:length(in_cell)  
    out_str = [out_str, delim, in_cell{k}]; 
end

%Problem 42. Find the alphabetic word product
function ans = word_product(s)
p = ones(1,length(s));
for ii=1:length(s)
    p(ii) = find('a':'z'==lower(s(ii)));
end
prod(p);
end

%%%% Alternative Solution:
function p = word_product(s)
  s = upper(s);  
p = 1;  
for k = 1:length(s)  
    p = p*(s(k) - 'A' + 1);
end

%Problem 43. Subset Sum
function ans = subset_sum(x,n)
    dec2bin(1:2^numel(x)-1)=='1';
    strfind(ans(ans*x'==n, :),1);
end

%Problem 44. Trimming Spaces
function b = removeSpaces(a)
  n = find(double(a) ~= 32);
  b = a(min(n):max(n));
end

%Problem 45. Make a Palindrome Number
function b = find_palindrome(a)
  b=str2double(flip(num2str(a)));
  while b-a~=0
    a=b+a;
    b=str2double(flip(num2str(a)));
  end
end

%Problem 46. Which doors are open?
function ans = which_doors_open(n)
x=zeros(1,n);
for ii=1:n
    x(ii:ii:end)=(x(ii:ii:end)==0);
end
find(x)

%%%% Alternate solution:
function y = which_doors_open(n)
  state = zeros(1, n);  
for k = 1:n  
    now = k;  
    while now <= n  
        state(now) = mod(state(now)+1, 2);  
        now = now + k;  
    end  
end
y = find(state == 1); 
end

%Problem 47. Extract leading non-zero digit
function y = leadingDigit(x)
  y = zeros(1, length(x));  
for k = 1:length(x)  
    now = num2str(x(k));  
    now = regexp(now, '[1-9]', 'match');  
    y(k) = str2num(now{1, 1});  
end  
end

%Problem 48. Making change
function b = makingChange(a)
    table = [100 50 20 10 5 2 1 0.5 0.25 0.1 0.05 0.01];  
    b = zeros(1, length(table));  
    for k = 1:length(table)  
        now = floor(a/table(k)+0.0001);  
        b(k) = now; a = a - now*table(k);  
    end
end 

%Problem 49. Sums with Excluded Digits
function total = no_digit_sum(n, m)  
total = 0;  
for k = 1:n  
    digits = num2str(k) - '0';  
    if isempty(find(digits == m, 1))  
        total = total + k;  
    end  
end  

%Problem 50. QWERTY coordinates
function [r,c] = qwerty_coord(key)
    table = zeros(4, 10);  
    table(1,:) = '1234567890';  
    table(2,:) = 'qwertyuiop';  
    table(3,1:9) = 'asdfghjkl';  
    table(4,1:7) = 'zxcvbnm';  
    [r c] = find(table == key);
end

%Problem 51. Find the two most distant points
function ix = mostDistant(p)
  mxdis = 0; ix = [1 2];  
sp = size(p);  
for k = 1:sp(1)  
    for l = (k+1):sp(1)  
        dist = sqrt((p(k,1)-p(l,1))^2+(p(k,2)-p(l,2))^2);  
        if dist > mxdis  
            mxdis = dist;  
            ix(1) = k;  
            ix(2) = l;  
        end  
    end  
end
end

%%%% Alternative Solution:
function ans = mostDistant(p)
  p*[1; i];
  [~, ans] = max(ans-ans.');
  unique(ans);
end

%Problem 52. What is the next step in Conway's Life?
function B = gameOfLife(A)  
  B = A;  
  rmove = [-1 -1 -1 0 1 1 1 0];  
  cmove = [-1 0 1 1 1 0 -1 -1];  
  sa = size(A);  
  for r = 1:sa(1)  
    for c = 1:sa(2)  
      cnt = 0;  
      for k = 1:8  
        g = r + rmove(k); h = c + cmove(k);  
        if g < 1 g = g + sa(1); elseif g > sa(1) g = g - sa(1); end  
        if h < 1 h = h + sa(2); elseif h > sa(2) h = h - sa(2); end  
         cnt = cnt + A(g, h);  
      end  
      if A(r, c) == 1  
        if cnt < 2 || cnt > 3  
          B(r, c) = 0;  
        end  
      else  
        if cnt == 3  
          B(r, c) = 1;  
        end  
      end  
    end  
  end  
end   

%%%% Alternative Solution:
function ans = gameOfLife(A)
    conv2(A([end 1:end 1],[end 1:end 1]),ones(3),'valid');
    ans-A==3|ans==3;
end

%Problem 53. Duplicates
function dugs = duplicates(strs)  
    u = unique(strs);  
    dugs = u(cellfun(@(x) sum(strcmp(x, strs)) > 1, u)); 
end

%Problem 54. Maximum running product for a string of numbers
function i = running_product(s)
  n = length(s)- 4;
  vec = repmat(1:5,n,1)+ repmat((0:n-1)', 1,5);
  [~,i] = max(prod(double(s(vec))-48,2));
end

%Problem 55. Counting Sequence
function y = CountSeq(x)  
    idx = find(diff([x nan]));  
    y = reshape([diff([0 idx]); x(idx)], 1, []);  
end

%Problem 56. Scrabble Scores
function score = scrabble_score(str)
    scrabbleAlphabet = 'abcdefghijklmnopqrstuvwxyz ';
    scrabbleTileValues = [1 3 3 2 1 4 2 4 1 8 5 1 3 1 1 3 10 1 1 1 1 4 4 8 4 10 0];
    strVec = cellstr(char(double(str)'));
    score = sum(cellfun(@(x) scrabbleTileValues(strfind(scrabbleAlphabet, x)), strVec));
end

%Problem 57. Summing Digits within Text
function total = number_sum(str)
  total = 0;  
R = regexp(str, '\d+', 'match');  
for k = 1:length(R)  
    now = str2num(R{k});   
    total = total + now;  
end 
end

%Problem 58. Tic Tac Toe FTW
function ans = ticTacToe(a)
str2num('1 2 3; 1 4 7; 1 5 9; 2 3 1; 2 5 8; 3 1 2; 3 5 7; 3 6 9; 4 5 6; 4 7 1; 5 6 4; 5 7 3; 5 8 2; 5 9 1; 6 9 3; 6 4 5; 7 8 9; 7 1 4; 7 3 5; 8 9 7; 8 2 5; 9 1 5; 9 3 6; 9 7 8')
ans( ismember(a(ans),[0 1 1],'rows'),1)'
    if isempty(ans)
        0
    end
end

%%%% Alternative Solution:
function Out = ticTacToe(a)
Possible=a~=-1;
Current=a==1;
Out=[];
winPat=[1 2 3; 4 5 6; 7 8 9; 1 4 7; 2 5 8; 3 6 9; 1 5 9; 3 5 7]';
for k=winPat
    if all(Possible(k)==true);
        temp=k(xor(Possible(k),Current(k)));
        if numel(temp)==1;
            Out(end+1)=temp;
        end
    end
end
Out=unique(Out);
if isempty(Out)
    Out=0;
end

%Problem 59. Pattern matching
function b = matchPattern(a)
sa = size(a); 
b = [];  
for k = 2:sa(1)  
    flag = 1;  
    for l = 2:sa(2)  
        if ~((a(1,l)>a(1,l-1) && a(k,l)>a(k,l-1)) || (a(1,l)<a(1,l-1) && a(k,l)<a(k,l-1)) || (a(1,l) == a(1,l-1) && a(k,l) == a(k,l-1)))  
            flag = 0;  
        end  
    end  
    if flag  
        b = [b, k];  
    end
end

%%%% Alternative Solution:
function ans = matchPattern(n)
  sign(diff(n, 1, 2));
  setdiff(find(ismember(ans, ans(1, :), 'rows')), 1);
end