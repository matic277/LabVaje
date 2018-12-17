data(beavers)
head(beaver1)

beaver1

# apply

# loops by rows, takes the minimum of each column
# param 1 is looping throu rows, 2 by columns
apply(beaver1, 2, min)

# average of each column
apply(beaver1, 2, mean)

data(airquality)

# average of airquality columns (with annonymous function)
apply(airquality, 2, function(x){ mean(x, na.rm=TRUE) })


# lappy
l = list(a=1:10, b=1:100)
l

# avg of 'a' and 'b'
lapply(l, mean)

# sum of 'a' and 'b'
lapply(l, sum)


# sapply
newl = sapply(l, mean)
class(newl)

onlyB = lapply(l['b'], mean)
onlyB


# tapply

# group-by cyl, then calculate the average for mpg
tapply(mtcars$mpg, mtcars$cyl, mean)

# average temperature by month
d = airquality
tapply(d$Temp, d$Month, mean)


# EXERCISES

# Excercise 1
# a. Get the following matrix of 5 rows and call it 'mymatrix':
#   mymatrix = matrix(data = c(6,34,923,5,0, 112:116, 5,9,34,76,2, 545:549), nrow = 5)
# 
# b. Get the mean of each row
#
# c. Get the mean of each column
# 
# #expected result

# a
mymatrix = matrix(data = c(6,34,923,5,0, 112:116, 5,9,34,76,2, 545:549), nrow = 5)

# b
apply(mymatrix, 1, mean)

# c
apply(mymatrix, 2, mean)



# Excercise 2
# Use 'lapply' on a data.frame 'mtcars'
# 
# a. Use three 'apply' family functions to get the minimum values of each column of the 'mtcars' dataset.
# Store each output in a separate object ('l', 's', 'm') and get the outputs.
#
# b. Put the three outputs 'l', 's', 'm' in the list 'listobjects'.
# 
# c. Use a suitable 'apply' function to get the class of each of the three list elements in 'listobjects'

# a
d = mtcars
l = lapply(d, min)
s = sapply(d, min)
m = mapply(min, d)

# b
list = list("l"=l, "s"=s, "m"=m)

# c
classes = lapply(list, class)
classes

# Excercise 3
# Titanic Casualties - Use the standard 'Titanic' dataset which is part of R Base
# 
# a. Use an appropriate apply function to get the sum of males vs females aboard
# 
# b. Get a table with the sum of survivors vs sex.
# 
# c. Get a table with the sum of passengers by sex vs age.

d = as.data.frame(Titanic)
d
class(d)
str(d)

# a
tapply(d$Freq, d$Sex, sum)

# b
d
tapply(d$Freq, d[ ,c(2,4)], sum)

# c
tapply(d$Freq, d[ ,c(2,3)], sum)


# Excercise 4
# Using the 'apply' family to work with classes of data.frames
# 
# a. Find out which column of iris is not numeric.
# 
# b. Identify the levels of the non-numeric column (hint: 'levels' function).

d = iris
class(d$Sepal.Length)

# a
lapply(d, is.numeric)

# b
sapply(d[, !sapply(iris, is.numeric), drop=FALSE], levels)








