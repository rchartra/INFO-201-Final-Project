library(ggplot2)
library(dplyr)
library(tidyr)

df <- read.csv("NYC_Education_Quality.csv")

# Success Factors

grouped <- group_by(df[df$PERCENT.RECEIVES.PUBLIC.ASSISTANCE != 0,], PERCENT.RECEIVES.PUBLIC.ASSISTANCE, School.District)
pa_sum <- summarize(grouped, SAT_Math = mean(SAT_Math), SAT_Read = mean(SAT_Read), Coll_Rate = mean(Coll_Rate))

ggplot(data = df, aes(x=Teach_Eff, y=SAT_Math, fill=Teach_Eff)) + geom_violin() + labs(title = "Effect of Teaching Effectiveness on Success", x="Teacher Effectiveness Rating", y="input$success_3") + scale_fill_brewer(name="Rating", palette="Pastel2")

# Public Assistance

med_assistance <- median(unique(df$PERCENT.RECEIVES.PUBLIC.ASSISTANCE)[order(unique(df$PERCENT.RECEIVES.PUBLIC.ASSISTANCE))])
#med_assistance <- 0.25

income_level <- function(dbn){
  assistance <- df$PERCENT.RECEIVES.PUBLIC.ASSISTANCE[df$DBN == dbn]
  if (assistance < med_assistance & assistance > 0) {
    return("High")
  } else if (assistance > med_assistance) {
    return("Low")
  } else {
    return(0)
  }
}

df["Income_Level"] <- mapply(income_level, df$DBN)

#ggplot(data=df, aes(x=Borough, y=PERCENT.RECEIVES.PUBLIC.ASSISTANCE, fill=Borough)) + geom_violin() + labs(title = "Distribution of Public Assistance Received by Borough", y="Assistance Received")


#low_vs_high_coll <- ggplot(data = df) + geom_bar(aes(x= Borough, y = Coll_Rate, fill = Income_Level), stat ="identity", position = position_dodge())
#low_vs_high_satm <- ggplot(data = df) + geom_bar(aes(x= Borough, y = SAT_Math, fill = Income_Level), stat ="identity", position = position_dodge())
#low_vs_high_satr <- ggplot(data = df) + geom_bar(aes(x= Borough, y = SAT_Read, fill = Income_Level), stat ="identity", position = position_dodge())

# nyc_exp_cr <- ggplot(data = df, aes(x = Exp_Teach, y = Coll_Rate)) + geom_point()
# bronx_exp_cr <- ggplot(data = df[df$Borough == "Bronx",], aes(x = Exp_Teach, y = Coll_Rate)) + geom_point()

# Specialized Schools

s_schools <- c("10X445", "14K449", "13K430", "03M485", "05M692", "10X696", "28Q687", "31R605", "02M475")

specialized_schools <- function(dbn){
  return(is.element(dbn, s_schools))
}

df["Specialized"] <- mapply(specialized_schools, df$DBN)

#ggplot(data = df[df$Borough == "Bronx",], aes(x = PERCENT.RECEIVES.PUBLIC.ASSISTANCE, y = SAT_Math)) + geom_point()

grouped <- group_by(df, Specialized)
df_Summary_s <- summarize(grouped, Mean_Teach_Eff=mean(Teach_Eff_Num, na.rm=TRUE), Mean_Support=mean(Support_Env, na.rm=TRUE), Mean_CR = mean(Coll_Rate, na.rm=TRUE), Mean_TE =mean(Exp_Teach, na.rm=TRUE))
dfm_s <- pivot_longer(df_Summary_s, -Specialized, names_to="Metric", values_to="value")
#ggplot(data = dfm_s, aes(x= variable, y = value)) + geom_bar(aes(fill=Specialized), stat ="identity", position = position_dodge()) + labs(title = "Average Quality Rankings of Regular vs Specialized Schools", y="") + scale_fill_hue(name="School Type", labels = c("Regular", "Specialized")) + scale_x_discrete(labels=c("Receives Assistance", "College Enrollment", "Supportive Enviroment", "Teacher Experience", "Teach Effectiveness"))
