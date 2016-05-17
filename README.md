# Natural Language Processing


Scott Arendt  
April 22 2016  
Capstone work

Repository containing all of my code for the JHU Natural Language Processing Project

### Next steps

Create a function that uses a 2nd Order Markov Chain
Determine how to fail to a 1st Order Markov Chain if bigram not found
Determine whether to predict on a unigram (seems that just picking a frequent word isn't that
helpful)
Determine how to handle OOV

Does smoothing apply to OOV?

Do I need to provide some probability calculation with the predicted word?

MIT Lecture on nGrams and models that is helpful in understanding the requirements
http://web.mit.edu/6.863/www/fall2012/lectures/lecture2&3-notes12.pdf

Use week 3 of NLP classs  

### The prediction algorithm

I am still tweaking the algorithm but the basis is this:

Given a bigram, see if we have a trigram that begins with that bigram. If so, then the last word in the trigram is used as our prediction.

If the bigram is not found in our trigram data, then use the last word in the bigram and see if it is in our bigram data.  If so, we have a prediction.

Finally, and this is just random guessing, grab a random popular word from our unigrams.


### Determining a method for prediction

After playing with Naive Bayes and doing some research, I have decided to choose an algorithm
that has nothing to do with Machine Learning.  At this point, I have data with unigrams, bigrams and trigrams that has been gleaned from a large sample of the text data.

I have counts associated with each ngram.  Early on, it seemed to me that this information
was sufficient to provide what I was calling a "brute force" solution.  If I have a bigram 
provided by the user, and I have trigrams that begin with that bigram, then the trigram that 
occurred most frequently is the highest probability for the next word.  No model required,
just access the database for a match and sort by occurrences.

It turns out that Arendt's Brute Force Predictor goes by another name, Second
Order Markov Chain.  It is an implementation of this that I will be using in my predictions.

### Milestone Report

The processing of the raw datasets is now complete.  I convert the raw data into a tdm that contains the data that seems to be what I want.  But what do I do with a tdm.

I have discovered the "slam" function that will sum up counts that I can then write to a text/csv file.

Sampling these massive data sets of text is difficult.  I chose to select arbitrary chunks of the raw data and save the results.  I then read the chunks into SQL Server and merged the data.  It would be stupid for me to spend lots of time figuring out how to do it in R when I quickly got the results in SQL Server.

### Cleaning and Processing Data

Wow, what an overwhelming task.  I have 7-ish weeks to complete this project and it turns out the reference material is a 8 week course on Natural Language Processing.

But even though it is overwhelming it is also interesting.  I have never really thought about the process to predict a next word.  

It also means that I need to dive into new R objects (Corpus, Term Document Matrix) AND new R packages (tm primarily at this point).

Arrghh.  A data science project requires you to be an expert in the subject OR the technology OR statistics.  I am a newbie in all three.  Well, I kind of have the technology down but am unfamiliar with the this package.

Jumping in, I start evaluating the tm package and find that there is a common process to interpreting raw data represent English text.  

tm_map(myCorpus, PlainTextDocument)
tm_map(myCorpus, stripWhitespace)
tm_map(myCorpus, content_transformer(tolower))
tm_map(myCorpus, removeWords, stopwords("english"))
tm_map(myCorpus, stemDocument)

Update on May 17 - I am finding that keeping numbers in my corpus leads to really silly results
in my predictor.  I am now going to remove them.

However, I soon discover that the "standard method" of dealing with text does not apply to our goals.  Stemming and removing the stop words will adversely impact our results.
