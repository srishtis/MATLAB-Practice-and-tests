%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Mathworks Cody: Cody Challenge by Cody team    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%solutions of questions 80-96


%Problem 80. Test for balanced parentheses
function ans = isBalanced(str)  
    cumsum((str == '(') - (str == ')'));  
    ans(end) == 0 & all(ans >= 0);  
end  

%Problem 81. Mandelbrot Numbers
function N = mandelbrot(C,lim)
  M = C;
  N = lim*ones(size(C));
  count = 0;
  while count < lim
    count = count + 1;
    M = M.^2 + C;
    N(N==lim & abs(M)>2) = count;
  end
end


%Problem 82. Remove the small words from a list of words.
function outStr = remove_small_words(inStr)
  outStr = regexprep(inStr,'^ +| +$|(?<= ) +| +(?=\<\w{1,2}\> *$)|\<\w{1,2}\> *','');
end

%Problem 83. Prime factor digits
function p = factor_digits(n)
  P = primes(n);
  f = factor(n);
  u = unique(f);
  N = histc(f,u);
  for i = 1:numel(u)
      I = find( (P-u(i))==0 );
      p(I) = N(i);
  end
  p = fliplr(p)
end

%Problem 84. Longest Divisor Run
function [len,d] = divisor_run(a)
  y=zeros(1,length(a)-1);
  for i=1:length(a)-1
    y(i)=gcd(a(i),a(i+1));
  end
  y(y==1)=[];
  d=mode(y);
  len=sum(y==d)+1;
end

%Problem 85. Remove the polynomials that have positive real elements of their roots.
function in = find_stable(in)
for i = 1 : length(in)
    poly = in{i};
    if length(poly) < 3
        poly = horzcat(poly, [0]);
    end
    if poly(2)^2 < 4 * poly(1) * poly(3)
       L(i) = 0; 
    elseif poly(2)^2 == 4 * poly(1) * poly(3)
        L(i) = -poly(2) / (2 * poly(1)) > 0;
    else
        L(i) = (-poly(2) + sqrt(poly(2)^2 - 4 * poly(1) * poly(3))) / (2 * poly(1)) > 0;
    end    
end
in(find(L)) = [];
end

%%%% Alternative solution:
function ans = find_stable(polyIn)
  str2num '@(polyIn)polyIn(cellfun(@(x)~any(x<0),polyIn))';
  ans(polyIn);
end

%Problem 86. Renaming a field in a structure array
function structOut = renamefield(structIn, oldField, newField) 
for i = 1:size(structIn,2)
    structIn(i).(newField) = structIn(i).(oldField)
end
structOut = rmfield(structIn, oldField)
end

%%%% Alternative Solution:
function structOut = renamefield(structIn, oldField, newField) 
  Data  = struct2cell(structIn);
Field = fieldnames(structIn);
if ischar(oldField)
   Field(strcmp(Field, oldField)) = {newField};
elseif iscellstr(oldField)
   for iField = 1:numel(oldField)
      Field(strcmp(Field, oldField{iField})) = newField(iField);
   end
else
   error(['Error:', mfilename, ':BadInputType'], ...
      'Fields must be a string or cell string!');
end
structOut = cell2struct(Data, Field);
return;
end

%Problem 87. Indexed Probability Table
function p = prob_table(x)
  B = unique(x);
for i = 1:length(B)
    count(i) = sum(x==B(i));
end
 p = zeros(1,max(x));
 for i = 1:length(B)
     p(B(i)) = p(B(i)) + count(i);
 end
 p = p/sum(count);
end

%Problem 88. It dseon't mettar waht oedrr the lrettes in a wrod are.
function ans = scrambleText(sIn)
  regexprep(sIn,'(\w)(\w+)(\w)','$1${fliplr($2)}$3');
end

%Problem 89. Counting in Finnish
function b = finnishOrdering(a)
%  Sort a vector of single digit whole numbers alphabetically by their name, in 
b = [];
order = [8 2 3 6 4 0 7 5 9 1];
for i = order
    ind = a == i;
    b = [b a(ind)];
end
end

%Problem 90. Connect Four Win Checker
function result = c4winner(b)
  m1=ones(1,4);
  m2=diag(m1);
  m3=zeros(4,4);
  m3([4,7,10,13])=1;
  result=0;
  for i=1:2
    d=double(b==i);
    t=(any(any(conv2(d,m1,'valid')==4))|any(any(conv2(d',m1,'valid')==4)));
    if t|(any(any(conv2(d,m2,'valid')==4))|any(any(conv2(d',m3,'valid')==4)))
      result=i;
    end;
  end;
end

%Problem 91. Get the area codes from a list of phone numbers
function a = refcn(s)
   a={};
    s_split = strsplit(s, {'.',';',',',':'});
    s_nos=regexprep(s_split,'[^0-9]','');
    for i=1:numel(s_nos)
        if s_nos{i}(1)=='1'
            y_element= s_nos{i}(2:4);
        else
            y_element= s_nos{i}(1:3);
        end
        a{end+1} = y_element;
    end
    a=unique(a);
end

%Problem 92. Find state names that start with the letter N
function s2 = refcn(s1)
	s2=regexprep(s1, '((\<((New|North) ((Hamp|Jer|Me|Yor|Car|Dak)\w*))?)|Nebraska|Nevada)', '');
end

%%%% Alternative solution:
function ans = refcn(s1)
  regexprep(s1, 'N(orth |ew |)\w*','');
end

%Problem 93. Calculate the Levenshtein distance between two strings
function d = levenshtein(s1,s2)
% use the function defined below
%%you can also use the snippet directly
  d = levdist(s1,s2);
end

function y = levdist(s1, s2)
% Calculates the Levenshtein distance
mtx = (1:length(s1)+1)'*(1:length(s2)+1)-1; 
for n=1:length(s1) 
    for k=1:length(s2) 
        temp = mtx(n,k); 
        if not(s1(n) == s2(k)) 
            temp = min([temp,mtx(n,k+1),mtx(n+1,k)])+1;
        end
        mtx(n+1,k+1) = temp; 
    end
end
y = mtx(end,end); 
end

%Problem 94. Target sorting
function b = targetSort(a,t)
    c(1,:) = abs(a-t);
    [i,j]=sort(c,2,'descend');
    b=a(j)
end

%%%% Alternative solution:
function b = targetSort(a,t)
    a=a'
    N=length(a); diff=zeros(N,1); 
    for kk=1:N
        diff(kk)=(a(kk)-t)^2;
    end
       diff_ord=sort(diff,'descend');
  for ii=1:N
      elem=diff(ii);
      pos= find(diff_ord==elem);
      b(pos)= a(ii);    
  end
end

%Problem 95. Given two strings, find the maximum overlap
function s1 = overlap(s1,s2)
  if s1(end)==s2(1)
    k=2;
    while ~isempty(strfind(s1,s2(1:k)))
       k=k+1; 
    end
    s1 = [s1 s2(end-k:end)];
  elseif s1(1)==s2(end) || isempty(strfind(s1,s2))
    k=2;
    while ~isempty(strfind(s1,s2(end-k:end)))
       k=k+1; 
    end
    s1 = [s2(1:end-k) s1];
  end
end

%%%% Alternative solution:
function ans = overlap(s1,s2)
for i = find(s1)-1
  [s1(1:i) s2]
  if strfind(ans,s1)
    return
  end
end
overlap(s2,s1)
end

%Problem 96. Knight's Tour Checker
function tf = knights_tour(a)
  [~,idx] = sort(a(:));
  nz = 1+sum(a(:)==0);
  [r,c] = ind2sub(size(a),idx);
  dr = abs(diff(r(nz:end)));
  dc = abs(diff(c(nz:end)));
  tf = all((dr==1 & dc==2) | (dr==2 & dc==1));
end
