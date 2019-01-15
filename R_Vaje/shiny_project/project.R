install.packages("stringi")
install.packages("stringr")

install.packages("ggplot2")
install.packages("rio")
install.packages("dplyr")
install.packages("lazyeval")

install.packages("tm")
install.packages("wordcloud")
install.packages("RColorBrewer")
install.packages("ggThemeAssist")

library("ggThemeAssist")
library("tm")
library("wordcloud")
library("RColorBrewer")

library("rio")
library("dplyr")
library("ggplot2")

library("stringi")
library("stringr")
library("lazyeval")


sourceDir = "C:/git/LabVaje/R_Vaje/shiny_project/data_resources/"
sourceDir = "C:/git/SQL-R/LabVaje/R_Vaje/shiny_project/data_resources/"

RawDataPath = paste(sourceDir, "googleplaystore.csv", sep="")
RawReviewsPath = paste(sourceDir, "googleplaystore_user_reviews.csv", sep="")

ProcessedDataPath = paste(sourceDir, "processedData.csv", sep="")
ProcessedReviewsPath = paste(sourceDir, "processedReviews.csv", sep="")

# raw data apps
rdata = rio::import(file=RawDataPath, format="csv")
# processed data apps
data = rio::import(file=ProcessedDataPath, format="csv")

# raw reviews
rrvs = rio::import(file=RawReviewsPath, format="csv")
# processed reviews
rvs = rio::import(file=ProcessedReviewsPath, format="csv")


covertPrice <- function(d) {
  ifelse (startsWith(d, "$"), as.numeric(substr(d, 2, nchar(d))), as.numeric(d))
}

# fix prices to integers
data = data %>% mutate("ePrice"=covertPrice(Price))

# 0 rows should be NA, function throws warning for NA values (coerson), but no values end up as NA
# data %>% select(Price, ePrice) %>% filter(is.na(ePrice))

# fix sizes to megabytes, 'Varies with device' = -1
convertSize <- function(d) {
  if (endsWith(d, "k")) return(as.numeric(substr(d, 1, nchar(d)-1)) / 1000)
  else if (endsWith(d, "M")) return(as.numeric(substr(d, 1, nchar(d)-1)))
  else return(-1)
}

data = data %>% mutate("eSize"=convertSize(Size))

# replace NA values with -1, because function doest work for some reason
data = data %>% mutate(eSize = if_else(is.na(eSize), -1, eSize)) 

# remove a row that has Price value as NaN
data = data[!(data$Type==NaN), ]

# fix Install values to int
convertInstalls <- function(d) {
  d = gsub("\\+", "", gsub(",", "", d))
  return(as.numeric(d, options(scipen = 999)))
}

data = data %>% mutate("eInstalls"=convertInstalls(Installs))












# IDEJA
# najbolj popularne apliakcije glede na kategorijo

# select only those that have multiple (two) genres
extra = data %>% filter(grepl(";", Genres))
extra

# create new columns, extra1 and extra2
# now each app in this dataframe has two genres
extra = extra %>% rowwise() %>% mutate(Genres1=strsplit(Genres, ";")[[1]][1], Genres2=strsplit(Genres, ";")[[1]][2])

#extra1 %>% select(Genres1, Genres2) %>% group_by(Genres1) %>% summarise(max(Genres2)) %>% arrange(desc(Genres1))

# two new dataframes
# genre1 has apps that contain only the extra Genre1 column, similar for genre2
genre1 = extra[ , !names(extra) %in% c("Genres2", "Genres")]
genre2 = extra[ , !names(extra) %in% c("Genres1", "Genres")]

# combining data and genres dataframe
# from original data, select only apps that dont have multiple (two) genres
# then combine that with genre1 and genre2
# ! before combining, rename the columns in genre1 and genre2:; Genres(1/2) -> Genres
colnames(genre1)[colnames(genre1)=="Genres1"] <- "Genres"
colnames(genre2)[colnames(genre2)=="Genres2"] <- "Genres"

single = data %>% filter(!grepl(";", Genres))

combined = rbind(single, genre1, genre2)

as.data.frame(data)
# tibble::as.tibble(single)
# tibble::as.tibble(genre1)
# tibble::as.tibble(genre2)
# tibble::as.tibble(combined)

# RESULT
r = combined %>% select(Genres, eInstalls) %>% group_by(Genres) %>% summarise("sum"=sum(eInstalls)) %>% arrange(desc(sum))
tibble::as.tibble(r)

ggplot(r, aes(x="", y=sum, fill=Genres)) + geom_bar(stat="identity", width=1) + coord_polar("y", start=0)



# IDEA
# group by app name length, order by installs

# separate apps names and descriptions (???)
# app names only are stored in App2 column

# separators: appname <separator> description
separators = c(" | ", " - ", ": ", " : ", ":", " – ", "–", " (", " -- ")

separateName <- function(s) {
  sep = stri_detect_fixed(s, separators)
  sum = sum(stri_detect_fixed(s, separators))
  isSplittable = ifelse(sum>0, TRUE, FALSE)
  
  ifelse (isSplittable==TRUE, strsplit(s, separators[sep], fixed=TRUE)[[1]][1], s)
}

data = data %>% rowwise() %>% mutate("App2"=separateName(App))


# add a new column, NameLenRange
# NameLenRange will have values 2,4,6,8,...
# if an App2 string length is 3, it falls into category 2 for NameLenRange

nameRange <- function(s) {
  l = nchar(s)
  ifelse (l%%2==0, l, l-1)
}

data = data %>% rowwise() %>% mutate("NameRangeLen"=nchar(App2))

r = data %>% select(NameRangeLen, eInstalls) %>% group_by(eInstalls) %>% summarise("sum"=mean(NameRangeLen)) %>% arrange(desc(eInstalls))
r


# IDEA
# add a column that adds how much money an app made
data = data %>% mutate("Sales"=(ePrice * eInstalls))



# IDEA
# rating and reviews
data %>% select(Rating, Reviews) %>% group_by(Rating) %>% summarise(sum(Reviews)) %>% arrange(desc(Rating))

data %>% select(Rating) %>% rowwise() %>% mutate("len"=nchar(as.character(Rating))) %>% arrange(desc(len)) 

r = data %>% rowwise() %>% mutate("RatingGroup"=round(Rating))
r %>% select(RatingGroup) %>% filter(is.na(RatingGroup))

d = r %>% select(RatingGroup, Reviews) %>% group_by(RatingGroup) %>% na.omit() %>% summarise("sum"=sum(as.numeric(Reviews))) %>% arrange(desc(RatingGroup))
d

ggplot(d, aes(x=factor(RatingGroup), y=sum)) + geom_bar(stat="identity")






# IDEA
# category and reviews
data %>% select(Category, Reviews) %>% group_by(Category) %>% summarise("sum"=sum(Reviews)) %>% arrange(desc(sum))

# IDEA
# get n app names that have the most installs
n = 5
get_top_n <- function(d, n) {
  str = ""
  i = 0
  for (e in d) {
    str = paste(str, e, sep=", ")
    i = i + 1
    if (i == n) break
  }
  return(str)
}

data %>% select(App2, eInstalls) %>% group_by(eInstalls) %>% summarise(get_top_n(App2, n)) %>% arrange(desc(eInstalls))



# IDEA +++
# count how many apps there are per group of installs
d = data %>% select(eInstalls) %>% group_by(eInstalls) %>% summarise("num"=n()) %>% arrange(desc(eInstalls))
d
ggplot(d, aes(x=factor(eInstalls), y=num)) + geom_bar(stat="identity", fill="green") + coord_flip() + theme(plot.subtitle = element_text(vjust = 1), 
    plot.caption = element_text(vjust = 1), 
    axis.line = element_line(colour = "gray59", 
        linetype = "solid"), axis.ticks = element_line(colour = "gray15"), 
    panel.grid.major = element_line(colour = "gray77"), 
    panel.grid.minor = element_line(colour = NA, 
        linetype = "blank"), axis.title = element_text(size = 12), 
    axis.text = element_text(size = 12, vjust = 0.4), 
    axis.text.x = element_text(size = 12), 
    axis.text.y = element_text(size = 12), 
    plot.title = element_text(size = 15, 
        hjust = 0.5), panel.background = element_rect(fill = NA)) +labs(title = "Number of apps per installations", 
    x = "Numer of installs", y = "Number of apps")


# IDEA +++
# number of installs based on content rating and price
d = data %>% select(`Content Rating`, eInstalls) %>% group_by(`Content Rating`) %>% summarise("num"=n()) %>% arrange(desc(num))
d
ggplot(d, aes(x=`Content Rating`, y=num)) + geom_bar(stat="identity") + 
  theme(plot.subtitle = element_text(vjust = 1), 
  plot.caption = element_text(vjust = 1), 
  axis.line = element_line(colour = "gray59", 
                           linetype = "solid"), axis.ticks = element_line(colour = "gray15"), 
  panel.grid.major = element_line(colour = "gray77"), 
  panel.grid.minor = element_line(colour = NA, 
                                  linetype = "blank"), axis.title = element_text(size = 12), 
  axis.text = element_text(size = 12, vjust = 0.4), 
  axis.text.x = element_text(size = 12), 
  axis.text.y = element_text(size = 12), 
  plot.title = element_text(size = 15, 
                            hjust = 0.5), panel.background = element_rect(fill = NA)) +
  labs(title = "Number of apps installed per category", 
    x = "Category", y = "Number of apps")




d = data %>% select(Price) %>% group_by(Price) %>% summarise("num"=n()) %>% arrange(desc(num))

ggplot(d, aes(x=Price, y=num)) + geom_bar(stat="identity")




max = max(data$ePrice)
max

data %>% select(App, App2, ePrice, eInstalls) %>% filter(ePrice>300)


# IDEA !!!
# see which apps made most money
data %>% select(App, App2, Sales) %>% group_by(App) %>% summarise("App2"=max(App2), "Sales"=max(Sales), "SalesOut"=formatC(Sales, format="f", big.mark=",", digits=0)) %>% arrange(desc(Sales))

# formatC(1000.64, format="f", big.mark=",", digits=0)


# IDEA !!!
# see which category made most money
d = data %>% select(Category, Sales) %>% group_by(Category) %>% summarise("sum"=sum(Sales), "count"=n()) %>% arrange(desc(sum))

ggplot(d, aes(x=factor(Category), y=sum)) + geom_bar(stat="identity") + coord_flip()


# IDEA !!!
# most frequent words in apps
d = occurences(data$App2) %>% top_n(300)

wordcloud::wordcloud(words = d$Word, freq = d$Freq, min.freq = 1,
          max.words=300, random.order=FALSE, rot.per=0.0, 
          colors=brewer.pal(8, "Set1"))




############### REVIEWS #############
#####################################
# using reviews
rvs = rio::import(file="C:/git/LabVaje/R_Vaje/shiny_project/data_resources/googleplaystore_user_reviews.csv", format="csv")

rvs = rvs %>% filter(!(Sentiment=="nan" | Translated_Review=="nan"))

# processed user reviews
rvs = rio::import(file=ProcessedReviewsPath, format="csv")








# IDEA !!!
# most frequest words in positive and negative reviews
neg = rvs %>% filter(Sentiment=="Negative") %>% select(Sentiment, Translated_Review, App)
neu = rvs %>% filter(Sentiment=="Neutral") %>% select(Sentiment, Translated_Review, App)
pos = rvs %>% filter(Sentiment=="Positive") %>% select(Sentiment, Translated_Review, App)

occurences <- function(d) {
  allWords = c("")
  for (e in d) {
    split = str_split(e, " ")[[1]]
    allWords = combine(allWords, split)
  }
  # get a pair of word - num_of_occurrences and put it in a dataframe
  df = as.data.frame(table(allWords))
  colnames(df) = c("Word", "Freq")
  return(df %>% arrange(desc(Freq)))
}

negFreq = occurences(neg$Translated_Review)
negFreq %>% top_n(50)

wordcloud::wordcloud(words = negFreq$Word, freq = negFreq$Freq, min.freq = 1,
                     max.words=50, random.order=FALSE, rot.per=0.0, 
                     colors=brewer.pal(8, "Set1"))

neuFreq = occurences(neu$Translated_Review)
neuFreq %>% top_n(50)

posFreq = occurences(pos$Translated_Review)
posFreq %>% top_n(50)
  
tibble::as.tibble(rvs)

s = selectTopNWords(negFreq, 5)
s



# IDEA !!!
# does review length effect positivity or negativity?

# new column Length
rvs = rvs %>% mutate("Length"=nchar(Translated_Review))

d = rvs %>% select(Sentiment, Length) %>% group_by(Sentiment) %>% summarise("avg"=mean(Length))
d
ggplot(d, aes(x=Sentiment, y=avg, fill=Sentiment)) +
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("#CC0000", "#e0e0e0", "#00C851")) +
  geom_hline(yintercept=mean(d$avg), col="blue") + theme(plot.subtitle = element_text(vjust = 1), 
    plot.caption = element_text(vjust = 1), 
    panel.grid.major = element_line(colour = "gray83"), 
    panel.grid.minor = element_line(colour = "snow3"), 
    panel.background = element_rect(fill = NA)) +labs(y = "Average length")

# JOIN
joined = left_join(data, rvs)
joined = joined %>% filter(!is.na(Sentiment))
tibble::as.tibble(joined)


# IDEA !!!
# using joined
# group by installs, and see how many neg, pos, neu reviews
d = joined %>% select(Category, Sentiment) %>% group_by(Category, Sentiment) %>% summarise("count"=n()) %>% arrange(desc(count))
d


plot = ggplot(data=d, aes(x=factor(Category), y=count, fill=Sentiment)) + 
  geom_bar(stat="identity") + coord_flip() +
  scale_fill_manual("legend", values=c("Positive"="#00C851", "Neutral"="#e0e0e0", "Negative" = "#CC0000")) +
  ylab("Number of reviews") + xlab("Number of installs") + theme(plot.subtitle = element_text(vjust = 1), 
    plot.caption = element_text(vjust = 1), 
    panel.grid.major = element_line(colour = "lavender"), 
    panel.grid.minor = element_line(linetype = "blank"), 
    axis.text = element_text(size = 11), 
    axis.text.y = element_text(size = 9, 
        vjust = 0.3), plot.title = element_text(size = 10, 
        hjust = 0.5), legend.text = element_text(size = 12), 
    legend.title = element_text(size = 13), 
    panel.background = element_rect(fill = NA, 
        linetype = "twodash"), legend.background = element_rect(fill = NA)) +labs(title = "Reviews and Installs")

plot






# IDEA !!!
# function that gets a string
# returns rows for apps contain that str in their name
# ! needs lazyeval libary to run
getAppsByName <- function(d, n) {
  print(paste("Searching for apps that contain:", n, sep=" "))
  return(d %>% filter(grepl(n, d$App)))
}

getAppsByName(data, "Google")
data


# IDEA !!!
# get all apps that have a rating
# in range of input, two doubles
getAppsByRating <- function(d, n1, n2) {
  print(paste("Searching for apps in range: [", n1, " ", n2, "]", sep=""))
  return(d %>% filter(d$Rating>=n1 & d$Rating<=n2))
}

getAppsByRating(data, 4.4, 4.5)



# IDEA !!!
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

data %>% select(App2, eInstalls) %>% group_by(eInstalls) %>% summarise("TopWords"=selectTopNWords(occurences(App2), 3))



# IDEA !!!!
# name length and installs
require(scales)
r = data %>% select(NameRangeLen, eInstalls) %>% group_by(eInstalls) %>% summarise("len"=mean(NameRangeLen)) %>% arrange(desc(eInstalls))

print(r)

r$eInstalls <- factor(r$eInstalls, levels = r$eInstalls[order(r$len, decreasing = TRUE)])

ggplot(r, aes(x=eInstalls, y=len, group=1)) + geom_line(colour="red") + geom_point(colour="black", size=0.5) + theme(plot.subtitle = element_text(vjust = 1), 
    plot.caption = element_text(vjust = 1), 
    panel.grid.major = element_line(colour = "gray88", 
        linetype = "blank"), panel.grid.minor = element_line(colour = "lightsteelblue"), 
    axis.title = element_text(size = 13), 
    plot.title = element_text(size = 15, 
        hjust = 0.5), panel.background = element_rect(fill = NA)) +labs(title = "App name length and installs") + 
  scale_x_continuous(labels = comma)+labs(x = "Number of installs", y = "Length of name")

tibble::as.tibble(data)


# !!! boxplot

ggplot(data, aes(x=factor(eInstalls), y=NameRangeLen)) + 
  geom_boxplot(fill='#56B4E9', color="black") + coord_flip() + theme(plot.subtitle = element_text(vjust = 1), 
    plot.caption = element_text(vjust = 1), 
    panel.grid.major = element_line(colour = "gray75"), 
    axis.title = element_text(size = 12), 
    axis.text.x = element_text(size = 12, 
        vjust = 0), axis.text.y = element_text(vjust = 0.4), 
    plot.title = element_text(size = 14, 
        hjust = 0.5), panel.background = element_rect(fill = NA)) +labs(title = "Number of installs and app name length", 
    x = "Number of installs", y = "Length of app name")










#########################
# GRAPHS
#########################
backup2 = data

# see how total sales and price correlate
ggplot(data, aes(x=ePrice, y=Sales)) + geom_point() #geom_bar(stat="identity")




# see how price and installs correlate
d1 = data %>% select(eInstalls, ePrice) %>% group_by(eInstalls) %>% summarise(avg=mean(ePrice)) %>% arrange(desc(eInstalls))
d1

d1 = data %>% select(eInstalls, ePrice)

ggplot(d1, aes(x=factor(eInstalls), y=avg, fill=avg)) + geom_bar(stat="identity") + coord_flip()

ggplot(d1, aes(x=factor(eInstalls), y=ePrice)) + geom_boxplot()


# see average prices based on categories
d1 = data %>% select(Category, ePrice) %>% group_by(Category) %>% summarise(avg=mean(ePrice)) %>% arrange(desc(avg))
d1

ggplot(d1, aes(y=avg, x=Category)) + 
  geom_bar(stat="identity") +
  geom_hline(yintercept=mean(d1$avg), col="red") + 
  geom_text(aes(-1,1,label = 1.8, vjust = -1)) +
  coord_flip() +
  ggtitle("Price by Category") + 
  ylab("Average Price") + xlab("Category")


# group by installs, and see how many neg, pos, neu reviews
d2 = joined %>% select(eInstalls, Sentiment) %>% group_by(eInstalls, Sentiment) %>% summarise("sum"=n()) %>% arrange(desc(eInstalls))
d2

ggplot(data=d2, aes(x=factor(eInstalls), y=sum, fill=Sentiment)) + 
  geom_bar(stat="identity") +
  scale_fill_manual("legend", values=c("Positive"="#00C851", "Neutral"="#e0e0e0", "Negative" = "#CC0000")) +
  ylab("Number of reviews") + xlab("Number of installs")



rio::export(data, "processedData.csv")
rio::export(rvs, "processedReviews.csv")

tibble::as.tibble(rvs)

