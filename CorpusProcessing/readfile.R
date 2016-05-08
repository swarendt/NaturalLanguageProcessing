library(stringr)
library(tm)
library(slam)

setwd("C:/Development/R Projects/Capstone/Dataset")
# setwd("C:/Development/R Projects/Dataset")

# con <- file("en_US.blogs.txt", encoding='UTF-8')
# con <- file("en_US.twitter.txt", encoding='UTF-8')
con <- file("en_US.news.txt", encoding='UTF-8')
textSource <- readLines(con)
close(con)
myCorpus <- Corpus(VectorSource(textSource[500001:600000]))
rm(textSource)
rm(con)

for(j in seq(myCorpus))   
{   
  myCorpus[[j]] <- gsub("[^[:alnum:]' ]", "", myCorpus[[j]])
} 

myCorpus <- tm_map(myCorpus, PlainTextDocument)
myCorpus <- tm_map(myCorpus, content_transformer(tolower))

# myCorpus <- tm_map(myCorpus, removeNumbers)

myCorpus <- tm_map(myCorpus, stripWhitespace)

# I have decided not to remove stopwords, it alters the results that I want
# myCorpus = tm_map(myCorpus, removeWords, stopwords("english"))

# Profanity Filter
profanity <- readLines("ProfanityFilter.txt")
myCorpus <- tm_map(myCorpus, removeWords, profanity) 
rm(profanity)

# I have deliberately chosen not to use stemming
# myCorpus = tm_map(myCorpus, stemDocument) 

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
dim(unitdm)
unitdmcount <- slam::row_sums(unitdm, na.rm = T)
unitdmMatrix <- as.matrix(unitdmcount)
write.csv(unitdmMatrix, 'newstest2unigram.csv')
#write(unitdmMatrix, 'blogtest1unigram.txt', ncolumns=1, append = FALSE, sep = " ")
rm(unitdm)
rm(unitdmcount)
rm(unitdmMatrix)


bitdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = BigramTokenizer))
dim(bitdm)
bitdmcount <- slam::row_sums(bitdm, na.rm = T)
bitdmMatrix <- as.matrix(bitdmcount)
write.csv(bitdmMatrix, 'newstest2bigram.csv')
#write(unitdmMatrix, 'blogtest1bigram.txt', ncolumns=1, append = FALSE, sep = " ")
rm(bitdm)
rm(bitdmcount)
rm(bitdmMatrix)


tritdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = TrigramTokenizer))
dim(tritdm)
tritdmcount <- slam::row_sums(tritdm, na.rm = T)
tritdmMatrix <- as.matrix(tritdmcount)
write.csv(tritdmMatrix, 'newstest2trigram.csv')
#write(unitdmMatrix, 'blogtest1trigram.txt', ncolumns=1, append = FALSE, sep = " ")
rm(tritdm)
rm(tritdmcount)
rm(tritdmMatrix)

rm(myCorpus)
