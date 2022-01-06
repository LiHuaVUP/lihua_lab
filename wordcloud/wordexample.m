%% wordcloud - table
load sonnetsTable
head(tbl)
figure
wordcloud(tbl,'Word','Count');
title("Sonnets Word Cloud")

%% wordcloud - txt
sonnets = string(fileread('sonnets.txt'));
punctuationCharacters = ["." "?" "!" "," ";" ":"];
sonnets = replace(sonnets,punctuationCharacters," ");
words = split(join(sonnets));
words(strlength(words)<5) = [];
words = lower(words);

C = categorical(words);
figure
wordcloud(C);
title("Sonnets Word Cloud")

%% MJ Thriller HIStory 
thriller={'wannabestartinsomethin','babybemine','thegirlismine',...
    'thriller','beatit','billiejean','humannature','pyt','theladyinmylife'};
    
history={'scream','theydontcareaboutus','strangerinmoscow','thistimearound',...
'earthsong','ds','money','youarenotalone','childhood','tabloidjunkie','toobad','history',...
'littlesussie','smile'};

text_thriller=[];

for i=1:length(thriller);
    file_here=[thriller{i} '.txt'];
    text_here=string(fileread(file_here));
    text_thriller=strcat(text_thriller,text_here);
end

text_history=[];

for i=1:length(history);
    file_here=[history{i} '.txt'];
    text_here=string(fileread(file_here));
    text_history=strcat(text_history,text_here);
end

punctuationCharacters = ["." "?" "!" "," ";" ":" ")" "(" "-" "'"];
text_here = replace(text_thriller,punctuationCharacters," ");
words = split(join(text_here));
words(strlength(words)<5) = [];
words = lower(words);
c = categorical(words);
figure('pos',[10 10 1500 1000]);
ax1=subplot(1,2,1);
wordcloud(c);
title("Thriller")

punctuationCharacters = ["." "?" "!" "," ";" ":" ")" "(" "-" "'"];
text_here = replace(text_history,punctuationCharacters," ");
words = split(join(text_here));
words(strlength(words)<5) = [];
words = lower(words);
c = categorical(words);
figure('pos',[10 10 1500 1000]);
wordcloud(c);
title("HIStory")