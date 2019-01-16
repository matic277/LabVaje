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

# most frequent words per category (and maybe installs aswell?)

# IDEA !!! +++
# get most frequent words in apps grouped by installs

selectTopNWords <- function(d, n) {
  output = ""
  words = d %>% top_n(n) %>% select(Word)
  i = 0
  for (w in words) {
    output = paste(output, w, collapse=" ")
    i = i + 1
    if (i==n) break;
  }
  return(output)
}

occurences <- function(d) {
  allWords = ""
  for (e in d) {
    split = str_split(e, " ")[[1]]
    allWords = paste(allWords, paste(split, collapse=" "))
  }
  # get a pair of word - num_of_occurrences and put it in a dataframe
  df = as.data.frame(table(allWords))
  colnames(df) = c("Word", "Freq")
  #print(class(df))
  return(df %>% arrange(desc(Freq)))
}

r = data %>% select(App, eInstalls, Category) %>% 
  group_by(Category, eInstalls) %>% 
  summarise("TopWords"=selectTopNWords(occurences(App), 3)) %>%
  arrange(Category, desc(eInstalls))


print(r, n=500)







