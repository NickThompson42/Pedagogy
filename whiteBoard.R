rm(list = ls())
cat("\014")
library(shiny)
library(httr)
setwd("~/Documents/#Programming/GradeCalculatorAPI/GradeCalculatorAPI")

data <- read.csv("~/Documents/#Programming/GradeCalculatorAPI/GradeCalculatorAPI/GradeRubric.csv")
save(data, file = "GradeRubric.RData")

data <- "https://raw.githubusercontent.com/NickThompson42/Pedagogy/master/GradeRubric.csv"
data <- read.csv(data)

output$down <- downloadHandler(
  filename = function(){
    paste("GradeRubric.csv", input$type, sep=".")
  },
  # content is a function with argument file.  content write the plot to the device
  content = function(file){
    if(input$type == ".csv")
      csv(file) # open the csv device
    else
      RData(file) # open the pdf device
    dev.off()
  }
)

#####
# Code to implement in ui.R after I get a working prototype
selectInput(inputId = "gradingOrg",
            label = "Organization & Citation Grade",
            choices = c("A++", "A+", "A", "B+", "B", "B-", "C+", "C", "C-", "D", "F", "F-"),
            selected = "C",
            selectize = F),
selectInput(inputId = "gradingWrite",
            label = "Writing or Presentation Grade",
            choices = c("A++", "A+", "A", "B+", "B", "B-", "C+", "C", "C-", "D", "F", "F-"),
            selected = "C",
            selectize = F)

  
  
  
}) 