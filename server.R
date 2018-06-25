library(tm)

library(stringr)

library(shiny)

# 

# Loading the Rdata for the Quadgram,Trigram & Bigram Data frame files from the milestone project 

# 

quadgram <- readRDS("quadgram.RData");

trigram <- readRDS("trigram.RData");

bigram <- readRDS("bigram.RData");

mesg <<- "ready"

# 

# Reset the user input text before predicting the next word

# 

Predict <- function(x) {
  
  xclean <- removeNumbers(removePunctuation(tolower(x)))
  
  xs <- strsplit(xclean, " ")[[1]]
  
  #   
  
  # Using Stupid Backoff to rank the next word from the user input text
  
  #   
  
  if (length(xs)>= 3) {
    
    xs <- tail(xs,3)
    
    if (identical(character(0),head(quadgram[quadgram$unigram == xs[1] & quadgram$bigram == xs[2] & quadgram$trigram == xs[3], 4],1))){
      
      Predict(paste(xs[2],xs[3],sep=" "))
      
    }
    
    else {mesg <<- "Next word is predicted by using 4-grams"; head(quadgram[quadgram$unigram == xs[1] & quadgram$bigram == xs[2] & quadgram$trigram == xs[3], 4],1)}
    
  }
  
  else if (length(xs) == 2){
    
    xs <- tail(xs,2)
    
    if (identical(character(0),head(trigram[trigram$unigram == xs[1] & trigram$bigram == xs[2], 3],1))) {
      
      Predict(xs[2])
      
    }
    
    else {mesg<<- "Next word is predicted by using 3-grams"; head(trigram[trigram$unigram == xs[1] & trigram$bigram == xs[2], 3],1)}
    
  }
  
  else if (length(xs) == 1){
    
    xs <- tail(xs,1)
    
    if (identical(character(0),head(bigram[bigram$unigram == xs[1], 2],1))) {mesg<<-"No matched word found"; head("??",1)}
    
    else {mesg <<- "Next word is predicted by using 2-grams"; head(bigram[bigram$unigram == xs[1],2],1)}
    
  }
  
}





shinyServer(function(input, output) {
  
  output$prediction <- renderPrint({
    
    result <- Predict(input$inputString)
    
    output$text2 <- renderText({mesg})
    
    result
    
  });
  
  
  
  output$text1 <- renderText({
    
    input$inputString});
  
}

)