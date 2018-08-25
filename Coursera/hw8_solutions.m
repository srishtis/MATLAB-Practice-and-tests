digit_counter('huge_add.m');
a=day_counter( 1988)
circular_primes( 8226 );

%function: digit_counter in a file; takes file name as argument
function dc = digit_counter(filename)
    dc=-1;
    fid= fopen(filename,'r');
    if fid>=0
        dc= nnz(isstrprop(fileread(filename),'digit'));
        fclose(fid);
    end
end

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