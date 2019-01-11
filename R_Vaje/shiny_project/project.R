library("rio")
library("dplyr")
library("ggplot2")


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

# fix sizes to megabytes, 'Varies with device' = -1
convertSize <- function(d) {
  if (endsWith(d, "k")) return(as.numeric(substr(d, 1, nchar(d)-1)) / 1000)
  else if (endsWith(d, "M")) return(as.numeric(substr(d, 1, nchar(d)-1)))
  else return(-1)
}

data = data %>% mutate("eSize"=convertSize(Size))
data[is.na(data)] <- -1 # replace NA values with -1, because function doest work for some reason


# remove a row that has Price value as NaN
data = data[!(data$Type==NaN), ]


# fix Install values to int
convertInstalls <- function(d) {
  d = gsub("\\+", "", gsub(",", "", d))
  return(as.numeric(d, options(scipen = 999)))
}

data = data %>% mutate("eInstalls"=convertInstalls(Installs))

data %>% select(eInstalls, ePrice) %>% group_by(eInstalls) %>% summarise(mean(ePrice)) %>% arrange(desc(nchar(eInstalls)))
