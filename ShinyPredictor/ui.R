library(shiny)

shinyUI(fluidPage(
  titlePanel("Natural Language Processing"),

    
  sidebarLayout(
    sidebarPanel(
      
      tags$b("This application provides a demonstration of language processing by allowing the user",
             " to enter a word or phrase in the text box.  The algorithm will make a suggestion for the next word."),

      br(),
      
      br(),
      
      tags$b("This implementation is similar to that used on cell phones to make suggestions as users type out texts or emails."),
      
      br(),
      
      br(),
      
      helpText("Note: There may be a short delay as the dataset is loaded into memory.",
               "Once loaded, a word prediction will be shown at the bottom of the screen."),
      
      br(),
      
      br(),
      
      textInput("ti", "To start, begin typing a word or phrase here:", ""),

      width=12
    ),
    
    mainPanel
    (
      br(),
      
      h1("May I suggest this as your next word:", 
          style = "font-weight: 500; line-height: 1.1; 
          color: #4d3a7d;"),
      
      h1(textOutput("nxtWord"),
         style = "font-weight: 500; line-height: 1.1; 
          color: #FF0000; text-align:center;" ),
      
      width=12,
      
      br(),
      
      br(),
      
      br(),
      
      h4("My Github repository has a complete description of my work on this project.", 
         style = "color: #4d3a7d;"),
      tags$a(href="https://github.com/swarendt/NaturalLanguageProcessing", "Click here to check it out!")
    )
    
    
  )
))