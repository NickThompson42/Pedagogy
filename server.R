#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$grade <- renderTable({
    data <- read.csv(text=GET("https://raw.githubusercontent.com/NickThompson42/Pedagogy/master/GradeRubric.csv"), header = T;
    gradeRubric_df <- data.frame(GradeChar = data$gradeChar, PointsVal = data$pointsValue, Point = data$points)
    gradeRubric_df
  })
}
)




library(httr)

nuts <-read.csv(text=GET("https://raw.githubusercontent.com/opetchey/RREEBES/master/Beninca_etal_2008_Nature/data/nutrients_original.csv"), skip=7, header=T)