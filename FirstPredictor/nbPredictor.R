library(dplyr)

# Scott Arendt
# May 8 2016
# Using Naive Bayes to do predictions

setwd("C:/Development/R Projects/Capstone/Dataset")
# setwd("C:/Development/R Projects/Dataset")


mydata = read.csv("BigramSplitTrain.csv")  # read csv file 
dim(mydata)

filter(mydata, NextWord == "water")
mydata[1,]
mydata[NextWord == "water",]

subset.data.frame(mydata, Frequency > 1)
louiedata <- subset.data.frame(mydata, Unigram == "louie" & PhraseCount > 1)
louiedata
