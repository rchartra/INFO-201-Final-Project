library(readxl)
library(dplyr)
library(plyr)

if (exists("sum_data")==FALSE) {
  sum_data <- read_excel("201819_hs_sqr_results.xlsx")
  col_data <- read_excel("201819_hs_sqr_results.xlsx", sheet = "Student Achievement")
  score_data<- read_excel("201819_hs_sqr_results.xlsx", sheet = "Additional Info")
}
  
data1 <- select(sum_data, c("...3", "...16", "...21", "...45"))
data2 <- select(col_data, c("...148"))
data3 <- select(score_data, c("...145", "...147"))

df <- cbind(data1, data2, data3)  

#print(names(score_data)[which(score_data == "Metric Value - Average score of students in the current cohort who took the SAT Reading and Writing exam", arr.ind=T)[, "col"]])


col_names <- c("DBN", "Support_Env", "Teach_Eff", "Exp_Teach", "Coll_Rate", "SAT_Math", "SAT_Read")
colnames(df) <- col_names
df <- df[-(1:3),]

df$Teach_Eff_Num <- mapvalues(df$Teach_Eff, from=c("Developing", "Proficient", "Well Developed"), to=c(1,2,3))


df[, -c(1,3)] <- sapply(df[, -c(1,3)], as.numeric)

print(length(df[!complete.cases(df), ]$DBN))

#[1] "DBN"                                                                                                     
#[2] "Supportive Environment - Percent Positive"                                                               
#[3] "Quality Review - How effective is the teaching and learning"                                             
#[4] "Percent of teachers with 3 or more years of experience"                                                  
#[5] "Metric Value - Postsecondary Enrollment Rate - 6 Months"                                                 
#[6] "Metric Value - Average score of students in the current cohort who took the SAT Math exam"               
#[7] "Metric Value - Average score of students in the current cohort who took the SAT Reading and Writing exam"