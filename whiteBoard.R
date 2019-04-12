rm(list = ls())
cat("\014")
library(shiny)
library(httr)
library(dplyr)
setwd("~/Documents/#Programming/GradeCalculatorAPI/GradeCalculatorAPI")
if(T){
  vlookup <- function(ref, #the value or values that you want to look for
                      table, #the table where you want to look for it; will look in first column
                      column, #the column that you want the return data to come from,
                      range=FALSE, #if there is not an exact match, return the closest?
                      larger=FALSE) #if doing a range lookup, should the smaller or larger key be used?)
  {
    if(!is.numeric(column) & !column %in% colnames(table)) {
      stop(paste("can't find column",column,"in table"))
    }
    if(range) {
      if(!is.numeric(table[,1])) {
        stop(paste("The first column of table must be numeric when using range lookup"))
      }
      table <- table[order(table[,1]),] 
      index <- findInterval(ref,table[,1])
      if(larger) {
        index <- ifelse(ref %in% table[,1],index,index+1)
      }
      output <- table[index,column]
      output[!index <= dim(table)[1]] <- NA
      
    } else {
      output <- table[match(ref,table[,1]),column]
      output[!ref %in% table[,1]] <- NA #not needed?
    }
    dim(output) <- dim(ref)
    output
  }
} # vlookup() function

#data <- read.csv("~/Documents/#Programming/GradeCalculatorAPI/GradeCalculatorAPI/GradeRubric.csv")
#save(data, file = "GradeRubric.RData")

#data <- "https://raw.githubusercontent.com/NickThompson42/Pedagogy/master/GradeRubric.csv"
#data <- read.csv(data)

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


data <- "https://raw.githubusercontent.com/NickThompson42/Pedagogy/master/GradeRubric.csv"; data <- read.csv(data)
gradeRubric_df <- data.frame(GradeChar = data$gradeChar, PointsVal = data$pointsValue, Point = data$points)
gradeRubric_df

# 20190411.  Nick, start here when you resume.
# You have successfully made a function that returns the correct number for the ContentGrade.
# Next you need to figure out how to get the different variable values for 125 and "B" below to 
# input with the Shiny App.
points <- 125
ContentGrade <- "B"
if(points > 0){
  grep <- gradeRubric_df %>% 
    filter(PointsVal == points)
    vlookup(ref = "B", table = grep, 3, FALSE )
} else{NA}


#####
# Code to implement in ui.R after I get a working prototype

# Input: selector for choosing the Content Grade
selectInput(inputId = "gradingContent",
            label = "Content Grade",
            choices = c("A++", "A+", "A", "B+", "B", "B-", "C+", "C", "C-", "D", "F", "F-"),
            selected = "C",
            selectize = FALSE)
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

  
  
  


#####
  # Code to call a points value froma a grade.
    # PointsAssigned = the graded points for the assignment given
    # PointsMultiple = the percentage of points the student earned for the assignment; 
                        # this is a number between 0 and 1.
calcGrade <- function(PointsAssigned, PointsMultiple){
  PointsAllotted = PointsAssigned * PointsMultiple
  GradeAssigned = vlookup(ref = PointsAllotted, 
                          table = read.csv(data <- "https://raw.githubusercontent.com/NickThompson42/Pedagogy/master/GradeRubric.csv")
)
  function(PointsAllotted)
}
calcGrade(75,0.95)


add <- function(x,y){
  x + y
}
add(1,1)

set.seed(42)
multiple = sample(1:9, 1, replace = TRUE)/10; multiple
grade <- ifelse(multiple <= 0.66, "F",
       ifelse(multiple < 0.66 & multiple < 0.7, "D",
              ifelse(multiple >=0.7 & multiple <= 0.72, "C-",
                     ifelse(multiple >= 0.73 & multiple <= 0.76, "C",
                            ifelse(multiple >= 0.77 &multiple  <= 0.79, "C+",
                                   ifelse(multiple >= 0.80 & multiple <= 0.82, "B-",
                                          ifelse(multiple >= 0.83 & multiple <= 0.86, "B",
                                                 ifelse(multiple >= 0.87 & multiple <= 0.89, "B+",
                                                        ifelse(multiple >= 0.90 & multiple <= 0.92, "A-",
                                                               ifelse(multiple >= 0.93 & multiple <= 0.96, "A",
                                                                      ifelse(multiple >= 0.97 & multiple < 1, "A+",
                                                                             ifelse(multiple == 1, "A++", NA))))))))))))


grade





