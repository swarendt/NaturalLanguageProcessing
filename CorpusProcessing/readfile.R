library(stringr)
library(tm)
# library(tau)

setwd("C:/Development/R Projects/Capstone/Dataset")
setwd("C:/Development/R Projects/Dataset")

con <- file("en_US.twitter.txt", encoding='UTF-8')
# con <- file("en_US.twitter.txt", open='rb')
twitter <- readLines(con)
close(con)
myCorpus <- Corpus(VectorSource(twitter[1:1000]))
rm(twitter)

for(j in seq(myCorpus))   
{   
  myCorpus[[j]] <- gsub("[^0-9A-Za-z///' ]", "", myCorpus[[j]])
  # myCorpus[[j]] <- gsub("[^[:alnum:]///' ]", "", myCorpus[[j]])
} 

myCorpus <- tm_map(myCorpus, PlainTextDocument)
myCorpus <- tm_map(myCorpus, content_transformer(tolower))

# I am not yet sure about how to handle numbers.  Here's why:
# If I include them, there are lots of additional tokens that may not be mostly noise.
# If I remove them and intend to have my solution "learn" from the user, I may be discounting their writing style
# myCorpus <- tm_map(myCorpus, removeNumbers)

myCorpus <- tm_map(myCorpus, removePunctuation)
myCorpus <- tm_map(myCorpus, stripWhitespace)
myCorpus = tm_map(myCorpus, removeWords, stopwords("english"))
# Profanity Filter
myCorpus = tm_map(myCorpus, removeWords, c("shit","fuck","fucker"))

# I have deliberately chosen not to use stemming
# myCorpus = tm_map(myCorpus, stemDocument) 

# loveCount <- sum(str_count(res, "love"))
# hateCount <- sum(str_count(res, "hate"))
# max(str_length(res))

UnigramTokenizer <-
  function(x)
    unlist(lapply(ngrams(words(x), 1), paste, collapse = " "), use.names = FALSE)

BigramTokenizer <-
  function(x)
    unlist(lapply(ngrams(words(x), 2), paste, collapse = " "), use.names = FALSE)

TrigramTokenizer <-
  function(x)
    unlist(lapply(ngrams(words(x), 3), paste, collapse = " "), use.names = FALSE)

unitdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = UnigramTokenizer))
bitdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = BigramTokenizer))
tritdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = TrigramTokenizer))

inspect(tdm[1:100,1:10])

dim(unitdm)
dim(bitdm)
dim(tritdm)

