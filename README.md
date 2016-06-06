# Natural Language Processing


Scott Arendt  
April 22 2016  
Capstone work

Repository containing all of my code for the JHU Natural Language Processing Project

# Repository Contents

Each directory in this repository contains code related to specific steps in the capstone project.

/CorpusProcessing - This directory has the code for reading in the raw text files, cleaning that data, and finally writing output to csv files.  The output contains the bigrams and trigrams that are resulting from processing the raw text.

/SQLCode - When this directory exists, it will contain the SQL scripts that I used to reduce the data sets to only the most popular results.

/MilestonePredictor - This project was to meet an initial project requirement.  It contains some analysis of the dataset.  This is not really important to the final project.

/FirstPredictor - R files that used to implement and fine tune my prediction algorithm.

/ShinyPredictor - An implementation of my prediction algorithm into a user interface.  This is part 1 of the final project requirements.  The hosted version of the application can be found here: https://scottarendt.shinyapps.io/ShinyPredictor/

/PredictionPresentation - A 5 slide presentation of my algorithm and application.  This is the second part of the final project requirements.  The hosted version of the presentation is located here: http://rpubs.com/sarendt/predictionpresentation

### Conclusions

First, this is a project that could be massive in scope.  There are so many things that I could improve this project.  I think that I have just scratched the surface on it.

Second, this was an interesting project.  I had never thought about what it takes to determine the steps in Natural Language Processing.  It is a subject that, obviuously, people spend a lot of time analyzing and I have become interested in it.

#### What would I do if someone gave me a grant to work on this for the next year?

* Improve my Corpus processing.  Working under limitations of size, I took only the most popular trigrams.  There is no reason it could not be extended to quadragrams or to include multiple suggestions.  
* Spend time on data storage efficiencies and R code best practices.  My Shiny app is fairly responsive but could easily be improved upon.
* Learn more about natural language processing.
* Apply some sort of Part of Speech weighting to my predictions.  While frequencies of nGram occurrence do this to some degree, it is not sufficient in my mind.
* Apply a dictionary to my Corpus processing.  Twitter adds a lot of nonsense words to the dataset that probably should be filtered out.  Those nonsense words may not show up to the user, but take up a lot of room in my dataset.
* A solid evaluation of whether a Markov Chain is the best way to perform the prediction.  It was easy to understand and quick to implement, but there are other options that should be evaluated.
* Much more, these are just quick ideas on improvements.

### After Week 7 - Post assignment documentation - June 2 2016

Document the details of the project.  While I have "a" and "b" and "c" here, I don't have the details of how to get from one step to another.  I also need to get my SQL scripts into the repository.

Document resources at the end of this md

MIT Lecture on nGrams and models that is helpful in understanding the requirements
http://web.mit.edu/6.863/www/fall2012/lectures/lecture2&3-notes12.pdf
Use week 3 of NLP classs  


### Week 7 - Create and publish presentation - May 30 2016

Ah, the final week.

Shiny app is up and published, need to put together the presentation.  How do you cram the results of 7 weeks of work (including a 8 week course as reference material) into 5 slides.

I am thinking:

1) A little background
2) Processing and cleaning the data
3) SQL "Smoothing"
4) Algorithm
5) Something else

### Week 6 - Create and publish Shiny App - May 23 2016

I have a working shiny app and now am able to do some end user testing.  In general, the app works well but I have found some usability issues that can stand some improving.  

For instance, if a space is added to the input text, then immediately the app returns and OOV result.   The OOV is an expected result, because my bigrams and unigrams do not have leading/trailing space. Fortunately, stringr has a trim space function to manage this.

I have to decide how to handle the OOV cases.  Do I have some clever trick up my sleeve?  Do I suggest just the most popular words?  

I also have plenty of time to do UI improvements.  Not my strong suit, but I really want to utilize tabs to add a help file and description.  Maybe an about tab too.

My goal is to have an app loaded to the Shiny host before the week is up.  Giving me a chance to make tweaks if necessary.

### Week 5 - Improving and testing the prediction algorithm - May 16 2016

This week I discovered that including numbers in my term document matrix led to some really strange results for my prediction algorithm.  I went back to my data cleaning and removed numbers.  I had originally thought keeping the numbers would make for a more robust prediction corpus but the result generated some strange sentences.

When I first designed my prediction algorithm, I had it in my head that the input would always be a bigram.  In reality, the input could be a unigram, trigram or larger.  My algorithm was incorrectly failing a trigram down to the unigram prediction and I ended up with sentences that generated an endless loop.  "of the first time of the first time"

I have converted my lookup data into R objects now and should easily be able to upload them within the constraints of the Shiny app server.  I am going to have to remember to include the stringr package in my Shiny app.


### Week 4 - The prediction algorithm - May 9 2016

The word function in the stringr package has been very helpful in implementing my algorithm.

I am still tweaking the algorithm but the basis is this:

Given a bigram, see if we have a trigram that begins with that bigram. If so, then the last word in the trigram is used as our prediction.

If the bigram is not found in our trigram data, then use the last word in the bigram and see if it is in our bigram data.  If so, we have a prediction.

Finally, and this is just random guessing, grab a random popular word from our unigrams.

### Week 3 - Determining a method for prediction - May 2 2016

After playing with Naive Bayes and doing some research, I have decided to choose an algorithm
that has nothing to do with Machine Learning.  At this point, I have data with unigrams, bigrams and trigrams that has been gleaned from a large sample of the text data.

I have counts associated with each ngram.  Early on, it seemed to me that this information
was sufficient to provide what I was calling a "brute force" solution.  If I have a bigram 
provided by the user, and I have trigrams that begin with that bigram, then the trigram that 
occurred most frequently is the highest probability for the next word.  No model required,
just access the database for a match and sort by occurrences.

It turns out that Arendt's Brute Force Predictor goes by another name, Second
Order Markov Chain.  It is an implementation of this that I will be using in my predictions.

### Week 2 - Milestone Report - April 25 2016

The processing of the raw datasets is now complete.  I convert the raw data into a tdm that contains the data that seems to be what I want.  But what do I do with a tdm.

I have discovered the "slam" function that will sum up counts that I can then write to a text/csv file.

Sampling these massive data sets of text is difficult.  I chose to select arbitrary chunks of the raw data and save the results.  I then read the chunks into SQL Server and merged the data.  It would be stupid for me to spend lots of time figuring out how to do it in R when I quickly got the results in SQL Server.

Finally, I also utilized my familiarity with SQL Server, along with its processing power, to end up with a dataset that contains only the most popular response to a bigram (along with a similar SQL script for the unigrams).

The code below generates a common table expression from the data that I imported from the R generated csv file. The csv file is the trigrams from R processing, split into a Bigram (the first two words), a NextWord (the last word of the trigram) and Frequency representing the occurrences of a trigram.  It is based on this frequency that I am producing a top suggestion for a bigram.

; WITH cte AS
  ( SELECT Bigram, NextWord, Frequency,
           ROW_NUMBER() OVER (PARTITION BY Bigram
                              ORDER BY Frequency DESC
                             )
             AS rn
    FROM TrigramSplitTrain
  )

INSERT INTO TrigramSplitTrainTop1
SELECT Bigram, NextWord, Frequency
FROM cte
WHERE rn <= 1
ORDER BY Bigram, NextWord


### Week 1 - Cleaning and Processing Data - April 18 2016

Wow, what an overwhelming task.  I have 7-ish weeks to complete this project and it turns out the reference material is a 8 week course on Natural Language Processing.

But even though it is overwhelming it is also interesting.  I have never really thought about the process to predict a next word.  

It also means that I need to dive into new R objects (Corpus, Term Document Matrix) AND new R packages (tm primarily at this point).

Arrghh.  A data science project requires you to be an expert in the subject OR the technology OR statistics.  I am a newbie in all three.  Well, I kind of have the technology down but am unfamiliar with the this package.

Jumping in, I start evaluating the tm package and find that there is a common process to interpreting raw data represent English text.  

tm_map(myCorpus, PlainTextDocument)
tm_map(myCorpus, stripWhitespace)
tm_map(myCorpus, removeNumbers)
tm_map(myCorpus, content_transformer(tolower))
tm_map(myCorpus, removeWords, stopwords("english"))
tm_map(myCorpus, stemDocument)

Update on May 17 - I am finding that keeping numbers in my corpus leads to really silly results
in my predictor.  I am now going to remove them.

However, I soon discover that the "standard method" of dealing with text does not apply to our goals.  Stemming and removing the stop words will adversely impact our results.


### Resources

Source for the Corpus that is the basis of the project.
https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip

http://www.wordfrequency.info/free.asp?s=y
Contains a list of the most frequently used English words.  Used in my OOV predictions.

MIT Lecture on nGrams and models that is helpful in understanding the requirements
http://web.mit.edu/6.863/www/fall2012/lectures/lecture2&3-notes12.pdf
Use week 3 of NLP classs  
