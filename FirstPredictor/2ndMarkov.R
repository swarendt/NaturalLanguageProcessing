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

setwd("C:/Development/R Projects/Capstone/Dataset")
#setwd("C:/Development/R Projects/Dataset")

mydata = read.csv("TrigramSplitTrainTop1.csv")  # read csv file 
dim(mydata)
submyData <- subset.data.frame(mydata, PhraseCount > 3)

predictTrigram <- function(queryHistoryTab, inputText, n = 1) {

  trigrams <- 
    sort(textcnt(rep(names(queryHistoryTab), queryHistoryTab), method = "string"
                    , n = length(scan(text = inputText, what = "character", quiet = TRUE)) 
                 + 1))
  return(trigrams)
  
  inputText <- tolower(inputText)
    idx <- which(substr(names(trigrams), 0, nchar(inputText)) == inputText)
    res <- head(names(sort(trigrams[idx], decreasing = TRUE)), n)
    res <- substr(res, nchar(inputText) + 2, nchar(res))
    return(res)
}
predictTrigram(c("Can of beer" = 3, "can of Soda" = 2, "A can of water" = 1
    , "Buy me a can of soda, please" = 2), "Can of")


queryHistoryTab <- c("Can of beer" = 3, "can of Soda" = 2, "A can of water" = 1
                     , "Buy me a can of soda, please" = 2)
inputText <- "Can of"
n <- 1

  
  trigrams <- 
    sort(textcnt(rep(names(queryHistoryTab), queryHistoryTab), method = "string"
                 , n = length(scan(text = inputText, what = "character", quiet = TRUE)) 
                 + 1))
  trigrams
  
  inputText <- tolower(inputText)
  inputText
  
  idx <- which(substr(names(trigrams), 0, nchar(inputText)) == inputText)
  idx
  res <- head(names(sort(trigrams[idx], decreasing = TRUE)), n)
  res
  res <- substr(res, nchar(inputText) + 2, nchar(res))
  res

  