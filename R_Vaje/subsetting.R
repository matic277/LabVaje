# Exercise 1
mtcars = cars
mtcars[mtcars$mpg > 15, 1, drop=FALSE]

# Exercise 2
mtcars = cars
mtcars[mtcars$mpg > 21, , drop=FALSE]

# Exercise 3
mtcars = cars
mtcars[mtcars$cyl < 6 & mtcars$gear == 4, ]

# Exercise 4
mtcars = cars
mtcars
mtcars[mtcars$mpg > 21, 1:4]

# Exercise 5
d = airquality
head(d[d$Ozone > 28 | d$Temp > 70, ], 5)

# Exercise 6
d = airquality
head(d[d$Ozone > 28 & d$Temp > 70, c("Ozone", "Temp")], 5)

# Exercise 7
d = CO2
head(d[d$Treatment == "chilled" & d$uptake > 15, -4], 10)

# Exercise 8
d = airquality
d[d$Ozone > 100, c("Ozone", "Temp", "Month", "Day")]


# 30.10.2018 - vaje iz vaj
x = c(11, 30, 2)

# get second element
x[2]

# exclude the second element, return the rest
x[-2]

# get element "bob" (NA)
x["bob"]

# subset first and third element (same as x[-2])
x[c(TRUE, FALSE, TRUE)]

# set all values to something (11, 30, 2) -> (0, 0, 0)
x[] = 0

# set all elements but the second one to 0
x[-2] = 0

