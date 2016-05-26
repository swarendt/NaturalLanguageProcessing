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
      textOutput("abv"),
      
      textOutput("nxtWord"),
      
      conditionalPanel(oovResult > 0, oovResult)
      
    )
  )
))