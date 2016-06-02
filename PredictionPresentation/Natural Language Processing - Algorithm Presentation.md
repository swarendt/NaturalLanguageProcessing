ShinyPredictor - A language prediction application!
========================================================
author: Scott Arendt
date: May 31, 2016
autosize: true
transition: fade


Building a Vocabulary
========================================================

<font size="14">
Unigrams, Bigrams and Trigrams
</font>

Markov Chain
========================================================

<font size="14">
Andrey Markov discovered that you could predict some event, based on the events that occurred just prior to it.  Applying this to text prediction, the general concept is that the probability of predicting word w, is based on the words that precede it.  The probability is given as thus: 
$P = \left(w_{n} | w_{1}, w_{2}, ..., w_{n-1}\right)$


Even better, the words immediately preceding have more effect than words with a larger distance.  We can determine the most likely word simply by finding the most frequently occurring trigram in our dataset.  By reducing our inputs to the trigram, the probability calculation becomes $P = \left(w | u, v\right)$.


There are going to be instances when a trigram (u, v, w) is not found in our dataset.  In that case, I am using a backoff method for my prediction.  We reduce our search again, this time to a bigram (v, w) and check for matches.


Finally, if I have no matches at all, I suggest a word from one of the 25 most popular words in the English language.


The beauty of this method is in its simplicity.  The combination of using Markov's Chain along with the backoff methods for handling exceptions, provide an excellent prediction algorithm that handles all possible inputs.
</font>

Algorithm Used for Prediction
========================================================

The algorithm that I used in my prediction is based on Markov's discoveries, specifically this is known as a Second Order Markov Chain.


```r
predictNextWord <- function(inputText) {
  # Remove spaces and change to lower case to match dataset
  inputText <- str_trim(inputText, side = "both")
  inputText <- tolower(inputText)
  
  # The input can be any length.  This will extract the last two words (u, v) of the input.
  if (inputText != word(inputText, -1))
  { 
    inputText <- word(inputText, -2, -1) 
  }
  
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
}
```

Results
========================================================

I am excited to report that I could use my data science skills to produce this application for you, my stakeholders.  

My Github repository has a complete description of my work on this project.  Click here to check it out!  <https://github.com/swarendt/NaturalLanguageProcessing>
