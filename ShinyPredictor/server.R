# server.R

library(stringr)
source("helpers.R")


shinyServer(function(input, output) {
  
  output$nxtWord <- renderText({ 
    paste("Predicted Next word: "
          , predictNextWord(input$ti))
  })
})