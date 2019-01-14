library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Coursera Data Science Capstone Final Project"),
  fluidRow(HTML("<strong>Author: Mary0523</strong>") ),
  fluidRow(HTML("<strong>Date: 1-13-2019</strong>") ),

  # Sidebar with a slider input for number of bins 
   sidebarLayout(
     sidebarPanel(
       helpText("Enter words or sentence you want to predict the next word"),
       textInput("InputString","Enter words or sentence",value="How are"),
       actionButton("do","Click to predict")
     ),
  
  # Show a plot of the generated distribution
    mainPanel(
       h3("Predicted word"),
       fluidRow(column(5, verbatimTextOutput("PredictedWord", placeholder = TRUE))),
       h6("N-gram model is used for prediction of the next word based on previous 1, 2, or 3 words"),
       h6("Caution: the application may take 1 minute for prediction"),
       img(src="https://amuletanalytics.files.wordpress.com/2014/01/data_science_spec.jpg",align="middle")
    )
   )
))
