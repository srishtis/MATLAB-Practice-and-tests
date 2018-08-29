%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Mathworks Cody: Cody Challenge by Cody Team    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%solutions of questions 20-39

%Problem 20. Summing digits
unction b = sumDigits(n)
  s = 2^n
  t = num2str(s)-'0'
  b = sum(t);
end

%Problem 21. Return the 3n+1 sequence for n
function c = collatz(n)
  c(1) = n;
while n ~= 1
    if mod(n, 2) == 0
        n =  n/2;
    else
        n = 3*n + 1;
    end
    c = [c n];
end

%Problem 22. Remove the vowels
function s2 = refcn(s1)
  s2=s1(~ismember(lower(s1), 'aeiou'));
end

%Problem 23. Finding Perfect Squares
function b = isItSquared(a)
b = false;
for k = 1:length(a)
    now = a(k)^2;
    if ~isempty(find(a == now, 1))
        b = true;
    end
end

%Problem 24. Function Iterator
function fh2 = iterate_fcn(fh, n)
fh2 = fh;
for k = 1:n-1
  fh2 = @(x)fh(fh2(x));
end

%Problem 25. Remove any row in which a NaN appears
function B = remove_nan_rows(A)
  sa = size(A); B = [];
for k = 1:sa(1)
    label = isnan(A(k,:));
    if isempty(find(label == 1, 1))
        B = [B; A(k,:)];
    end
end

%Problem 26. Determine if input is odd
function tf = is_it_odd(n)
  tf = false;
  if mod(n,2)==1
      tf = true;
  end
end

%Problem 27. Pangrams!
function tf = isPangram(s)
  cnt = zeros(1, 26); 
  %convert to lower case
  s = lower(s);
for k = 1:length(s)
    if s(k) >= 'a' && s(k) <= 'z'
        cnt(s(k)-'a'+1) = 1;
    end
end
tf = isempty(find(cnt == 0) == 0);
end

%Problem 28. Counting Money
function b = moneySum(a)
    regexprep(a, '[$,]', '');
    b = sum(cellfun(@(x) str2num(x), ans));
end

%Problem 29. Nearest Numbers
function [index1 index2] = nearestNumbers(A)
c=abs(A'-A);
s=size(c,1);
c(1:s+1:numel(c))=NaN;
e=min(c);
n=find(ismember(e,min(e)));
index1=n(1)
index2=n(2)
end

%Problem 30. Sort a list of complex numbers based on far they are from the origin.
function zSorted = complexSort(z)
  x=abs(z);
  [sx,i]=sort(x);
  zSorted = z(flip(i));
end

%Problem 31. Remove all the words that end with "ain"
function s2 = remAin(s1)
  s2 = [];
s1 = regexp(s1, '\w*ain\>', 'split');
for k = 1:length(s1)
    s2 = [s2 s1{k}];
end
end

%Problem 32. Most nonzero elements in row
function r = fullest_row(a)
  [ro,c,v] = find(a);
    r = mode(ro);
end

%%%% Alternative solution:
function r = fullest_row(a)
  r=sum(a(1:end,:)~=0,2);
  [~,r] = max(r);
end

%Problem 33. Create times-tables
function m = timestables(n) 
    for i = 1:n
        m(i,:) = i*(1:n)
    end
end

%Problem 34. Binary numbers
function ans = binary_numbers(n)
    double(dec2bin(0:((2^n)-1),n))-48
end

%Problem 35. Quote Doubler
function s2 = quote_doubler(s1)
A = find(s1 == '''')
for i = 1:1:length(A)
        s1 = [s1(1:A(i)+i-1),'''',s1(A(i)+i:end)];
end
  s2 = s1
end

%Problem 36. Find relatively common elements in matrix rows
function y = common_by_row(x)
y =[];
nn = unique(x(~isnan(x)));
for ii=1:length(unique(x(~isnan(x))))
    if sum(any(x==nn(ii),2))/size(x,1)>0.5
       y = [y nn(ii)];
    end
end

%Problem 37. Pascal's Triangle
function ans = pascalTri(n)
chol(pascal(n+1))';
ans(n+1,1:n+1);
end

%%%% Alternative solution:
function y = pascalTri(n)
y = zeros(1, n+1);
for k = 0:n
    y(k+1) = nchoosek(n, k);
end
end

%Problem 38. Return a list sorted by number of occurrences
function y = popularity(x)
    a=unique(x);
  [b n]=sort(histc(x,unique(x)),'descend');
  y=a(n);
end

%Problem 39. Which values occur exactly three times?
function y = threeTimes(x)
C = unique(x);
co = hist(x,C);
j=1;
for i = 1:length(co)
    if co(i)==3
        y(j)=C(i);
        j=j+1;
    end
end
end

%%%% Alternative solution:
function ans = threeTimes(x)
    y=unique(x);
    [f, ~] = hist(x,y);
    sort(y(f==3));
end

