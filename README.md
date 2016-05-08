# Natural Language Processing


Scott Arendt  
April 22 2016  
Capstone work

Repository containing all of my code for the JHU Natural Language Processing Project

### Next steps

Pick a model
  Naive Bayes

Code up an initial   

MIT Lecture on nGrams and models that is helpful in understanding the requirements
http://web.mit.edu/6.863/www/fall2012/lectures/lecture2&3-notes12.pdf

Use week 3 of NLP classs  


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

However, I soon discover that the "standard method" of dealing with text does not apply to our goals.  Stemming and removing the stop words will adversely impact our results.
