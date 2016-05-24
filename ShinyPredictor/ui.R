library(shiny)

shinyUI(fluidPage(
  titlePanel("wordPrognosticator"),
  
  sidebarLayout(
    sidebarPanel(
      
    
      br(),
      
      sliderInput("og",
                  "Original Gravity:",
                  min = 1.03,
                  max = 1.13,
                  value = 1.08,
                  round=-3,
                  step = 0.005
                  ),
      
      br(),
    
      sliderInput("fg",
                  "Final Gravity:",
                  min = 1.00,
                  max = 1.055,
                  value = 1.03,
                  round=-3,
                  step = 0.005
                  ),
      
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