# facet
# adding 1 or 2 additional variables
install.packages("plyr")
library(plyr)
library(ggplot2)
g = ggplot(airquality, aes(x=Ozone, y=Temp)) + geom_point()
g = g + ggtitle("Ozone vs. Temp") + facet_grid(Month~.)
g

# adding linear model (lm parameter in geom_smooth())
g + geom_smooth(method=lm, se=FALSE)

# chart Ozone vs Temp by Month, comverting to Celsius
g = ggplot(airquality, aes(x=Ozone, y=(5/9*(Temp-32)))) + geom_point()
g = g + ggtitle("Ozone vs. Temp") + facet_grid(Month~.)
g

# adding vertical & horizontal lines
# vertikalna seka x os na popvrecni vrednosti mpg
# horizontalna seka y os na popvrecni vrednosti wt
ggplot(data=mtcars, aes(x=mpg, y=wt)) + geom_point() + 
  geom_vline(xintercept=mean(mtcars$mpg), col="red") + 
  geom_hline(yintercept=mean(mtcars$wt), col="blue")

# create scatter chart "Ozone vs. Temp by months", where temperatures
# will be in Celsius
# add mean ozone and mean temp lines and interpet the results
ggplot(airquality, aes(x=Ozone, y=Temp)) +
  geom_point() +
  ggtitle("Ozone vs. Temp") +
  geom_vline(xintercept=mean(airquality$Ozone, na.rm=TRUE), color="Blue") +
  geom_hline(yintercept=mean(airquality$Temp), color="Red") +
  coord_flip()

# combinaton of geom_point() and geom_box()
ggplot(data=mtcars, aes(x=as.factor(cyl), y=wt*1000/2.205)) +
  geom_point() + 
  xlab("Number of cyl.") + 
  ylab("Weight") +
  geom_boxplot(outlier.color="red")

# use iris data set. Combine geom_point and box_plot to produce a chart 
# of Petal.Length for every Species. Identify outliers with blue color.
ggplot(data=iris, aes(x=Species, y=Petal.Length)) +
  geom_point() + 
  xlab("Species type") + 
  ylab("Petal length") +
  geom_boxplot(outlier.color="blue")

# extra grids
# combining charts side by side
install.packages("gridExtra")
library(gridExtra)

index = data.frame(year=2007:2016, pop=sample(10000:20000, size=10))

g = ggplot(airquality, aes(x=Ozone, y=Temp)) + geom_point()
g = g + ggtitle("Ozone vs. Temp")
y = ggplot(index, aes(x=year,y=pop, group=1)) + geom_line()
y = y + ggtitle("Population by year") + xlab("Year") + ylab("Population")

# combining charts g and y together
grid.arrange(g, y) # or grid.arrange(g, y, ncol=2)


# use Titanic dataset
# create two charts side by side
# first chart should have number of survived/dead passengers by age
# second chart should have number of survived/dead passengers by class
library(dplyr)
data = as.data.frame(Titanic)
data

data = data %>% select(Age, Survived, Freq) %>%
  group_by(Age, Survived) %>%
  mutate(Sum1=sum(Freq)) %>%
  top_n(1, Freq)
data


g1 = ggplot(data, aes(x=Age, y=Sum1, fill=Survived)) +
  geom_bar(stat="identity")
g1


data2 = as.data.frame(Titanic)
data2 = data2 %>% select(Class, Survived, Freq) %>%
  group_by(Class, Survived) %>%
  mutate(Sum2=sum(Freq)) %>%
  top_n(1, Freq)
data2


g2 = ggplot(data2, aes(x=Class, y=Sum2, fill=Survived)) +
  geom_bar(stat="identity")
g2

grid.arrange(g1, g2)
ggplot

