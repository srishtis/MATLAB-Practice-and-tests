integerize([2,5,8;3.5,4,7e5]);

out_put = year2016( 10 );

palin_product(3, 23530);

out=dial('1 (FUN) DOG-4-YOU #2')

%logiunpack([1,2]);

logipack([0 1;1 0]);

centuries(1397);

find_zero (@cos, 1.4707963267949, 1.5708963267949);

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

%function that takes such a cell vector as its only input and returns the corresponding square logical matrix.
%function L = logiunpack(cv)
%    n = length(cv);
%    L = false(n);
%    for ii = 1:n
%        for jj = 1:length(cv{ii})
%            L(ii,cv{ii}(jj)) = true;
%        end
%    end
%end

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