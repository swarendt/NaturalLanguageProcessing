library(caret)

setwd("C:/Development/R Projects/Capstone/Dataset")
# setwd("C:/Development/R Projects/Dataset")

# con <- file("en_US.blogs.txt", encoding='UTF-8')
con <- file("en_US.twitter.txt", encoding='UTF-8')
# con <- file("en_US.news.txt", encoding='UTF-8')

textSource <- readLines(con)
close(con)

set.seed(3456)
trainIndex <- createDataPartition(textSource[1:500000], p = .5, list = FALSE, times = 1)

rawTrain <- textSource[ trainIndex,]
rawTemp  <- textSource[-trainIndex,]

testIndex <- createDataPartition(rawTemp, p = .5, list = FALSE, times = 1)

rawTest <- rawTemp[ textIndex,]
rawValidate  <- rawTemp[-textIndex,]

rm(textSource)
rm(con)

con <- file("TwitterTrain.txt", encoding = 'UTF-8')
write(rawTrain, con, ncolumns = 1, append = FALSE, sep = " ")
rm(rawTrain)
rm(con)

con <- file("TwitterTest.txt", encoding = 'UTF-8')
write(rawTest, con, ncolumns = 1, append = FALSE, sep = " ")
rm(rawTest)
rm(con)

con <- file("TwitterValidate.txt", encoding = 'UTF-8')
write(rawValidate, con, ncolumns = 1, append = FALSE, sep = " ")
rm(rawValidate)
rm(con)
