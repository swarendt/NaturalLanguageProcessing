library(stringr)
library(tm)
# library(tau)

setwd("C:/Development/R Projects/Capstone/Dataset")
setwd("C:/Development/R Projects/Dataset")

con <- file("twitter1000.txt", open="rb")
twitter <- readLines(con)
close(con)
myCorpus <- Corpus(VectorSource(twitter[1:1000]))
rm(twitter)

myCorpus[523]
inspect(myCorpus[523])

myCorpus <- tm_map(myCorpus, content_transformer(tolower))


for(j in seq(myCorpus))   
{   
  myCorpus[[j]] <- gsub("@", " ", myCorpus[[j]])   
  myCorpus[[j]] <- gsub("\\|", " ", myCorpus[[j]])   
} 

# I have removed the PlainTextDocument transformation.
# The results are weird and I am not even sure what it does.
myCorpus <- tm_map(myCorpus, PlainTextDocument)

# Numbers seem to generate many tokens that can be ignored
# myCorpus <- tm_map(myCorpus, removeNumbers)
myCorpus <- tm_map(myCorpus, removePunctuation)
myCorpus <- tm_map(myCorpus, stripWhitespace)
myCorpus = tm_map(myCorpus, removeWords, stopwords("english"))

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

tdm <- TermDocumentMatrix(myCorpus[523], control = list(tokenize = BigramTokenizer))

inspect(tdm[,])
inspect(tdm[101:200,1:10])
9â???"11am
