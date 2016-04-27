library(stringr)
library(tm)
# library(tau)

setwd("C:/Development/R Projects/Capstone/Dataset")
setwd("C:/Development/R Projects/Dataset")

# con <- file("en_US.blogs.txt", open="r")
con <- file("en_US.twitter.txt", open="rb")
twitter <- readLines(con)
close(con)
myCorpus <- Corpus(VectorSource(twitter[1:1000]))

con <- file("twitter100000.txt", open="rb")
twitter <- readLines(con)
close(con)
# myCorpus <- Corpus(VectorSource(twitter))
myCorpus <- Corpus(VectorSource(twitter[1:100000]))

myCorpus <- tm_map(myCorpus, content_transformer(tolower))

# I have removed the PlainTextDocument transformation.
# The results are different and I am not even sure what it does.
# myCorpus <- tm_map(myCorpus, PlainTextDocument)

myCorpus <- tm_map(myCorpus, removeNumbers)
myCorpus <- tm_map(myCorpus, removePunctuation)
myCorpus <- tm_map(myCorpus, stripWhitespace)
myCorpus = tm_map(myCorpus, removeWords, stopwords("english"))

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

tdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = TrigramTokenizer))

inspect(tdm[1:100,1:10])

