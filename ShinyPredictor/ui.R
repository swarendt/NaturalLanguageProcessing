library(shiny)

shinyUI(fluidPage(
  titlePanel("Natural Language Processing"),

    
  sidebarLayout(
    sidebarPanel(
      
      
      tags$b("Cell phones are a common use of predictions in language processing."),
      br(),
      tags$b("This application provides an implementation of an algorithm for making text predictions."),
      
      
      
      helpText("Note: There may be a short delay as the dataset is loaded",
               "the specified number of observations, the",
               "summary will be based on the full dataset."),
      
      br(),
      
      br(),
      
      textInput("ti", "Enter your text here:", ""),

      width=12
    ),
    
    mainPanel
    (
      br(),
  
      textOutput("nxtWord")
    )
    
  )
))