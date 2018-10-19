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

