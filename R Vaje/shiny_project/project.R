library("rio")
library("dplyr")
library("ggplot2")

setwd("C:/git/SQL-R/LabVaje/R Vaje/shiny_project")
fileName1 = paste(getwd(), "/athlete_events.csv", sep="")
fileName2 = paste(getwd(), "/StudentsPerformance.csv", sep="")
data = rio::import(file=fileName2, format="csv")


colnames(data)

data %>% group_by(gender) %>% summarise(reading=mean(`reading score`), math=mean(`math score`), writing=mean(`writing score`))



data %>% group_by(gender, lunch) %>% summarise(reading=mean(`reading score`), math=mean(`math score`), writing=mean(`writing score`))

head(
data %>% group_by(gender, `parental level of education`) %>% summarise(reading=mean(`reading score`), math=mean(`math score`), writing=mean(`writing score`)),
24)
     

