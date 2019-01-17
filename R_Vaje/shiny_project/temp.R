library("gridExtra"); library("ggThemeAssist"); library("tm"); library("wordcloud")
library("RColorBrewer"); library("rio"); library("dplyr"); library("ggplot2")
library("stringi"); library("stringr"); library("lazyeval");
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
  d = d %>% select(Word, Freq) %>% arrange(desc(Freq)) %>% top_n(3)
  d = d$Words
 # words
  
  return(paste(d, collapse=" "))
}

occurences <- function(d) {
  allWords = ""
  for (e in d) {
    split = str_split(e, " ")[[1]]
    #allWords = combine(allWords, split)
    allWords = paste(allWords, paste(split, collapse=" "))
  }
  # get a pair of word - num_of_occurrences and put it in a dataframe
  df = as.data.frame(table(allWords))
  colnames(df) = c("Word", "Freq")
  #print(class(df))
  return(df)
}

r = data %>% select(App2, eInstalls, Category) %>% 
  group_by(Category, eInstalls) %>% 
  summarise("TopWords"=selectTopNWords(occurences(App2), 3)) %>%
  arrange(Category, desc(eInstalls))
r



# idea
# most frequent words in apps based on content rating

data %>% select(`Content Rating`, App2) %>% group_by(`Content Rating`) %>% summarise("TopWords"=selectTopNWords(occurences(App2), 3))

df = occurences(data$App2)

tibble::as_tibble(df)

df  %>% select(Word, Freq) %>% arrange(desc(Freq)) %>% top_n(5)

selectTopNWords(occurences(data$App2), 2)



wordss = data.frame(
  Word=c("Sona Firefox", "Firefox   ", "Focus Focus", "Focus", "Mad", "Dash", "Fo", "Cash"),
  Freq=c(1, 2, 3, 4, 5, 6, 7, 8)
)
wordss


words = words %>% select(Word, Freq) %>% arrange(desc(Freq)) %>% top_n(3)

words = words$Word
words

paste(wordss, collapse=" ")




selectTopNWords(occurences(words$Words), 2)

# gets a dataframe d$Word, d$Freq, n as number of top words
topn <- function(d, n) {
  freqWords = (
    d %>% select(Word, Freq) %>% 
    arrange(desc(Freq)) %>% 
    top_n(n)
  )$Word
  return(paste(freqWords, collapse=" "))
}

# gets a column: data$Name
occurence <- function(d) {
  combined = paste(d, collapse=" ")
  allWords = str_split(combined, " ")[[1]]
  df = as.data.frame(table(allWords))
  colnames(df) = c("Word", "Freq")
  return(df)
}

topn(occurence(data$App2), 10)

topn(occurence(wordss$Word), 10)


data %>% select(eInstalls, App2) %>% group_by(eInstalls) %>% summarise("TopWords"=topn(occ(App2), 10))




neu = rvs %>% filter(Sentiment=="Neutral") %>% select(Sentiment, Translated_Review, App)
neuFreq = occurence(neu$Translated_Review)
neuFreq %>% arrange(desc(Freq)) %>% top_n(10)





