% This function removes words that have length shorter than thresh_len (in this snippet: 3)
%It also removes extra spaces

function words_new = remove_small_words(words)
    temp1 = strsplit(words, ' ');
    words_new='';
    for i = 1:numel(temp1)
        k = temp1{i};
        a=length(k);
        thresh_len= 3;
        if a<thresh_len
            k='';
            wht_space= ' ';
            words_new = [words_new,wht_space,k];
        else
            wht_space= ' ';
            words_new = [words_new,wht_space,k];
        end
    end
    words_new= strtrim(words_new);
    words_new= regexprep(words_new,' +',' ');
end

%%Example:
% For::
%words = 'ours is  not to   reason why';
%words_new = remove_small_words(words);

% output: words_new= 'ours not reason why'
