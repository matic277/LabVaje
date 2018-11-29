

v = iris$Sepal.Length
v[v > 6]

# Lists
mylist<-list(x=c(1,5,7), y=c(4,2,6), z=c(0,3,4))
mylist
str(mylist)

mylist[2]
mylist[[2]][[3]]

# Matrices and arrays
a <- matrix(1:9, nrow = 3)
a
colnames(a) <- c("A", "B", "C")
a

r = a[1:2, 3]
r
class(r)

r = a[1:2, 3, drop=FALSE]
r
class(r)

# Dataframes
data = cars
head(data)
cars[ , 2] # or cars[, "dist"]; cars$dist

data = airquality
colnames(airquality)
airquality[ ,c(1,3,5)]

data = cars
data[1:10, ] # first 10 rows
data[data$speed==4] # where speed == 4

head(data[data$speed==4], 10) # where speed == 4, but print first 10 only

# 10mph or higher, print distance only (drop=FALE doesnt simplify output to vector,
# but keeps it as datafram)
data[data$speed > 10, c(2), drop=FALSE]

# speed is bigger than 5 and distance is atleast 7
data[data$speed > 5 & data$dist > 7, , drop=FALSE]



library(tibble)
data = airquality
df = as.tibble(airquality[airquality$Temp>75 & airquality$Wind>12, c(1,5)])
df
na.omit(df) # skip all rows with NULL values

library(PerformanceAnalytics)
head(airquality)
df = airquality[ , 1:4]

chart.Correlation(df, histogram=TRUE, pch="+")

summary(df)
