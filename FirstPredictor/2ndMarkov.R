# Scott Arendt
# May 11, 2016

# After playing with Naive Bayes and doing some research, I have decided to choose an algorithm
# that has nothing to do with Machine Learning.  At this point, I have data with unigrams, bigrams
# and trigrams that has been gleaned from a large sample of the text data.

# I have counts associated with each ngram.  Early on, it seemed to me that this information
# was sufficient to provide what I was calling a "brute force" solution.  If I have a bigram 
# provided by the user, and I have trigrams that begin with that bigram, then the trigram that 
# occurred most frequently is the highest probability for the next word.  No model required,
# just access the database for a match and sort by occurrences.

# It turns out that Arendt's Brute Force Predictor goes by another name, Second
# Order Markov Chain.  

library(tau)
library(stringr)

#setwd("C:/Development/R Projects/Capstone/Dataset")
setwd("C:/Development/R Projects/Dataset")

myData = read.csv("TrigramSplitTrain.csv")  # read csv file 
# dim(mydata)
submyTrigrams <- subset.data.frame(myData, FrequencyCount > 3)

myData = read.csv("BigramSplitTrain.csv")  # read csv file 
submyBigrams <- subset.data.frame(myData, FrequencyCount > 3)
rm(myData)

# This function will return the most popular word for a trigram, given an input of a bigram
predictTrigram <- function(inputText) {

  inputText <- tolower(inputText)

  # Check Trigram data frame for suggestion
  trigrams <- submyTrigrams[submyTrigrams$Bigram==inputText,]
  res <- as.character(trigrams[1,]$NextWord)
  
  # If no trigram suggestion, move on to bigram
  if (is.na(res)) {
    # remove first word
    inputText <- word(inputText,-1)
    
    bigrams <- submyBigrams[submyBigrams$Unigram==inputText,]
    res <- as.character(bigrams[1,]$NextWord)
  }

  
 # If no bigram suggestion, move on to unigram
  if (is.na(res)) {
    
    res <- 'OOV'
  }
  
  return(res)
}

inputText <- "small business"

inputText <- "superf Lousy"

inputText <- "Arendt credited"
predictTrigram(inputText)
