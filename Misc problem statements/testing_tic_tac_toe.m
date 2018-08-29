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