library(dplyr)


calcGrade <- function(ContentGrade_Alpha, OrganizationGrade_Alpha, WritingGrade_Alpha, TotalPoints){
  # Points Assigned for Content (ifelse) -----------------------------------------------------------
  PointsAssigned_Content <- ifelse(ContentGrade_Alpha == "F", 0.66,
                                   ifelse(ContentGrade_Alpha == "D", 0.67,
                                          ifelse(ContentGrade_Alpha == "C-", 0.70,
                                                 ifelse(ContentGrade_Alpha == "C", 0.75,
                                                        ifelse(ContentGrade_Alpha == "C+", 0.78,
                                                               ifelse(ContentGrade_Alpha == "B-", 0.80,
                                                                      ifelse(ContentGrade_Alpha == "B", 0.85,
                                                                             ifelse(ContentGrade_Alpha == "B+", 0.88,
                                                                                    ifelse(ContentGrade_Alpha == "A-", 0.90,
                                                                                           ifelse(ContentGrade_Alpha == "A", 0.95,
                                                                                                  ifelse(ContentGrade_Alpha == "A+", 0.97,
                                                                                                         ifelse(ContentGrade_Alpha == "A++", 1.00, NA))))))))))))
  
  # Points Assigned for Organization (ifelse) -----------------------------------------------------------
  PointsAssigned_Organization <- ifelse(OrganizationGrade_Alpha == "F", 0.66,
                                        ifelse(OrganizationGrade_Alpha == "D", 0.67,
                                               ifelse(OrganizationGrade_Alpha == "C-", 0.70,
                                                      ifelse(OrganizationGrade_Alpha == "C", 0.75,
                                                             ifelse(OrganizationGrade_Alpha == "C+", 0.78,
                                                                    ifelse(OrganizationGrade_Alpha == "B-", 0.80,
                                                                           ifelse(OrganizationGrade_Alpha == "B", 0.85,
                                                                                  ifelse(OrganizationGrade_Alpha == "B+", 0.88,
                                                                                         ifelse(OrganizationGrade_Alpha == "A-", 0.90,
                                                                                                ifelse(OrganizationGrade_Alpha == "A", 0.95,
                                                                                                       ifelse(OrganizationGrade_Alpha == "A+", 0.97,
                                                                                                              ifelse(OrganizationGrade_Alpha == "A++", 1.00, NA))))))))))))
  
  # Points Assigned for Writing (ifelse) -----------------------------------------------------------
  PointsAssigned_Writing <- ifelse(WritingGrade_Alpha == "F", 0.66,
                                   ifelse(WritingGrade_Alpha == "D", 0.67,
                                          ifelse(WritingGrade_Alpha == "C-", 0.70,
                                                 ifelse(WritingGrade_Alpha == "C", 0.75,
                                                        ifelse(WritingGrade_Alpha == "C+", 0.78,
                                                               ifelse(WritingGrade_Alpha == "B-", 0.80,
                                                                      ifelse(WritingGrade_Alpha == "B", 0.85,
                                                                             ifelse(WritingGrade_Alpha == "B+", 0.88,
                                                                                    ifelse(WritingGrade_Alpha == "A-", 0.90,
                                                                                           ifelse(WritingGrade_Alpha == "A", 0.95,
                                                                                                  ifelse(WritingGrade_Alpha == "A+", 0.97,
                                                                                                         ifelse(WritingGrade_Alpha == "A++", 1.00, NA))))))))))))
  
  # Points calculation -----------------------------------------------------------
  # [in the future, replace constant values with variable options in the app]
  
  ContentPoints = TotalPoints * PointsAssigned_Content * 0.4
  OrganizationPoints = TotalPoints * PointsAssigned_Organization * 0.2
  WritingPoints = TotalPoints * PointsAssigned_Writing * 0.4
  PointsMissed = TotalPoints - sum(ContentPoints, OrganizationPoints, WritingPoints)
  PointsEarned = TotalPoints - PointsMissed
  gradePct = (TotalPoints - PointsMissed) / TotalPoints
  
  # Final Grade Assigned (ifelse) -----------------------------------------------------------
  
  GradeAssigned <- ifelse(gradePct <= 0.66,                    "F",
                          ifelse(gradePct < 0.66  & gradePct < 0.7,   "D",
                                 ifelse(gradePct >=0.7   & gradePct <= 0.72, "C-",
                                        ifelse(gradePct >= 0.73 & gradePct <= 0.76, "C",
                                               ifelse(gradePct >= 0.77 & gradePct  <= 0.79,"C+",
                                                      ifelse(gradePct >= 0.80 & gradePct <= 0.82, "B-",
                                                             ifelse(gradePct >= 0.83 & gradePct <= 0.86, "B",
                                                                    ifelse(gradePct >= 0.87 & gradePct <= 0.89, "B+",
                                                                           ifelse(gradePct >= 0.90 & gradePct <= 0.92, "A-",
                                                                                  ifelse(gradePct >= 0.93 & gradePct <= 0.96, "A",
                                                                                         ifelse(gradePct >= 0.97 & gradePct < 1,     "A+",
                                                                                                ifelse(gradePct == 1, "A++", NA))))))))))))
  # Table Creation -----------------------------------------------------------
  Table01 = cbind(PointsEarned, GradeAssigned, gradePct, TotalPoints)
}
 
