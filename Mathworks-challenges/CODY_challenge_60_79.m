%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Mathworks Cody: Cody Challenge by Cody Team    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%solutions of questions 60-79

%Problem 60. The Goldbach Conjecture
function [p1,p2] = goldbach(n)
  p1 = n;  
  p2 = n;  
  for k = 2:n  
    if isprime(k) && isprime(n - k)  
      p1 = k; p2 = n - k;  
      break;  
    end  
  end 
end

%Problem 61. Find state names that end with the letter A
function s2 = refcn(s1)
  s2 = regexprep(s1,'(West Virginia|North Dakota|North Carolina|\w*a+((?=\s)|$))','')
end

%%%% alternative solution:
function ans = refcn(s)
	regexprep(s, '\<((New|North|West) )?\w*a\>', '');
end

%Problem 62. Elapsed Time
function elapsed = elapsed_time(d1,d2)
 elapsed = etime(datevec(d2),datevec(d1))/3600
end

%Problem 63. Encode Roman Numerals
function romStr = dec2rom(n)
roman = {'M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I'};
num = {1000 900 500 400 100 90 50 40 10 9 5 4 1};
romStr = [];
for k = 1:length(num)
    while (n >= num{k})
        romStr = [romStr roman{k}];
        n = n - num{k};
    end
end

%Problem 64. The Goldbach Conjecture, Part 2
function c = goldbach2(n)
hn = floor(n/2+0.1); c = 0;
for k = 2:hn
    if isprime(k) && isprime(n - k)
        c = c + 1;
    end
end

%Problem 65. Word Counting and Indexing
function [table idx] = word_index(list)
	a = cellfun(@(x) regexp(x, ' ', 'split'), list, 'UniformOutput', false);
	table = unique([a{:}]);
	idx = cellfun(@(x) arrayfun(@(y) find(strcmp(y, table)), x), a, 'UniformOutput', false);
end

%Problem 66. Find the two-word state names
function s2 = refcn(s1)
  regexp '' '(?@s2=strjoin(regexp(s1,"New Hampshire|New Jersey|New York|New Mexico|North Carolina|North Dakota|Rhode Island|South Carolina|South Dakota|West Virginia","split"),""))'
end

%%%% alternative solution:
function s2 = refcn(s1)
    s2 = regexprep(s1,...
         '(North|South|New|West|Rhode) (\w*)', '');
end

%Problem 67. Find common elements in matrix rows
function y = common_by_row(x)
sx = size(x); y = [];
for k = 1:sx(2)
    now = x(1,k);
    flag = 1;
    for l = 2:sx(1)
        if isempty(find(x(l,:) == now, 1))
            flag = 0;
        end
    end
    if ~isempty(find(y == now, 1))
        flag = 0;
    end
    if flag
        y = [y now];
    end
end
y = sort(y);

%%%% alternative solution:
function ae = common_by_row(a)
n=1;
ae=[];
for k=unique(a)'
if sum((k==a),2)
    ae(n)=k;
    n=n+1;
end
end
end

%Problem 68. Kaprekar Steps
function y = KaprekarSteps(x)
  step = 0; now = x;
while now ~= 0 && now ~= 6174
    now = num2str(now);
    first = sort(now, 'ascend');
    second = sort(now, 'descend');
    if length(now) < 4
        first = [zeros(1, 4-length(now))+'0', first];
        second = [second, zeros(1, 4-length(now))+'0'];
    end
    % first, second
    now = abs(str2num(first) - str2num(second));
    step = step + 1;
end
if now == 0
    y = Inf;
else
    y = step;
end
end

%%%% alternative solution:
function ans = KaprekarSteps(x)
6174/x-1;
if ans && isfinite(ans)
    sort(sprintf('%04d', x));
     1 + KaprekarSteps(str2num(fliplr(ans)) - str2num(ans));
end
end


%Problem 69. Find the peak 3n+1 sequence value
function pmax = peakOfPeaks(nmax)
  pmax = nmax;
for k = 1:nmax
    now = k;
    while now ~= 1
        if mod(now, 2) == 0
            now = now/2;
        else
            now = 3*now + 1;
        end
        pmax = max(pmax, now);
    end
end
end

%Problem 70. Alphabetize by last name
function alpha_list = alphabetize(list)
  sl = size(list);
tmp = cell(length(list), 2);
for k = 1:length(list)
    now = list{k};
    tmp{k, 1} = now;
    now = regexp(now, '\w*$', 'match');
    tmp{k, 2} = now{1};
end
tmp = sortrows(tmp, 2);
alpha_list = cell(1, length(list));
for k = 1:length(list)
    alpha_list{k} = tmp{k, 1};
end
if sl(1) ~= 1
    alpha_list = alpha_list';
end
end

%%%% alternative solution
function ans = alphabetize(list)
  [~,i] = sort(regexprep(list,'\w+.* ',''));
  list(i)
end

%Problem 71. Read a column of numbers and interpolate missing data
function ans = read_and_interp(s)  
    s = str2num(char(s(2:end)));  
    id = (s(:,2) ~= 9999);  
    interp1(s(id,1), s(id,2), s(:,1))';  
end

%Problem 72. Interpolator
function ans = interpolator(va, a, b)  
    interp1(a, b, va, 'linear');  
end

%Problem 73. Replace NaNs with the number that appears to its left in the row.
function y = replace_nans(x)
  NotNaNs = ~isnan(x)           % positions of non-NaN elements  
  indices = cumsum(NotNaNs)     % indexing based on non-NaN positions
  % filter for non-NaN elements and put a zero into the first position
  NotNaNList = [0 x(NotNaNs)]   
  y = NotNaNList(indices + 1)
end

%Problem 74. Balanced number
function tf = isBalanced(n)
    x = num2str(n);
    tf = sum(double(x(1:floor(end/2)))) == sum(double(x((ceil(end/2+1):end))));
end

%%%% Alternative solution:
function ans = isBalanced(n)
      n = num2str(n); 
      hf = floor(length(n)/2);  
      sum(n(1:hf)) == sum(n(end-hf+1:end))
end

%Problem 75. Find the palindrome
function b = pal(a)
ispal = @(x) all(x==fliplr(x));
for i = 1:length(a)
    for j = 1:(length(a)-i)
        if ispal(a(j:(j+i)))
            b = a(j:(j+i));
        end
    end
end
end

%Problem 76. De-dupe
function b = dedupe(a)
  b=unique(a, 'stable');  
end

%Problem 77. Clean the List of Names
function ans = clean_list(in)  
    [~, ans] = unique(upper(in), 'stable');  
    in(ans);  
end 

%Problem 78. Implement a ROT13 cipher
function  s = rot13(s) 
      id = (s >= 'a' & s <= 'z');  
    s(id) = char(mod(s(id) - 'a' + 13, 26) + 'a');  
    id = (s >= 'A' & s <= 'Z');  
    s(id) = char(mod(s(id) - 'A' + 13, 26) + 'A');  
end

%Problem 79. DNA N-Gram Distribution
function s = nGramFrequency(s, n)  
    s = arrayfun(@(x) s(x:x+n-1), 1:length(s)-n+1, 'UniformOutput', false);  
    u = unique(s);  
    cellfun(@(x) sum(strcmp(x, s)), u, 'UniformOutput', false);  
    [~, id] = max([ans{:}]);  
    s = u{id};  
end  
