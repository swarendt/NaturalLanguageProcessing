ShinyPredictor - A language prediction application!
========================================================
author: Scott Arendt
date: May 31, 2016
autosize: true
transition: fade


Building a Vocabulary
========================================================
The first step in this project is to reduce the Corpus of text down to a series of nGrams.  A nGram is a word phrase of length "n".  I limited my processing to unigrams, bigrams and trigrams for this project.

Additionally, a significant amount of cleaning was required.  I removed punctuation (other than apostrophes), numbers, whitespace and profanity.  I made use of the tm library functions to perform most of these tasks.  The cleaning steps are shown in the code snippet below.


```r
# Remove punctuation, keeping apostrophes
for(j in seq(myCorpus))   
{   
  myCorpus[[j]] <- gsub("[^[:alnum:]' ]", "", myCorpus[[j]])
} 
myCorpus <- tm_map(myCorpus, content_transformer(tolower))
myCorpus <- tm_map(myCorpus, removeNumbers)
myCorpus <- tm_map(myCorpus, stripWhitespace)
# Profanity Filter
profanity <- readLines("ProfanityFilter.txt")
myCorpus <- tm_map(myCorpus, removeWords, profanity) 
```


Markov Chain
========================================================
Andrey Markov discovered that you could predict some event, based on the events that occurred just prior to it.  Applying this to text prediction, the general concept is that the probability of predicting word w, is based on the words that precede it.  The probability is given as thus: 
$P = \left(w_{n} | w_{1}, w_{2}, ..., w_{n-1}\right)$

Even better, the words immediately preceding have more effect than words with a larger distance.  We can determine the most likely word simply by finding the most frequently occurring trigram in our dataset.  By reducing our inputs to the trigram, the probability calculation becomes $P = \left(w | u, v\right)$.

There are going to be instances when a trigram (u, v, w) is not found in our dataset.  In that case, I am using a backoff method for my prediction.  We reduce our search again, this time to a bigram (v, w) and check for matches. Finally, if I have no matches at all, I suggest a word from one of the 25 most popular words in the English language.

The beauty of this method is in its simplicity.  The combination of using Markov's Chain along with the backoff methods for handling exceptions, provide an excellent prediction algorithm that handles all possible inputs.


Algorithm Used for Prediction
========================================================

The algorithm that I used in my prediction is based on Markov's discoveries, specifically this is known as a Second Order Markov Chain.


```r
  # Check for trigram match (u, v, w)
  trigrams <- submyTrigrams[submyTrigrams$Bigram==inputText,]
  res <- as.character(trigrams[1,]$NextWord)
  
  # If no trigram match, "backoff" to the bigram (v, w)
  if (is.na(res)) {
    # remove first word
    inputText <- word(inputText,-1)
    bigrams <- submyBigrams[submyBigrams$Unigram==inputText,]
    res <- as.character(bigrams[1,]$NextWord)
  }
  # If no bigram match, "backoff" to a common English word
  if (is.na(res)) {
    oovResult <<- sample(1:25, 1)
    res <- as.character(frequentWords[oovResult,2])
  } 
  # Return w as the prediction
  return(res)
```

Results
========================================================

I am excited to report that I could use my data science skills to produce this application for you, my stakeholders.  

The application can be accessed by clicking here: <https://scottarendt.shinyapps.io/ShinyPredictor/>

Using the application is straightforward.  Simply enter a word or phrase into the text box and the application will suggest the next word in your phrase.  This suggestion will appear in red near the bottom of the screen.  

Please try it out and let me know what you think about its potential use in future development for our department.




My Github repository has a complete description of my work on this project.  Click here to check it out!  <https://github.com/swarendt/NaturalLanguageProcessing>
