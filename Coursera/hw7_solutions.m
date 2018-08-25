integerize([2,5,8;3.5,4,7e5]);

out_put = year2016( 10 );

palin_product(3, 23530);

out=dial('1 (FUN) DOG-4-YOU #2')

%logiunpack([1,2]);

logipack([0 1;1 0]);

centuries(1397);

find_zero (@cos, 1.4707963267949, 1.5708963267949);

%Q1: Write a function called integerize that takes as its input a matrix A of integers of type
%double, and returns the name of the “smallest” signed integer class to which A can be
%converted without loss of information. If no such class exists, the text 'NONE' is returned. For
%example, if the smallest element of A is -100 and the largest is +100, then the function would
%return 'int8'. As another example, if there is an element of A equal to -1e20, then the
%function would return 'NONE'.

% function to find signed integer class of input double numbers
function name = integerize(A)
    if A==int8(A)
       name='int8';
    elseif A==int16(A)
       name='int16';
    elseif A==int32(A)
       name='int32';
    elseif A==int64(A)
       name='int64';
    else
       name='NONE';
    end
end

%Q2: Write a function called year2016 that returns a row-vector of struct-s whose elements
%correspond to the days of a month in 2016 as specified by the input argument. If the input is
%not an integer between 1 and 12, the function returns the empty array. Each struct should
%contain three fields with these (exact) field names: “month”, “date”, and “day” (all lower case).
%• The month field must contain a string with the name of the month (first letter capitalized).
%• The date field must contain a scalar specifying the day of the month.
%• The day field must contain the three-letter abbreviation of the day chosen from this list:
%'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'.
%For example, here is a call of the function followed by a command that shows the seventh
%element of the struct array that is returned by the function:
%>> m = year2016(2);
%>> m(7)
%ans =
%month: 'February'
%date: 7
%day: 'Sun'

%year2016 function
function out = year2016( m )
%YEAR2016 
    if ~isscalar(m) || m <1 || m~=fix(m)
        out = [];
    else
    VN = datenum([2016,m,1]):datenum([2016,m+1,1])-1;
    DN = 1+mod(VN-3,7);
    MC = {'January';'February';'March';'April';'May';'June';'July';'August';'September';'October';'November';'December'};
    DC = {'Mon','Tue','Wed','Thu','Fri','Sat','Sun'};
    out = struct('day',DC(DN),'date',num2cell(1:numel(VN)));
    [out(:).month] = deal(MC{m});
    end
end

%Q3: A palindromic number reads the same both ways. The largest palindrome made from the
%product of two 2-digit numbers is 9009 = 91 × 99. Write a function that is called this way:
%>> n = palin_product(dig,lim);
%The function returns the largest palindrome smaller than lim that is the product of two dig
%digit numbers. If no such number exists, the function returns 0. (Inspired by Project Euler.)

%function for numerical palindromes
function n = palin_product(dig, lim)
    n = 0;
    for ii = 10^dig-1 : -1 : 10^(dig-1)                             % going from large to small
        for jj = min(10^dig-1,floor((lim-1)/ii)) : -1 : 10^(dig-1)  % check numbers under lim
            p = ii*jj;
            if p < n                % gone under the current max
                continue;           % no need to go further in the inner loop
            elseif palindrome(p)
                n = p;              % found a larger one
                continue;           % no need to go further in the inner loop
            end
        end
    end
end

function isp = palindrome(p)
    txt = num2str(p);
    isp = strcmp(txt,txt(end:-1:1));
end

%Q4: Each number on telephone keypads, except 0 and 1, corresponds to a set of uppercase letters
%as shown in this list:
%2 ABC, 3 DEF, 4 GHI, 5 JKL, 6 MNO, 7 PQRS, 8 TUV, 9 WXYZ
%Hence, a phone-number specification can include uppercase letters and digits. Write a function
%called dial that takes as its input argument a char vector of length 16 or less that includes
%only these characters and returns as its output argument the telephone number as a uint64.
%Here is the input and output for one example of a call of the function:
%Input:
%'1FUNDOG4YOU'
%Output:
%13863644968
%You can assume that a phone number never starts with 0. If the input contains any illegal
%characters, the function returns 0. You are not allowed to use the built-in function strrep.

%function to convert a string into corresponding phone number
function out = dial(inp)
    dig = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    vec = '012345678922233344455566677778889999';
    if sum(~ismember(inp,dig))>0
          out = uint64(0);
          return;
    else
        [~,idb] = ismember(inp,dig);
        out = sscanf(vec(idb),'%lu');
    end
end

%Q5: An n-by-n square logical matrix can be represented by a cell vector of n elements where the k th
%element corresponds to the k th row of the matrix. Each element of the cell vector is a row
%vector of positive integers in increasing order representing the column indexes of the logical
%true values in the given row of the matrix. All other elements in the given row of the logical
%matrix are false. Write a function called logiunpack that takes such a cell vector as its
%only input and returns the corresponding square logical matrix. For example, such a cell vector
%representation of a 100-by-100 logical matrix with the only true elements at indexes (10,20)
%and (10,75) would have only one non-empty element of the cell vector at index 10. That
%element is the vector [20 75].

%function that takes such a cell vector as its only input and returns the corresponding square logical matrix.
function L = logiunpack(cv)
    n = length(cv);
    L = false(n);
    for ii = 1:n
        for jj = 1:length(cv{ii})
            L(ii,cv{ii}(jj)) = true;
        end
    end
end

%Q6: Solve the inverse of the previous problem. That is, write a function called logipack that takes
%a square logical matrix as its only input argument and returns its cell vector representation as
%specified in the previous assignment. Note that empty array elements of the cell vector
%corresponding to rows with all false values must have a size of 0x0.

% function that takes a square logical matrix as its only input argument and returns its cell vector representation as specified in the previous assignment
function cv = logipack(L)
    [r,c] = size(L);
    cv = cell(1,r);
    for ii = 1:r
        cv{ii} = find(L(ii,:));
        if isempty(cv{ii})      % find can return 1x0 empty arrays
            cv{ii} = [];        % so we make sure it is 0x0
        end
    end
end

%Q7: Write a function called centuries that takes a positive integer smaller than or equal to 3000
%representing a year as its input and returns a char vector with the century the given year falls
%into. If the input is invalid, the function returns the empty char vector '' (there is no space
%between the apostrophes). Centuries are specified using roman numerals. Note that we require
%the shortest legal roman number. For a complete list, refer to:
%http://www.romannumerals.co/roman-numerals-1-to-30. Note that a century goes from year 1
%to 100, so for example, the XX th century ended on December 31 st , 2000. As an example, the call
%>> cent = centuries(1864);
%will make cent equal to ‘XIX’.

%function that takes a positive integer smaller than or equal to 3000 representing a year as its input and returns a char vector with the century the given year falls into.
function c = centuries(n)
    if ~isscalar(n) || n < 1 || n > 3000 || n ~= floor(n)
        c = '';
    else
        cents = {'I'; 'II'; 'III'; 'IV'; 'V'; 'VI'; 'VII'; 'VIII'; 'IX'; 'X';
              'XI'; 'XII'; 'XIII'; 'XIV'; 'XV'; 'XVI'; 'XVII'; 'XVIII'; 'XIX'; 'XX';
              'XXI'; 'XXII'; 'XXIII'; 'XXIV'; 'XXV'; 'XXVI'; 'XXVII'; 'XXVIII'; 'XXIX'; 'XXX'};
        c = cents{ceil(n/100)};
    end
end

%Q8: Write the function find_zero that is defined like this function x = find_zero(f,x1,x2). The first input argument is special. It is a “function
%handle”. A function handle is gotten by typing @ and the name of any function. For example,
%x = find_zero(@sin,-1,1) will give f the function handle for MATLAB’s built-in sin function. 
%Then, inside find_zero, the statement y = f(-1) would set y = sin(-1) . Note that the @ sign 
%is not used inside the function. Only the caller uses it. All other arguments to find_zero
%are scalar numbers, and x1 is less than x2. The goal of the function is to find an x that lies 
%in the range from x1 to x2 such that after the command, y = f(x), is executed inside the function find_zero, 
%y is approximately zero as defined by abs(y) < 1e-10. All you know about the function f is that it has one 
%scalar input and one scalar output, and a plot of its values crosses the x-axis exactly once between x1 and x2, as, 
%for example, in the figure. It is the responsibility of the caller to call the function with arguments that obey these rules.

%function to find zeros for a given function caller
function x = find_zero (f, x1,x2)    
    x = (x1+x2)/2.0;              % find interval midpoint
    while abs(f(x)) > 1e-10       % are we there yet? 
        if f(x1)*f(x)>0           % if f(left) and f(mid) have the same sign
            x1 = x;               % move left to mid
        else 
            x2 = x;               % move right to mid
        end
        x = (x1+x2)/2.0;          % recalculate midpoint
    end
end
