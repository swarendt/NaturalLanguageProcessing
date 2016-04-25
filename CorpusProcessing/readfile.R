library(stringr)
library(tm)

setwd("C:/Development/R Projects/Capstone/Dataset")

# con <- file("en_US.blogs.txt", open="r")
#con <- file("twitter1000.txt", open="r")
#twitter <- readLines(con)
#close(con)
#myCorpus <- Corpus(VectorSource(twitter))

# multiple text files
res <- textfile("*1000.txt", cache = FALSE)
summary(corpus(res), 5)

myCorpus <- tm_map(myCorpus, content_transformer(tolower))
myCorpus <- tm_map(myCorpus, PlainTextDocument)
myCorpus <- tm_map(myCorpus, removePunctuation)
# myCorpus = tm_map(myCorpus, removeWords, stopwords("english"))
# myCorpus = tm_map(myCorpus, stemDocument) 

# loveCount <- sum(str_count(res, "love"))
# hateCount <- sum(str_count(res, "hate"))
# max(str_length(res))

BigramTokenizer <-
    function(x)
        unlist(lapply(ngrams(words(x), 2), paste, collapse = " "), use.names = FALSE)

tdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = BigramTokenizer))
inspect(removeSparseTerms(tdm[, 1:10], 0.7))
inspect(tdm)

