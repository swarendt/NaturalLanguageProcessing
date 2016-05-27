library(shiny)

shinyUI(fluidPage(
  titlePanel("wordPrognosticator"),
  
  sidebarLayout(
    sidebarPanel(
      
    
      br(),
      
      br(),
      
      textInput("ti", "Enter your text here:", "")
    ),
    
    mainPanel
    (
  
      textOutput("nxtWord"),
            
      conditionalPanel(oovResult > 0, "Not in the vocabulary")
      
    )
  )
))