# server.R

library(stringr)
source("helpers.R")


shinyServer(function(input, output) {
  
  output$abv <- renderText({ 
    paste("The ABV is approximately: "
          , format(round(abvValue(input$og, input$fg), 1), nsmall=0)
          ,'%'
        )
  })

  
  output$nxtWord <- renderText({ 
    paste("Predicted Next word: "
          , predictNextWord(input$ti))
  })
  

})