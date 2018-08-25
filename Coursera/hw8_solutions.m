digit_counter('huge_add.m');
a=day_counter( 1988)
circular_primes( 8226 );

%Q1: Write a function called digit_counter that takes the name of a text file as input and returns the
%number of digits (i.e., any of the characters, 0-to-9) that the file contains. If there is a problem opening the
%file, the function returns -1. WARNING: if you use the ‘w’ flag with fopen, as opposed to ‘r’, you will
%overwrite the file. The grader uses your own m files to check your function, so be careful!

%function: digit_counter in a file; takes file name as argument
function dc = digit_counter(filename)
    dc=-1;
    fid= fopen(filename,'r');
    if fid>=0
        dc= nnz(isstrprop(fileread(filename),'digit'));
        fclose(fid);
    end
end

%Q2: Write a function called day_counter that returns the number of Mondays that fell on the first day of the
%month in a given year between 1776 and 2016 inclusive where the requested year is the only input to your
%function and it is a positive integer scalar. Note that a leap year occurs on any year evenly divisible by 4, but
%not on a century unless it is divisible by 400. In a leap year, February has 29 days. You are not allowed to use
%the datenum built-in function. (Inspired by Project Euler.)

% function to count number of mondays
function foms = day_counter( year )
    % DAY_COUNTER returns the number of Mondays that fell on the first day of the
    % month in a given year between 1776 and 2016
    % year is from 1776 to 2016 inclusive; a positive integer scalar
    % test for valid input
   if ~isscalar(year) || year < 1776 || year > 2016 || year ~= floor(year)
       fprintf('Invalid input. Enter an integer between 1776 and 2016 inclusive')
       return
   end
   foms=sum(weekday(datetime(year,1:12,1))==2);
end

%Q3: Write function called huge_add that adds together two positive integers of any length specified as char
%vectors using decimal notation. The single output argument is the result and it is a char vector as well. The
%inputs and output must contain digits only; no commas, spaces or any other characters are allowed. If any of
%these assumptions are violated by the input, the function returns the number -1. Hint: you cannot use any of
%the built-in numerical data types of MATLAB to do the calculation since the function needs to work for
%numbers that are larger than what can be represented as a number in MATLAB.

%problem huge add
function summa = huge_add(a,b)
    if ~ischar(a) || ~ischar(b) || sum(isstrprop(a,'digit')) ~= length(a) || ...
            sum(isstrprop(b,'digit')) ~= length(b)
        summa = -1;
        return;
    end
    lng = max([length(a) length(b)]);
    a = [a(end:-1:1) '0'+zeros(1,lng-length(a))];   % flip and pad with zeros if necessary
    b = [b(end:-1:1) '0'+zeros(1,lng-length(b))];   % flip and pad with zeros if necessary
    carry = 0;
    for ii = 1:lng
        c = carry + str2num(a(ii)) + str2num(b(ii)) % add the digits plus the caryy
        carry = c > 9;                              % is there carry? (0 or 1)
        summa(ii) = num2str(mod(c,10));             % put the character in the result
    end
    if carry
        summa(end+1) = '1';                         % need a leading 1 if carry
    end
    summa = summa(end:-1:1);                        % flip it back
end

%Q4: 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any
%remainder. Write a function called smallest_multiple that returns a uint64, the smallest positive
%number that is evenly divisible by all of the numbers from 1 to n where n is a positive integer scalar and is
%the only input argument of the function. If the result would be greater than what can be represented as a
%uint64, the function returns 0. (Inspired by Project Euler.)

%problem smallest multiple
function mul = smallest_multiple(n)
    facts = zeros(1,n);             % store the exponents of various factors
    for ii = 2:n
        f = factor(ii);             % get factors for current integer
        for jj = 2:ii
            k = sum(f == jj);       % what's the exponent of this factor?
            if k > facts(jj)        % if it is greater than what we have so far
                facts(jj) = k;      % update to this new value
            end
        end
    end
    % Compute the result with one command. 
    % The 'native' option tells MATLAB to work in uint64
    mul = prod(uint64((1:n).^facts),'native');   
    if mul == intmax('uint64')
       mul = uint64(0);
    end
end

%%alternative solution to smallest multiple
function r = smallest_multiple(k) 
    r = uint64(1);
    for n = 1:k
        r = r * (n / gcd(r,n));   % Include factor not already present in r
    end
    if r == intmax('uint64')
       r = uint64(0);
    end
end

%Q5: Write a function called maxproduct that takes a matrix A and a positive integer scalar n as inputs and
%computes the largest product of n adjacent elements in the same direction in A. That is, we are looking for
%products of consecutive elements in the same row, column, diagonal or reverse diagonal. The function must
%return an n-by-2 matrix containing the row and column indexes ordered first by row and then by column. If
%no such product exists, the function returns the empty array. For example, valid outputs for a max product
%of 3 neighbors in four different matrices might be [2 2; 2 3; 2 4] or [1 1; 2 1; 3 1] or [3 5; 4 4; 5 3] or [4 2; 5 3;
%6 4]. If there are multiple products with the same maximum value, return the first one you find. (Inspired by
%Project Euler.)

%problem max product
function B = maxproduct(A,n)

% After checking that we do not have to return an empty array, we initialize a row vector
% for remembering a product, home row and column, and one of four direction codes.
% Home is a location in the matrix from which we can move in one of the directions
% (1=East, 2=South, 3=SouthEast, 4=SouthWest). For each direction, home is systematically 
% moved to everywhere it legally can be the start of n values. For each location, we 
% potentially update the L vector with the largest product so far, the home location and
% direction that corresponded to that product. After scanning in all four directions, we 
% use L to reconstruct the required indices based on the last updated home and direction. 

  [r,c] = size(A);
  if n>r && n>c
    B = [];                                    % cannot be solved
    return
  end

  L = [-Inf,0,0,0];                            % [product, home-row, home-col, direction]
      
  for i=1:r                            
    for j=1:c-n+1
      L = check(A(i,j:j+n-1),[i,j,1],L);       % row, right case
    end
  end 
  for i=1:r-n+1                        
    for j=1:c
      L = check(A(i:i+n-1,j),[i,j,2],L);       % column, down case
    end
  end
  for i=1:r-n+1
    for j=1:c-n+1
      S=A(i:i+n-1,j:j+n-1);
      L = check(diag(S),[i,j,3],L);            % diagonal, down case
      L = check(diag(flip(S,2)),[i,j,4],L);    % reverse diagonal, down case
    end
  end
  
  i=L(2); j=L(3);                              % reconstruct coordinates
  switch L(4)                                  
    case 1, B = [ones(n,1)*i,(j:j+n-1)'];      
    case 2, B = [(i:i+n-1)',ones(n,1)*j];
    case 3, B = [(i:i+n-1)',(j:j+n-1)'];
    case 4, B = [(i:i+n-1)',(j+n-1:-1:j)'];
  end
end

function L = check(V,d,L)
  p = prod(V);
  if p>L(1)                                    % if new product larger than any previous
    L = [p,d];                                 % then update product, home and direction 
  end  
end

%Q6: If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4
%= 19 letters used in total. Write a function called number2letters that returns the number of letters
%needed to write down the number n in words. For example, 342 (three hundred forty two) contains 20
%letters. Notice that we do not count spaces, nor do we use hyphens. The only input to the function is n, a
%positive integer smaller than 1000, but you do not need to check this. (Inspired by Project Euler.)

%problem number to letters
function m = number2letters (n)

% A is a 3x10 array of the letter counts of the words used to form various numbers, with
% units in row 1, "teens" in row 2 and tens in row 3. For the supplied number, we first
% determine the number of units, tens and hundreds. These three values determine the
% words and thus the letter count to be returned.
 
  A = [ 0 3 3 5 4 4 3 5 5 4; ...              % units
        3 6 6 8 8 7 7 9 8 8; ...              % "teens"
        0 0 6 6 5 5 5 7 6 6];                 % tens
  h = fix(n/100); 
  t = fix(rem(n,100)/10); 
  u = rem(n,10);
  if h>0,     m = A(1,h+1)+7;                % h 'hundred'
  else        m = 0; 
  end
  switch t
    case 0,   m = m+A(1,u+1);                % units only
    case 1,   m = m+A(2,u+1);                % "teens" only
    otherwise m = m+A(3,t+1)+A(1,u+1);       % tens and units
  end 
end

%alternative solutio: This can be generalized to all numbers
% function for number2letters: count number of letters to write a number name in words
function out_letter = number2letters(num_input) 
   in_words = num2words(num_input);
   treated_hyphen = strrep(in_words,"-","");
   treated_spaces = strrep(treated_hyphen," ","");
   out_letter = strlength(treated_spaces);
end 

function words = num2words(number)    
    %% integer part
    int_number = floor(number);
    words = int2words(int_number);
    %% digits after the decimal point
    if int_number ~= number
        %% base words
        namesDigits = {'zero', 'one', 'two', 'three', 'four', 'five', ...
                       'six', 'seven', 'eight', 'nine'};
        words = [words, ' point'];
        %% version 1: does not work due to numerical issues
        %while int_number ~= number
        %    number = (number-int_number) * 10;
        %    int_number = floor(number);
        %    words = [words, ' ', namesDigits{int_number+1}]; %#ok<AGROW>
        %end
        %% version 2: based on sprintf
        numStr = sprintf('%.18g', number);
        pointPos = find(numStr == '.');
        numStr = numStr(pointPos+1:end);
        for cIdx = 1:length(numStr)
            int_number = str2num(numStr(cIdx)); %#ok<ST2NM>
            words = [words, ' ', namesDigits{int_number+1}]; %#ok<AGROW>
        end
    end
end

%% 
% This function is implemented according to the modern British short scale
% standard dictionary numbers, cf.
%   http://en.wikipedia.org/wiki/English_numerals
%   http://en.wikipedia.org/wiki/Names_of_large_numbers
function words = int2words(number)
    %% base words
    minus     = 'minus';
    names0    = 'zero';
    names1000 = {'', ' thousand', ' million', ' billion', ' trillion', ...
                 ' quadrillion', ' quintillion', ' sextillion', ...
                 ' septillion', ' octillion', ' nonillion', ...
                 ' decillion', ' undecillion', ' duodecillion', ...
                 ' tredecillion', ' quattuordecillion', ...
                 ' quindecillion', ' sexdecillion', ' septendecillion', ...
                 ' ocotdecillion', ' novemdecillion', ' vigintillion'};

    %% sign    
    if number < 0
        isNegative = true;
        number = -number;
    elseif number == 0
        words = names0;
        return;
    else
        isNegative = false;
    end
    words = '';

    %% checks
    %maxCorrectNumber = 10^18...
    %maxDoableNumber = 10^63...

    %% convert
    cnt = 1;
    while number ~= 0
        num1000 = mod(number,1000);
        number = floor(number / 1000);
        if num1000 > 0
            if ~isempty(words)
                words = [',' words]; %#ok<AGROW>
            end        
            words = [' ' int2words_1to999(num1000), names1000{cnt}, words]; %#ok<AGROW>
        end
        cnt = cnt + 1;
        % check:
        if cnt == length(names1000) + 1
            error('The given number is too large for converting it into words');
        end
    end

    %% add sign
    if isNegative
        words = [minus, words];
    end

    %% trim <- can be removed by more clever whitespace handling inbetween?
    words = strtrim(words);
end

%% numbers between 1 and 999
function words = int2words_1to999(number)
    %% base words
    names1  = {'', 'one', 'two', 'three', 'four', 'five', 'six', ...
               'seven', 'eight', 'nine', 'ten', 'eleven', ...
               'twelve', 'thirteen', 'fourteen', 'fifteen', ...
               'sixteen', 'seventeen', 'eighteen', 'nineteen'};
    names10 = {'', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', ...
               'seventy', 'eighty', 'ninety'};
    %% convert
    num100 = mod(number, 100);
    if num100 < 20
        words = names1{num100+1};
        number = (number - num100) / 100;
    else
        num10 = mod(number, 10);
        words = names1{num10+1};
        if ~isempty(words)
            words = ['-' words];
        end
        number = (number - num10) / 10;
        num10 = mod(number, 10);
        words = [names10{num10} words];
        number = (number - num10) / 10;
    end
    if number > 0
        if ~isempty(words)
            words = [' ', words];
        end
        words = [names1{number+1}, ' hundred', words];
    end
end

%Q7: Write a function called circular_primes that finds the number of circular prime numbers smaller
%than n, where n is a positive integer scalar input argument. For example, the number, 197, is a circular
%prime because all rotations of its digits: 197, 971, and 719, are themselves prime. For instance, there are
%thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97. It is important to emphasize
%that rotation means circular permutation not all possible permutations.

%circular primes function
function [ ncp ] = circular_primes( n )
%CIRCULAR_PRIMES Summary of this function goes herebn
%   How many circular primes are there less than a number n?

% n positive integer
% ncp number of circular primes less than n

ncp=0;
circularprimes=[];

% find all primes less than n
prime=primes(n-1);

np=length(prime);

% for each prime, find out if it is circular
for i=1:np
    % find all the digits in the prime
    n=prime(i);
    %fprintf('Prime: %d  ',n);
    for j=1:ndigits(prime(i))
        d(j)=mod(n,10);
        n=floor(n/10);
        %fprintf('d%d:%d, ',j,d(j));
    end
    
    % compile all circular permutations of the prime
    %fprintf('\n');
    flag=true;
    for k=1:length(d)
        %result=shift(d,1);
        result=circshift(d,[1,1]);
        d=result;
        number=0;
        for kk=1:length(d)
            number=number+10^(kk-1) * d(kk);
        end
        number;
        
        % for each permutation, is it prime?
        if ~isprime(number)
            flag=false;
        end
    end
    % if all permutations are prime, the prime is circular
    if flag==true
        ncp=ncp+1;
        circularprimes=[circularprimes,prime(i)];
    end
    
end
circularprimes;
end


function result=shift(nelements, k)      
% function to shift elements of an array forward in a circular way by k elements 
% redundant - does same as MATLAB function circshift

    len = size(nelements,2);
    result = zeros(1,len);
    start = mod((len - k),len);
    for i =1:len
        index=mod(start + i+1 , len)+1;
        result(i)=nelements(index);
     end
end


function nd= ndigits(A)
% find how many digits are in a number
    nd=floor(log10(abs(A)+1)) + 1;
end

%Q8: Write a function that is called like this [E,N] = cyclotron(V). All arguments are scalars. The input argument 
%is the voltage applied to a cyclotron (figure), which is a device that accelerates subatomic
%particles—in this case, positively charged isotopes of hydrogen, called “deuterons”—which spiral outward in a
%clockwise direction. The cyclotron rapidly alternates the sign of the voltage difference V in units of volts between
%two “D”-shaped vacuum chambers (blue outlines), which are placed within a strong uniform magnetic field (not shown 
%but perpendicular to the page). The deuteron is accelerated only as it is leaving one “D” and entering the
%other. While the deuteron is inside a given “D”, it moves at a constant speed, and the magnetic field causes it to move
%on a semicircle. Each deuteron moves as follows (check the numbers in the figure): (1) It originates from a source (red
%dot) located at a distance ss 0 to the left of the center of the cyclotron, is accelerated vertically into the upper “D” 
%and then moves on a semi-circle of radius r 1 . (2) It leaves the upper “D” and is accelerated vertically downward into the
%lower “D” where moves with a larger radius r 2 . (3) It leaves the lower “D” and is accelerated vertically into the upper
%“D”, etc, moving with ever increasing radii rr nn until (N) it is accelerated for the final time as it leaves the
%upper “D” and enters the lower “D”, follows a semicircle of radius r N , and emerges from the cyclotron at the
%left. The formulas for the radii is given.

%problem cyclotron
function [E,n] = cyclotron (V)
    m = 3.344e-27;           % mass of deuteron [kg]             
    q = 1.603e-19;           % charge of deuteron [c]
    B = 1.600;               % magnetic field strength [t]
    z = m*V/(q*B^2);         % initial trajectory radius squared [m^2]
    n = 0;                   % pass number
    d = 2;                   % diameter/radius, sign alternates
    r = sqrt(z);             % initial radius of curvature 
    x = -r/2.0;              % initial x-coordinate

    while x>=-0.5            % while deuteron has not emerged 
        x = x+d*r;           % spiral to next x-coordinate ;
        n = n+1;             % update pass number
        d = -d;              % ... and direction
        r = sqrt(r^2+2*z);   % calculate new radius in case needed
    end
    E = V*n*1e-6;            % determine energy  
end

