library(readxl)
library(dplyr)
library(stringr)
library(plyr)

# Clean and filter data from NYC DOE

if (exists("sum_data")==FALSE) {
  sum_data <- read_excel("201819_hs_sqr_results.xlsx")
  col_data <- read_excel("201819_hs_sqr_results.xlsx", sheet = "Student Achievement")
  score_data<- read_excel("201819_hs_sqr_results.xlsx", sheet = "Additional Info")
}
  
data1 <- select(sum_data, c("...3", "...16", "...21", "...45"))
data2 <- select(col_data, c("...148"))
data3 <- select(score_data, c("...145", "...147"))

df <- cbind(data1, data2, data3)  

col_names <- c("DBN", "Support_Env", "Teach_Eff", "Exp_Teach", "Coll_Rate", "SAT_Math", "SAT_Read")
colnames(df) <- col_names
df <- df[-(1:3),]

# Add new column that turns teach_eff into a number
df$Teach_Eff_Num <- mapvalues(df$Teach_Eff, from=c("Developing", "Proficient", "Well Developed"), to=c(1,2,3))

df[, -c(1,3)] <- sapply(df[, -c(1,3)], as.numeric)

# Add new column that contains just the school district
df$School.District <- substring(df$DBN, first=1, last=2)

# Add new column that contains just the borough

df$Borough <- mapvalues(substring(df$DBN, first=3, last=3), from=c("M", "X", "K", "Q", "R"), to=c("Manhattan", "Bronx", "Brooklyn", "Queens", "Staten Island"))

# Clean Public Assistance Data


df_1 <- read.csv("school-district-breakdowns.csv") 

#clean dataframe to get school district and fund received
receive_fund_df <- select(df_1,JURISDICTION.NAME, PERCENT.RECEIVES.PUBLIC.ASSISTANCE)
colnames(receive_fund_df)[1] = "School.District"
school_district <- substring(receive_fund_df$School.District, first=5, last=6)

receive_fund_df$School.District <- school_district

# Merging the Data frames

merged_df <- merge(df, receive_fund_df, by="School.District")
merged_df[, "School.District"] <- sapply(merged_df[, "School.District"], as.numeric)

# Summary Data frame
grouped <- group_by(merged_df, School.District)
df_summary <- summarize(grouped, Mean_Receives_PA=mean(PERCENT.RECEIVES.PUBLIC.ASSISTANCE, na.rm=TRUE), Mean_Teacher_Experience=mean(Exp_Teach, na.rm=TRUE), Mean_Read_SAT=mean(SAT_Read, na.rm=TRUE), Mean_Math_SAT=mean(SAT_Math, na.rm=TRUE), Mean_College_Enroll=mean(Coll_Rate, na.rm=TRUE), Mean_Teach_Eff=mean(Teach_Eff_Num, na.rm=TRUE))

# Export to csv

write.csv(merged_df, "NYC_Education_Quality.csv")
