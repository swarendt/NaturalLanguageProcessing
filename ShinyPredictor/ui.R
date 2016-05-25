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
      
      conditionalPanel("input.ibu < 21", img(src='Emoticon1.jpg', align = "center"))
      
    )
  )
))