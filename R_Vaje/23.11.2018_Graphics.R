library(tidyverse)

index = data.frame(year=2007:2016, pop=sample(10000:20000, size=10))

# tocke
plot (index$year, index$pop, type="histogram")

# povezane tocke
plot (index$year, index$pop, type="histogram")

# stolpci
plot (index$year, index$pop, type="lines")

# poimenovanje
plot(index$year,index$pop, type="l", main="Population by year",
     xlab="year",ylab="population")


# use mtcars dataset and create a line plot where
# cyl must be on x axis and mean mpg on y axis
data = mtcars
avg = data %>% select(mpg, cyl) %>%
  group_by(cyl) %>%
  summarise(mean=mean(mpg, na.rm=TRUE))

plot(x=avg$cyl, y=avg$mean, type="lines")


## LATTICE
install.packages("lattice")
library(lattice)

index$year = as.factor(index$year)
lattice::dotplot(year~pop, data=index, main="Pop by year", ylab="year", xlab="population")
#             x=year ~ y=pop

histogram(year~pop, data=index)

#use mtcars dataset and create a barchart
# of mean mpg for number of gears per cyl
data = mtcars %>% select(mpg, cyl, gear) %>%
  group_by(cyl, gear) %>%
  summarise(mean=mean(mpg, na.rm=TRUE))

barchart(mean~factor(gear) | factor(cyl), data=data)


## GGPLOT2
library(ggplot2)

# dodajanje lasnosti grafa z +
g = ggplot(index,aes(x=year,y=pop, group=1))+geom_line()
g = g + ggtitle("Population by year") + xlab("Year") + ylab("Population")
g

g = ggplot(data=mtcars, aes(x=as.factor(cyl), fill=factor(gear))) + 
  geom_bar() + 
  xlab("Num. of cyl") +
  ylab("") +
  labs(fill="Num. of gears")

install.packages("ggThemeAssist")
install.packages("ggthemes")

# number of cars per cylinder
data = mtcars %>%
  select(cyl) %>%
  group_by(cyl) %>%
  summarise(num=n())
  
data

ggplot(data, aes(x=as.factor(cyl), y=num)) + 
  geom_bar(stat="identity") +
  ylab("number of cars") +
  xlab("cyl")


