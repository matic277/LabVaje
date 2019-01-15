library("gridExtra"); library("ggThemeAssist"); library("tm"); library("wordcloud")
library("RColorBrewer"); library("rio"); library("dplyr"); library("ggplot2")
library("stringi"); library("stringr"); library("lazyeval")
sourceDir = "C:/git/LabVaje/R_Vaje/shiny_project/data_resources/"
sourceDir = "C:/git/SQL-R/LabVaje/R_Vaje/shiny_project/data_resources/"
RawDataPath = paste(sourceDir, "googleplaystore.csv", sep="")
RawReviewsPath = paste(sourceDir, "googleplaystore_user_reviews.csv", sep="")
ProcessedDataPath = paste(sourceDir, "processedData.csv", sep="")
ProcessedReviewsPath = paste(sourceDir, "processedReviews.csv", sep="")
# raw data apps
# rdata = rio::import(file=RawDataPath, format="csv")
# processed data apps
data = rio::import(file=ProcessedDataPath, format="csv")
# raw reviews
#rrvs = rio::import(file=RawReviewsPath, format="csv")
# processed reviews
rvs = rio::import(file=ProcessedReviewsPath, format="csv")

tibble::as_tibble(data)
colnames(data)
#------------------------------------------------------------------

