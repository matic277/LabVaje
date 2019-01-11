library(dplyr)

data = read.csv("Master.csv")

# number of players by birthyear
data %>% select(birthYear) %>% group_by(birthYear) %>% summary(no=n())

#number of player per birthCountry (asc)
# n is a counting function
data %>% select(birthCountry) %>% group_by(birthCountry) %>% summarise(number=n()) %>% arrange((number))

#average weight in kg per birthCountry (desc)
data %>% select(weight, birthCountry) %>% group_by(birthCountry) %>% 
  summarise(averagew=mean(weight/2.2, na.rw=TRUE)) %>% arrange(desc(averagew))

# vse drzave samo na S, isti pogoji kot zgoraj
# spread prikaze stolpce kot vrstice
data %>% select(weight, birthCountry, birthYear) %>%
  group_by(birthCountry, birthYear) %>% 
  summarise(averagew=mean(weight/2.2, na.rw=TRUE)) %>%
  arrange(desc(averagew)) %>%
  filter(substr(birthCountry, 1, 1)=="S" & birthYear>1900) %>%
  spread(birthCountry, averagew)


# reading xlsx file
path = getwd()
name = "norway_new_car_sales_by_model.xlsx"
fullPath = paste(path, "/", name, sep="")

data = readxl::read_xlsx(fullPath)

# show the number of sold cars by manufacturer (rows) and years(columns)
data %>% select(Manufacturer, Quantity, Year) %>%
  group_by(Manufacturer, Year) %>%
  summarise(number=sum(Quantity)) %>%
  spread(Year, number)



