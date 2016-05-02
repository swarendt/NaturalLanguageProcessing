library(stringr)
library(tm)
library(slam)
# library(tau)

# setwd("C:/Development/R Projects/Capstone/Dataset")
setwd("C:/Development/R Projects/Dataset")

# con <- file("en_US.blogs.txt", encoding='UTF-8')
con <- file("en_US.twitter.txt", encoding='UTF-8')
# con <- file("en_US.news.txt", encoding='UTF-8')
textSource <- readLines(con)
close(con)
myCorpus <- Corpus(VectorSource(textSource[1:1000]))
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
myCorpus = tm_map(myCorpus, removeWords, c("shit","fuck","fucker","ass","asshole"))

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
bitdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = BigramTokenizer))
tritdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = TrigramTokenizer))

# inspect(tdm[1:100,1:10])

dim(unitdm)
dim(bitdm)
dim(tritdm)

unitdmcount <- slam::row_sums(unitdm, na.rm = T)
unitdmMatrix <- as.matrix(unitdmcount)
write.csv(unitdmMatrix, 'blogs100kunigram.csv')

bitdmcount <- slam::row_sums(bitdm, na.rm = T)
bitdmMatrix <- as.matrix(bitdmcount)
write.csv(bitdmMatrix, 'blogs100kbigram.csv')

tritdmcount <- slam::row_sums(tritdm, na.rm = T)
tritdmMatrix <- as.matrix(tritdmcount)
write.csv(tritdmMatrix, 'blogs100ktrigram.csv')


inspect(unitdm)
inspect(bitdm)
inspect(tritdm)
head(unitdmcount)

rm(unitdm)
rm(bitdm)
rm(tritdm)
rm(myCorpus)
rm(unitdmcount)
rm(unitdmMatrix)
