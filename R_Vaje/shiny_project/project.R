install.packages("stringi")
install.packages("stringr")

library("rio")
library("dplyr")
library("ggplot2")

library("stringi")
library("stringr")


sourceDir = "C:/git/LabVaje/R_Vaje/data_resources/"
fileName1 = "googleplaystore.csv"
fileName2 = "googleplaystore_user_reviews.csv"

filePath1 = paste(sourceDir, fileName1, sep="");
filePath2 = paste(sourceDir, fileName2, sep="");

data = rio::import(file=filePath1, format="csv")

colnames(data)

tibble::as.tibble(data)




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


data %>% select(Category, eSize)

data %>% select(Size, eSize)



# remove a row that has Price value as NaN
data = data[!(data$Type==NaN), ]


# fix Install values to int
convertInstalls <- function(d) {
  d = gsub("\\+", "", gsub(",", "", d))
  return(as.numeric(d, options(scipen = 999)))
}

data = data %>% mutate("eInstalls"=convertInstalls(Installs))


## backup data so far
backup = data

# data = backup


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


# tibble::as.tibble(single)
# tibble::as.tibble(genre1)
# tibble::as.tibble(genre2)
# tibble::as.tibble(combined)

# RESULT
r = combined %>% select(Genres, eInstalls) %>% group_by(Genres) %>% summarise("sum"=sum(eInstalls)) %>% arrange(desc(sum))
tibble::as.tibble(r)


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

data = data %>% rowwise() %>% mutate("NameRangeLen"=nameRange(App2))

r = data %>% select(NameRangeLen, eInstalls) %>% group_by(NameRangeLen) %>% summarise("sum"=sum(eInstalls)) %>% arrange(desc(sum))
r


# IDEA
# add a column that adds how much money an app made
data = data %>% mutate("Sales"=(ePrice * eInstalls))



# IDEA
# rating and reviews
data %>% select(Rating, Reviews) %>% group_by(Rating) %>% summarise(sum(Reviews)) %>% arrange(desc(Rating))

# IDEA
# category and reviews
data %>% select(Category, Reviews) %>% group_by(Category) %>% summarise("sum"=sum(Reviews)) %>% arrange(desc(sum)) %>% View()

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


# IDEA
# count how many apps there are per group of installs
data %>% select(eInstalls) %>% group_by(eInstalls) %>% summarise("num"=n()) %>% arrange(desc(eInstalls))

# IDEA
# number of installs based on content rating and price
data %>% select(`Content Rating`, eInstalls) %>% group_by(`Content Rating`) %>% summarise("num"=n()) %>% arrange(desc(num))

data %>% select(Price) %>% group_by(Price) %>% summarise("num"=n()) %>% arrange(desc(num))

max = max(data$ePrice)
max

data %>% select(App, App2, ePrice, eInstalls) %>% filter(ePrice>300)


# IDEA
# see which apps made most money
data %>% select(App, App2, Sales) %>% arrange(desc(Sales))


# IDEA
# see which category made most money
data %>% select(Category, Sales) %>% group_by(Category) %>% summarise("sum"=sum(Sales)) %>% arrange(desc(sum))



#########################
# GRAPHS
#########################
backup2 = data

# see how total sales and price correlate
ggplot(data, aes(x=ePrice, y=Sales)) + geom_point() #geom_bar(stat="identity")


# see how price and installs correlate
d1 = data %>% select(eInstalls, ePrice) %>% group_by(eInstalls) %>% summarise(sum=sum(ePrice)) %>% arrange(desc(eInstalls))

ggplot(d1, aes(y=eInstalls, x=sum)) + geom_bar(stat="identity") #geom_bar(stat="identity")
 
d1


# see average prices based on categories
d1 = data %>% select(Category, ePrice) %>% group_by(Category) %>% summarise(avg=mean(ePrice)) %>% arrange(desc(avg))
d1
ggplot(d1, aes(y=Category, x=factor(avg))) + geom_bar(stat="identity") #geom_bar(stat="identity")




rio::export(data, "processedData.csv")
class(data$ePrice)
test = rio::import(file="C:/Users/V2/Documents/processedData.csv", format="csv")

