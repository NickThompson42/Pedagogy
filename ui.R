library(shiny)
library(httr)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Multi Dimensional Grade Calculator"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      # Input: selector for choosing the Grading Rubric
       selectInput(inputId = "gradingRubric",
                   label = "Content Grade",
                   choices = c("A++", "A+", "A", "B+", "B", "B-", "C+", "C", "C-", "D", "F", "F-"),
                   selected = "C",
                   selectize = F),
       selectInput(inputId = "gradingRubric",
                   label = "Organization & Citation Grade",
                   choices = c("A++", "A+", "A", "B+", "B", "B-", "C+", "C", "C-", "D", "F", "F-"),
                   selected = "C",
                   selectize = F),
       selectInput(inputId = "gradingRubric",
                   label = "Writing or Presentation Grade",
                   choices = c("A++", "A+", "A", "B+", "B", "B-", "C+", "C", "C-", "D", "F", "F-"),
                   selected = "C",
                   selectize = F)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("grade")
    )
  )))
