library(shiny)

shinyUI(fluidPage(
  titlePanel("aleChecker"),
  
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
      
      numericInput("ibu", "IBU:", 25,
                   min = 1, max = 100),
      
      textInput("ti", "Enter your text here:", "")
    ),
    
    mainPanel
    (
      textOutput("abv"),
      
      textOutput("ibu"),

      ## Emoticons courtesy of http://www.freepik.com/
      conditionalPanel("input.ibu < 21", img(src='Emoticon1.jpg', align = "center")),
      conditionalPanel("input.ibu > 20 && input.ibu < 41", img(src='Emoticon2.jpg', align = "center")),
      ## conditionalPanel("input.ibu < 60", img(src='Emoticon3.jpg', align = "center")),
      conditionalPanel("input.ibu > 60", img(src='Emoticon4.jpg', align = "center"))
      
    )
  )
))