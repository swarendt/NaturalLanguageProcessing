library(stringr)
library(tm)
library(slam)

setwd("C:/Development/R Projects/Capstone/Dataset")
# setwd("C:/Development/R Projects/Dataset")

# con <- file("en_US.blogs.txt", encoding='UTF-8')
con <- file("en_US.twitter.txt", encoding='UTF-8')
# con <- file("en_US.news.txt", encoding='UTF-8')
textSource <- readLines(con)
close(con)
myCorpus <- Corpus(VectorSource(textSource[1:50000]))
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
#myCorpus = tm_map(myCorpus, removeWords, c("shit","fuck","fucker","ass","asshole"))
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
write.csv(unitdmMatrix, 'twitter50000unigram.csv')
rm(unitdm)
rm(unitdmcount)
rm(unitdmMatrix)


bitdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = BigramTokenizer))
dim(bitdm)
bitdmcount <- slam::row_sums(bitdm, na.rm = T)
bitdmMatrix <- as.matrix(bitdmcount)
write.csv(bitdmMatrix, 'twitter50000bigram.csv')
rm(bitdm)
rm(bitdmcount)
rm(bitdmMatrix)


tritdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = TrigramTokenizer))
dim(tritdm)
tritdmcount <- slam::row_sums(tritdm, na.rm = T)
tritdmMatrix <- as.matrix(tritdmcount)
write.csv(tritdmMatrix, 'twitter50000trigram.csv')
rm(tritdm)
rm(tritdmcount)
rm(tritdmMatrix)

rm(myCorpus)
