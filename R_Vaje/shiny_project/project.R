library("rio")
library("dplyr")
library("ggplot2")

sourceDir = "C:/git/SQL-R/LabVaje/R_Vaje/data_resources/"
fileName1 = "googleplaystore.csv"
fileName2 = "googleplaystore_user_reviews.csv"

filePath1 = paste(sourceDir, fileName1, sep="");
filePath2 = paste(sourceDir, fileName2, sep="");

data = rio::import(file=filePath1, format="csv")


colnames(data)

udf <- function(d) {
  tmp = 0
  sum = 0
  for (v in d) {
    if (startsWith(v, "$")) tmp = as.numeric(substr(v, 2, nchar(v)))
    else tmp = as.numeric(v)
    sum = sum + tmp
  }
  print(class(d))

  return(1);
}

data = data %>% mutate("Price2"=udf(Price))

data %>% select(Size, Price) %>% filter(Size=="Varies with device") %>% group_by(Size) %>% summarise(udf(Price))

