rm(list = ls())
cat("\014")
library(shiny)
library(dplyr)
library(xtable)
library(httr)
source("calcGrade.R")
GradeScale_Alpha <- c("A++","A+","A","A-","B+","B","B-","C+","C","C-","D","F")


ui <- fluidPage(
  titlePanel("Multi-Dimensional Grading Calculator"), # titlePanel()
  sidebarLayout(
    sidebarPanel("Assigned Points",
                 numericInput(inputId = "tagPoints_assigned",
                             label = "Use the slider to choose the assigned points.",
                             value = 100), # numreicInput()
                 selectInput(inputId = "tagContent_grade",
                             label = "Use the dropdown to assign a Content grade",
                             choices = GradeScale_Alpha,
                             selectize = F), # selectInput(tagContent_grade)
                 selectInput(inputId = "tagOrganization_grade",
                             label = "Use the dropdown to assign a Organization grade",
                             choices = GradeScale_Alpha,
                             selectize = F), # selectInput(tagOrganization_grade)
                 selectInput(inputId = "tagWriting_grade",
                             label = "Use the dropdown to assign a Writing grade",
                             choices = GradeScale_Alpha,
                             selectize = F) # selectInput(tagWriting_grade)
                 ), # sidebarPanel()
    mainPanel("Main Panel",
              tableOutput(outputId = "tagGradeTable_out")) # mainPanel()
  ) #sidebarLayout()
) # fluidPage()

server <- function(input, output){
  output$tagGradeTable_out <- renderTable({
    tagTable01 <- calcGrade(input$tagContent_grade,input$tagOrganization_grade,input$tagWriting_grade,input$tagPoints_assigned)
  }) # renderTable(){} 
} # function(input,output){}

shinyApp(ui = ui, server = server)