library(shiny)
library(httr)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Multi Dimensional Grade Calculator"),
  
  # Sidebar with a selector input for the desired grade 
  sidebarLayout(
    sidebarPanel(
      
      # Input: selector for choosing the Content Grade
       selectInput(inputId = "gradingContent",
                   label = "Content Grade",
                   choices = c("A++", "A+", "A", "B+", "B", "B-", "C+", "C", "C-", "D", "F", "F-"),
                   selected = "C",
                   selectize = F)
    ),
    mainPanel()
  )
  )
)
