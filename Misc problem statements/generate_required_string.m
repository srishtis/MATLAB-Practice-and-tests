%Problem 1043. Generate a string like abbcccddddeeeee
%Generate a string like abbcccddddeeeee

%So if n = 3, then return

% 'abbccc'
%And if n = 5, then return

% 'abbcccddddeeeee'


function y = your_fcn_name(n)
  array='a':'z'
  y=[]
  for i=1:n
      arr=[]
      for a=1:i
          append=array(i)
          arr=[arr append]
      end
      y=[y arr]
  end
end

