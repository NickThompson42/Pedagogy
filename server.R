rm(list = ls())
cat("\014")
library(shiny)
library(httr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$gradeTable <- renderTable({
    data <- "https://raw.githubusercontent.com/NickThompson42/Pedagogy/master/GradeRubric.csv"
    data <- read.csv(data)
    gradeRubric_df <- data.frame(GradeChar = data$gradeChar, PointsVal = data$pointsValue, Point = data$points)
    gradeRubric_df
  })
}
)






nuts <-read.csv(text=GET("https://raw.githubusercontent.com/opetchey/RREEBES/master/Beninca_etal_2008_Nature/data/nutrients_original.csv"), skip=7, header=T)