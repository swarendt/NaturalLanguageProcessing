
# Read in the data here?
submyTrigrams <- readRDS("data/trigrams.rds")
submyBigrams  <- readRDS("data/bigrams.rds")
frequentWords <- readRDS("data/freqwords.rds")


# This function requires the input of a phrase to predict a next word.
# It uses a Second Order Markov Chain for the prediction.  That is, it only relies on the last two
# words in the phrase to suggest a next word. 
# It will handle the input from a single word.
# If it cannot find a suggestion from the vocabulary, it will return "oov", meaning out of vocabulary
# which needs to be handled in the UI.

predictNextWord <- function(inputText) {
  inputText <- str_trim(inputText, side = "both")
  
  inputText <- tolower(inputText)
  
  # This little test checks to see if incoming text is more than one word.  If so, it will 
  # change the input text to the last bigram.  Otherwise, it uses the last unigram.
  if (inputText != word(inputText, -1))
  {
    inputText <- word(inputText, -2, -1)
  }
  
  # Check Trigram data frame for suggestion
  trigrams <- submyTrigrams[submyTrigrams$Bigram==inputText,]
  res <- as.character(trigrams[1,]$NextWord)
  
  # If no trigram suggestion, move on to bigram
  if (is.na(res)) {
    # remove first word
    inputText <- word(inputText,-1)
    
    bigrams <- submyBigrams[submyBigrams$Unigram==inputText,]
    res <- as.character(bigrams[1,]$NextWord)
  }
  
  if (is.na(res)) {
    res <- "oov"
  }
  
  return(res)
}
  