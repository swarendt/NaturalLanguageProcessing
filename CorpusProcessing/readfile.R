library(stringr)
library(tm)

setwd("C:/Development/R Projects/Capstone/Dataset")

# con <- file("en_US.blogs.txt", open="r")
con <- file("en_US.twitter.subset.txt", open="r")
res <- readLines(con)
close(con)
length(res)

# loveCount <- sum(str_count(res, "love"))
# hateCount <- sum(str_count(res, "hate"))
# max(str_length(res))

BigramTokenizer <-
    function(x)
        unlist(lapply(ngrams(words(x), 2), paste, collapse = " "), use.names = FALSE)

tdm <- TermDocumentMatrix(res, control = list(tokenize = BigramTokenizer))
inspect(removeSparseTerms(tdm[, 1:10], 0.7))

