
#

library(shiny)

shinyUI(fluidPage(
  
  #theme = shinytheme("cerulean"),
  
  titlePanel("Word predictor app"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      textInput("inputText", label = h3("Please enter some text"), 
                
                value = ""),
      
      submitButton("Predict"),
      
      #textOutput("nextwords")
      
      br(),
      
      h3("Next words can be"),
      
      verbatimTextOutput("nextwords")
      
    ),
    
    mainPanel(
      
      tabsetPanel(type = "tabs", 
                  
                  tabPanel("App Info", 
                           
                           tags$div(br(),
                                    
                                    tags$p("Shiny application that predicts the next word."),
                                    
                                    tags$ol(
                                      
                                      tags$li(h5("Enter text")),
                                      
                                      tags$li(h5("Click Predict")),
                                      
                                      tags$li(h5("Most likely words will be displayed"))
                                      
                                    ),
                                    
                                    tags$p(h4("Prediction here!"))
                                    
                           )
                           
                  
                  
                  
                           
                           
                           
                  )
                  
      )
      
    )
    
  )
  
))
