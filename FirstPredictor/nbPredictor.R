library(dplyr)
library(klaR)

# Scott Arendt
# May 8 2016
# Using Naive Bayes to do predictions

# setwd("C:/Development/R Projects/Capstone/Dataset")
setwd("C:/Development/R Projects/Dataset")


mydata = read.csv("BigramSplitTrain.csv")  # read csv file 
dim(mydata)

filter(mydata, NextWord == "water")
mydata[1,]
mydata[NextWord == "water",]

submyData <- subset.data.frame(mydata, Frequency > 3)
fit <- NaiveBayes(NextWord ~ ., data = submyData)
