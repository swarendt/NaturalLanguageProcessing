library(dplyr)
library(caret)
library(e1071)
library(klaR)

# Scott Arendt
# May 8 2016
# Using Naive Bayes to do predictions

setwd("C:/Development/R Projects/Capstone/Dataset")
#setwd("C:/Development/R Projects/Dataset")


mydata = read.csv("BigramSplitTrain.csv")  # read csv file 
dim(mydata)
submyData <- subset.data.frame(mydata, PhraseCount > 3)

# e1071 naiveBayes
set.seed(3456)
fit1 <- naiveBayes(submyData$NextWord, submyData$Unigram)

# klaR NaiveBayes
set.seed(3456)
fit2 <- NaiveBayes(submyData$NextWord, submyData$Unigram, usekernal = FALSE, fL = 0)

# A sample here - avoids machine learning
# Here we are going to only use our database
# Kind of makes sense here
# Use compressed data rdata
f <- function(queryHistoryTab, query, n = 2) {
  require(tau)
  trigrams <- sort(textcnt(rep(tolower(names(queryHistoryTab)), queryHistoryTab), method = "string", n = length(scan(text = query, what = "character", quiet = TRUE)) + 1))
  query <- tolower(query)
  idx <- which(substr(names(trigrams), 0, nchar(query)) == query)
  res <- head(names(sort(trigrams[idx], decreasing = TRUE)), n)
  res <- substr(res, nchar(query) + 2, nchar(res))
  return(res)
}
