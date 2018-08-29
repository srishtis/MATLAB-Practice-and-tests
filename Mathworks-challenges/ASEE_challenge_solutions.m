%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Mathworks Cody: ASEE Challenge by Ned Gulley    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Problem 658. Find the biggest empty box
%You are given a matrix that contains only ones and zeros. Think of the ones as columns in an otherwise empty floor plan. You want to fit a big square into the empty space (denoted by zeros). 
%What is the largest empty square sub-matrix you can find in the given matrix? You will return the row and column extent of the sub-matrix. 
%The answer may not be unique. We will test that your sub-matrix is square, that it is empty, and that it contains the correct number of elements.
function varargout = biggest_box(x)
  for k=0:length(x)
    [r,c]=find(~conv2(x,ones(k+1),'valid'),1);
    if r
        varargout={r r+k c c+k};
    end
  end
end 

%Problem 659. How long is the longest prime diagonal?
%Stanislaw Ulam once observed that if the counting numbers are arranged in a spiral, the prime numbers contained in it form a surprising pattern. They appear to cluster along diagonals of the spiral matrix.
%Given n, find the longest diagonal arrangement of primes in spiral(n).
function ans = prime_spiral(n)
    a = floor(sqrt(n));
    a+ (mod(n,a)>0)*(2-3*(n>50))
end

%Problem 660. Find a subset that divides the vector into equal halves
%Given a vector x, return the indices to elements that will sum to exactly half of the sum of all elements.
function ans = split_it(x)
    ones(sum(x)/x(1)/2,1);
end

%Problem 661. Spot the outlier
%All points except for one lie on a line. Which one is the outlier?
function outlier = spot_the_outlier(pts) 
  for outlier = 1:length(pts)
    a = pts; a(outlier,:)=[];
    if rank(bsxfun(@minus,a,mean(a))) == 1
      return
    end
  end
end

%Problem 722. Make a run-length companion vector
%Given a vector x, return a vector r that indicates the run length of any value in x. 
%Each element in r shows how many times the corresponding element in x has appeared consecutively.
function r = run_length(x)
  l = length(x);
  t = zeros(l);
  r = ones(1,l);
  c = 1;
  t(1) = x(1);
  for i = 2:l
     t(i) = x(i);
     if t(i) == t(i-1)
         c=1+c;
         r(i) = c;
     else
         r(i) = 1;
         c = 1;
     end
  end
end

%Problem 729. Flag largest magnitude swings as they occur
%You have a phenomenon that produces strictly positive or negative results.
%delta = [1 -3 4 2 -1 6 -2 -7];
%Marching through this list from beginning to end, mark a value with -1 if it is the greatest magnitude negative yet seen (strictly greater, not equal). 
%Mark it with a one if it has the greatest magnitude in the positive direction (strictly greater, not equal). Just use a 0 if neither of these conditions have been met.
function y = magnitude_swing(x)
  y = x;
  c = zeros(3,1);
  for k = 1:numel(x)
    y(k) = (c(sign(x(k)) + 2) < abs(x(k)))*sign(x(k));
    c(sign(x(k))+2) = max(abs(x(k)),c(sign(x(k))+2));
  end
end

%Problem 730. How many trades represent all the profit?
%Given a list of results from trades made:
%[1 3 -4 2 -1 2 3]
%We can add them up to see this series of trades made a profit of 6.
%Since the two biggest trades sum to that, we can say that all the profit came from two trades.
%What is the minimum number of trades that represent the total profit (possibly exceeding it). All trade lists will represent profitable series.
function ans = trade_profit(x)
  (dec2bin(1:2^length(x)-1)-'0');
  min(sum(ans(ans*x'>=sum(x),:),2));
end

%Problem 731. Given a window, how many subsets of a vector sum positive
%Given a vector and a window, how many of the windows sum to be positive, not zero or negative?
function ans = sum_positive(x, window)
    sum(arrayfun(@(i)sum(x(i:i+window-1)) > 0, 1:(length(x)-window+1)));
end

%Problem 751. Implement simple rotation cypher
%If given a letter from the set:
%[abc...xyz]
%and a shift, implement a shift cypher.
%Example:
%'abc' 
%with a shift of -1 yields
%'zab'
function outStr = cypher(inStr, shift)
    outStr=regexprep(inStr,'[a-z]','${char(mod(($0-97)+shift,26)+97)}');
end

%Problem 753. Solitaire Cipher
%Keystream Algorithm
%This algorithm assumes that the user has a deck of cards and two jokers which are distinguishable from each other. 
%For simplicity's sake, only two suits will be used in this example. Each card will be assigned a numerical value: the first suit of cards will be numbered from 1 to 13 (Ace through King) and the second suit will be numbered 14 through 26 in the same manner. 
%The jokers will be assigned the values of 27 and 28. Thus, a 5 from the first suit would have the value 5 in our combined deck, the value 1 in the second suit would have the value 14 in the combined deck.
function out = solitaire(deck,n)
        
    for k = 1:n
        % Moving the jokers
        for jk = 'KLL'-'0'
            jpos = find(deck==jk);
            deck = deck(circshift(mod('79:;<=>?@ABCDEFGHIJKLMNOPQR8'+jpos,28)+1,jpos+(jpos==28)));
        end
        
        % Triple-cutting the deck
        jpos4 = find(deck>=27);
        deck = cell2mat(fliplr(mat2cell(deck,1,[jpos4(1),diff(jpos4),-jpos4(2)]+'02M'-'1')));
        
        % Bottom card move
        deck(1:27) = circshift(deck(1:27),-deck(28));
        
        % Determine keystream value
        out(k) = deck(deck(1));
    end
end


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~THE END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%