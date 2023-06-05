library(shiny)
#library(ggplot2)
source("plots.R")

#df <- read.csv("NYC_Education_Quality.csv")

intro_pg <- tabPanel(
  title = "Introduction",
  
  titlePanel("Analysis of NYC High School Education Inequity"),
  
  img(src = "edpic.jpg",
      width= "50%"),
  p("Picture of an unbalance equilibirium, where the privileged white groups are on top and the minority groups at the bottom."),
  p(a(href = "https://sundial.csun.edu/92480/opinions/its-time-to-end-the-cycle-of-educational-inequity/#", 
      "Photo credit: Kristine Delicana, 2015")),
  
  br(),
  
  
  h3(strong("Problem Statement")),
  
  p("Everyone has the right to education, as stated in the Universal Declaration of Human Rights by the United
    Nations. However, not everyone is given an equal access to this basic right since the gap in education is growing bigger 
    and bigger especially between the group of rich and poor. Students from low-income households, people of color, 
    and those who live in rural regions are disproportionately impacted by this gap and they are denied opportunities 
    that should be open to everyone. It is important to identify this problem and take necessary action so that we could 
    help underprivileged students to earn an equal opportunity in education. We believe our story will inspire people
    to confront the systemic barrier that keep millions of students from reaching their full potential.
    Also, we hope to inspire people to work towards the goal where everyone has the chance to achieve."),
  
  br(), 
  h3(strong("Project Description")),
  
  p("As education inequity remains a major problem today, we made an analysis on New York City's high school
    datasets to better understand this problem. We've analysed the success metrics of each school based on 
    the economic status and income level in different New York City's boroughs. For example, we looked at how the low/high income 
    level affects the SAT scores and college enrollment rate in each school district. Basically, the values of how much 
    public assistance a school’s students receives determine the income level. Then, we examined the association
    between SAT scores and the economic status in different school districts. In this case, the economic status is determined by
    the population receiving public assistance. Lastly, we checked if the learning resources are evenly distributed across the boroughs and observed
    how they affect a student's achievement in general. To do this, we plotted a graph to see the overall performance of each high 
    school and compare their resources."),
  
  br(),
  h3(strong("Background research")),
  
  p("Based on the readings below, we know New York City has had a long history of racial inequity in education. Usually,
    schools with high concentrations of low-income and minority students receive fewer instructional resources than others. 
    Also, high standardized test scores are often closely correlated with race, wealth and parental education. Next, we're
    going to examine on the association amongs these factors in different story settings based on these assumptions."),
  
  p(a(href = "https://www.cssny.org/news/entry/unequal-education-in-new-yorks-public-school-system1", 
      "Unequal Education in New York’s Public School System")),
  p(a(href = "https://www.brookings.edu/articles/unequal-opportunity-race-and-education/", 
      "Unequal Opportunity: Race and Education")),
  p(a(href = "https://www.lawyerscommittee.org/educational-equity-in-college-admissions-can-only-be-achieved-if-universities-abandon-racially-biased-sat-act-tests/", 
      "Educational Equity in College Admissions Can Only Be Achieved if Universities Abandon Racially Biased SAT/ACT Tests")),
  
  br()
)

story_1 <- tabPanel(
  "Success Factors",
  fluidPage(
    titlePanel("What Determines Success?"),
    p("There are many aspects that determine whether or not a student will 
    be able to do well in school, but which one has the clearest effect on success?
    Here we will look at various measures of school quality to try and gain a better
    understanding of what determines success.")
  ),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId="success_3",
        label="Select a Success Metric",
        choices = c("SAT Math Scores", "SAT Reading Scores", "College Enrollment Rate")
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          "Teaching Effectiveness",
          plotOutput("t_eff"),
          p("For SAT scores it is clear that the majority of schools have averages
            around 450. However as the teaching effectiveness rating goes up the
            upper bound of SAT scores tends to increase as well. In addition for
            schools that were rated as 'Well Developed' the distribution of the scores
            is much more uniform. For college enrollment rates the relationship
            between teaching effectiveness and college enrollment rates is
            clear as the widest part of the distribution of schools increases
            as the teaching effectiveness increases.")
        ),
        tabPanel(
          "Supportive Environment",
          plotOutput("s_env"),
          p("For SAT scores and college enrollment rates there's no clear cut linear correlation
            between a supportive environment and success, however for SAT scores 
            you can see that most schools that got high SAT scores did have a high 
            supportive environment score. On the other hand one can see that almost
            no schools with the lowest supportive environment scores got high SAT
            scores. So there is some slight relationship between the two.")
        ),
        tabPanel(
          "Teacher Experience",
          plotOutput("t_exp"),
          p("As with the supportive environment scores there is no clear linear correlation
            between teaching experience and success but you can see that the upper
            bound of the data points does increase as teacher experience increases,
            so there is some relationship between teacher experience and success.
            With college enrollment rates it's even less clear, but the same pattern
            shows.")
        ),
        tabPanel(
          "Public Assistance",
          plotOutput("p_ast"),
          p("The public assistance data is determined by school district instead
            of by school so there is a lot less data which makes it hard to see
            a pattern. In addition a lot of data was missing here so overall it's
            hard to make a conclusion on the relationship.")
        )
      )
    )
  ),
  p("Overall we can conclude that teaching effectiveness seems to be the greatest
    determinant of student success as it is a simple categorical variable rather
    than individual data points. Nonetheless subtle relationships can still be
    seen via the other factors with an exeption of public assistance which we will
    examine a little more closely in the public assistance section.")
)

story_2 <- tabPanel(
  "Public Assistance",
  fluidPage(
    titlePanel("Low Public Assistance vs High Public Assistance"),
    p("NOTE: The dataset we are using does not have data on Staten island and
      lacks a lot of data for Queens. In the case of Queens, there is not enough
      data to divide school districts by income level. As such we are focusing 
      our analysis on the remaining 3 boroughs, however the Queens data can still 
      be viewed if desired."),
    p(""),
    p("The percentage of low and high income students can be determined for each
      school district by what percentage of families in the district receive
      monetary assistance by the government. The idea is that school districts 
      that receive a high amount of public assistance generally have students whose 
      families are lower income. Using such data we have divided each
      school district in NYC into two groups, low and high income, based on whether the
      school district received above or below the median amount of monetary
      assistance across all school districts. Using this categorization we can
      compare success metrics such as test scores and college enrollment rates
      between the two groups."),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "success_2",
          label = "Select a Success Metric",
          choices = c("SAT Math Scores", "SAT Reading Scores", "College Enrollment Rate")
        ),
        checkboxInput(
          inputId = "queens",
          label="Include Queens?",
          value=FALSE
        )
      ),
      mainPanel(
        plotOutput("low_high")
      )
    ),
    p("We can see that in the Bronx and in Brooklyn lower income school districts
      actually perform better than higher income school districts. This is true for
      SAT scores and college enrollment rates. There are many possible reasons
      as to why this is the case. For one NYC has been famous for it's education
      inequality issues throughout history and as such a lot of work has been done 
      to try and improve the situation through government programs and policy changes.
      This could be a sign that these are working in these boroughs which is great
      news! However we should be careful with our conclusions. These results are
      from looking at just one marker for income level from one data set. From another
      point of view, districts that are receiving less public assistance may be being
      overlooked by the government and not being given the monetary assistance they
      need for their students to succeed. In that case then those school districts are 
      repeatedly doing worse than the other districts which is something that should
      be remedied."),
    p(""),
    p("We can also look at the distribution of the public assistance received data
      for each borough:"),
    plotOutput("pa_2"),
    p("We can see the fact that the data set did not have data for staten island, and
      the Queens data should be looked at with caution as there are few data points.
      However if we look at the remaining three boroughs there are some striking
      differences in the shape of the distribution. Brooklyn has a pretty even distribution
      of it's schools when looking at how much public assistance they receive while
      Manhattan and the Bronx have similar shapes with multiple peaks throughout the
      distribution. It is notable that their greatest peaks both occur at roughly
      35% receiving public assistance, which shows the two boroughs are roughly similar
      in this manner.")
  )
)

story_3 <- tabPanel(
  "Specialized Schools",
  fluidPage(
    titlePanel("The Exceptional..."),
    p("Within the public schools system of NYC there are 9 schools that stand
      above the rest. These schools are known as the specialized high schools of
      New York City. These schools are competive to get into, and students must
      pass an admissions test and have their application accepted in order to
      attend. Due to the competitive admissions and higher quality of education offered 
      these schools have better success statistics for their students than the
      average NYC high school."),
    
    plotOutput("s_compare"),
    
    p("We can see that within each borough the trend continues, with varying 
      degrees of separation from their counterparts. Here we can also more clearly
      see that specialized schools tend to stand out from their counterparts when it
      comes to the quality of education they offer. We can see that specialized schools
      tend to have teachers with more years of teaching experience than regular schools."),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "borough",
          label = "Select a Borough",
          choices = sort(unique(df$Borough))
        ),
        selectInput(
          inputId = "success_1",
          label = "Select a Success Metric",
          choices = c("SAT Math Scores", "SAT Reading Scores", "College Enrollment Rate")
        )
      ),
      mainPanel(
        htmlOutput("plot_title"),
        plotOutput("outlier_plot")
      )
    )
  )
)

summary <- tabPanel(
  title = "Summary",
  titlePanel("Summary about Education Inequity in Datasets"),
  
  p("We find out that most of the high schools' success metrics are impacted by their income level, school quality 
    and learning resources, which makes us believe that there is an inequity in education. The exception to this
    pattern are the specialized high schools, which perform much better than all other schools overall."),
  
  br(),
  
  h3(strong("Justification")),  
  p("Even though we found a special case where the low income groups actually did better than the high income groups in some tests,
    we decided not to take it into consideration when making the conclusion because it's an ambiguous case. 
    As suggested by the visuals before, we can tell that the educational resources are not distributed evenly across the high schools. Generally, 
    students with a low economic status are less likely to achieve in education. This is because the school districts that have a 
    large proportion of students with low income backgrounds receive less funding and support outside of government funds. They typically 
    have less programs to support their students and less experienced teachers for teachings. Thus, the learning environment becomes less supportive to 
    the students due to the lack of educational resources. In contrast, the privileged groups of people (people with high 
    economic status) will have easier access to any academic resources they need and they are given more support. For example, 
    high schools that are located in wealthy neighborhoods provide their students with advanced coursework and technology as well as high 
    quality educators who are experienced in teaching. Hence, they have a higher chance of getting high SAT scores and gaining admission to
    a top university. We believe these unfair treatments contribute to the education inequity in NYC. "),
  
  br(),
  
  h3(strong("Takeaway Message")),
  
  p("Education inequity is real and it is brought to our attention by this study. Hence, addressing education inequity should be our 
    next action: we need to prioritize equitable funding and inclusive policies in schools to ensure every 
    student has an equal opportunity to succeed. By investing in educational equity, we can build a better society, 
    where everyone has the chance to achieve regardless of their background or color."),
  
  hr(),
  
  h4(strong("About")),
  
  p("This study is contributed by Suk Jin Chung and Robin Sarah Chartand with reference to the following websites: "),
  
  p(a(href = "https://infohub.nyced.org/reports/school-quality/school-quality-reports-and-resources/school-quality-report-citywide-data", 
      "NYC High School Quality Rankings")),
  p(a(href = "https://data.cityofnewyork.us/Education/School-District-Breakdowns/g3vh-kbnw/explore", 
      "NYC School District Breakdown"))

)

ui <- navbarPage(
  "A Study of the NYC Education System",
  intro_pg,
  story_1,
  story_2,
  story_3,
  summary
)

server <- function(input, output){
  
  # Success Factors
  
  output$t_eff <- renderPlot({
    if (input$success_3 == "SAT Math Scores") {
      p <- ggplot(data = df, aes(x=Teach_Eff, y=SAT_Math, fill=Teach_Eff)) + geom_violin() + labs(title = "Effect of Teaching Effectiveness on Success", x="Teacher Effectiveness Rating", y=input$success_3) + scale_fill_brewer(name="Rating", palette="Pastel2")
    } else if (input$success_3 == "SAT Reading Scores") {
      p <- ggplot(data = df, aes(x=Teach_Eff, y=SAT_Read, fill=Teach_Eff)) + geom_violin() + labs(title = "Effect of Teaching Effectiveness on Success", x="Teacher Effectiveness Rating", y=input$success_3) + scale_fill_brewer(name="Rating", palette="Pastel2")
    } else if (input$success_3 == "College Enrollment Rate") {
      p <- ggplot(data = df, aes(x=Teach_Eff, y=Coll_Rate, fill=Teach_Eff)) + geom_violin() + labs(title = "Effect of Teaching Effectiveness on Success", x="Teacher Effectiveness Rating", y=input$success_3) + scale_fill_brewer(name="Rating", palette="Pastel2")
    }
    
    return(p)
  })
  
  output$s_env <- renderPlot({
    if (input$success_3 == "SAT Math Scores") {
      p <- ggplot(data = df, aes(x=Support_Env, y=SAT_Math)) + geom_point(color = "turquoise") + labs(title = "Effect of a Supportive Environment on Success", x="Supportive Environment Score", y=input$success_3)
    } else if (input$success_3 == "SAT Reading Scores") {
      p <- ggplot(data = df, aes(x=Support_Env, y=SAT_Read)) + geom_point(color = "turquoise") + labs(title = "Effect of a Supportive Environment on Success", x="Supportive Environment Score", y=input$success_3)
    } else if (input$success_3 == "College Enrollment Rate") {
      p <- ggplot(data = df, aes(x=Support_Env, y=Coll_Rate)) + geom_point(color= "turquoise") + labs(title = "Effect of a Supportive Environment on Success", x="Supportive Environment Score", y=input$success_3)
    }
      
    return(p)
  })
  
  output$t_exp <- renderPlot({
    if (input$success_3 == "SAT Math Scores") {
      p <- ggplot(data = df, aes(x=Exp_Teach, y=SAT_Math)) + geom_point(color = "mediumpurple1") + labs(title = "Effect of Average Teacher Experience on Success", x="Teacher Experience Score", y=input$success_3)
    } else if (input$success_3 == "SAT Reading Scores") {
      p <- ggplot(data = df, aes(x=Exp_Teach, y=SAT_Read)) + geom_point(color = "mediumpurple1") + labs(title = "Effect of Average Teacher Experience on Success", x="Teacher Experience Score", y=input$success_3)
    } else if (input$success_3 == "College Enrollment Rate") {
      p <- ggplot(data = df, aes(x=Exp_Teach, y=Coll_Rate)) + geom_point(color= "mediumpurple1") + labs(title = "Effect of Average Teacher Experience on Success", x="Teacher Experience Score", y=input$success_3)
    }
    
    return(p)
  })
  
  output$p_ast <- renderPlot({
    
    if (input$success_3 == "SAT Math Scores") {
      p <- ggplot(data = pa_sum, aes(x=PERCENT.RECEIVES.PUBLIC.ASSISTANCE, y=SAT_Math)) + geom_point(color = "darkorange1") + labs(title = "Effect of Average Public Assistance Received on Success", x="Percentage of Students that Receive Public Assistance", y=input$success_3)
    } else if (input$success_3 == "SAT Reading Scores") {
      p <- ggplot(data = pa_sum, aes(x=PERCENT.RECEIVES.PUBLIC.ASSISTANCE, y=SAT_Read)) + geom_point(color = "darkorange1") + labs(title = "Effect of Average Public Assistance Received on Success", x="Percentage of Students that Receive Public Assistance", y=input$success_3)
    } else if (input$success_3 == "College Enrollment Rate") {
      p <- ggplot(data = pa_sum, aes(x=PERCENT.RECEIVES.PUBLIC.ASSISTANCE, y=Coll_Rate)) + geom_point(color= "darkorange1") + labs(title = "Effect of Average Public Assistance Received on Success", x="Percentage of Students that Receive Public Assistance", y=input$success_3)
    }
    
    return(p)
  })
  
  # Public Assistance
  
  output$pa_2 <- renderPlot({
    p <- ggplot(data=df, aes(x=Borough, y=PERCENT.RECEIVES.PUBLIC.ASSISTANCE, fill=Borough)) + geom_violin() + labs(title = "Distribution of Public Assistance Received by Borough", y="Assistance Received")
    return(p)
  })
  
  output$low_high <- renderPlot({
    if (!input$queens) {
      dat <- df[df$Borough != "Queens" & df$Income_Level != 0,]
    } else {
      dat <- df[df$Income_Level != 0,]
    }
    
    if (input$success_2 == "SAT Math Scores") {
      p <- ggplot(data = dat) + geom_bar(aes(x= Borough, y = SAT_Math, fill = Income_Level), stat ="identity", position = position_dodge()) + labs(title = "Success Metrics by Borough for Different Income Levels", y=input$success_2)+ scale_fill_brewer(name= "Income Level", palette="Paired")
    } else if (input$success_2 == "SAT Reading Scores") {
      p <- ggplot(data = dat) + geom_bar(aes(x= Borough, y = SAT_Read, fill = Income_Level), stat ="identity", position = position_dodge()) + labs(title = "Success Metrics by Borough for Different Income Levels", y=input$success_2) + scale_fill_brewer(name="Income Level", palette = "Paired")
    } else if (input$success_2 == "College Enrollment Rate") {
      p <- ggplot(data = dat) + geom_bar(aes(x= Borough, y = Coll_Rate, fill = Income_Level), stat ="identity", position = position_dodge()) + labs(title = "Success Metrics by Borough for Different Income Levels", y=input$success_2) + scale_fill_brewer(name="Income Level", palette = "Paired")
    }
    return(p)
  })
  
  # Specialized Schools
  
  output$s_compare <- renderPlot({
    p <- ggplot(data = dfm_s, aes(x= Metric, y = value)) + geom_bar(aes(fill=Specialized), stat ="identity", position = position_dodge()) + labs(title = "Average Quality Rankings of Regular vs Specialized Schools", y="") + scale_fill_brewer(name="School Type", labels = c("Regular", "Specialized"), palette="Accent") + scale_x_discrete(labels=c("College Enrollment", "Supportive Enviroment", "Teacher Experience", "Teaching Effectiveness"))
    return(p)
  })
  
  output$outlier_plot <- renderPlot({
    if (input$success_1 == "SAT Math Scores") {
      p <- ggplot(data = df[df$Borough == input$borough,], aes(x = Exp_Teach, y = SAT_Math, color=Specialized)) + geom_point() + labs(title = "SAT Math Scores by Teaching Experience", x = "Avg. Years of Teaching Experience Score", y = "SAT Math Scores") + scale_color_hue(name="School Type", labels=c("Regular", "Specialized"))
    } else if (input$success_1 == "SAT Reading Scores") {
      p <- ggplot(data = df[df$Borough == input$borough,], aes(x = Exp_Teach, y = SAT_Read, color=Specialized)) + geom_point() + labs(title = "SAT Reading Scores by Teaching Experience", x = "Avg. Years of Teaching Experience Score", y = "SAT Reading Scores") + scale_color_hue(name="School Type", labels=c("Regular", "Specialized"))
    } else if (input$success_1 == "College Enrollment Rate") {
      p <- ggplot(data = df[df$Borough == input$borough,], aes(x = Exp_Teach, y = Coll_Rate, color=Specialized)) + geom_point() + labs(title = "College Enrollment by Teaching Experience", x = "Avg. Years of Teaching Experience Score", y = "College Enrollment Rate") + scale_color_hue(name="School Type", labels=c("Regular", "Specialized"))
    }
    return(p)
  })
  output$plot_title <- renderText({paste("<b>",input$borough, "</b>")})
}

shinyApp(ui = ui, server = server)