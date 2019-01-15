# 3 naloga
movies = data.frame(
  author = c("JJ Abrams", "C Nolan", "R Scott"),
  year = c(1980, 1979, 1999),
  name = c("Interstellar", "The Dark Knight", "It")
)

extraMovie = c("NewName", 1900, "SomeMovie")
names(extraMovie) = c("author", "year", "name")

names(movies)
names(extraMovie)

rbind(movies, extraMovie)


# 4 naloga
Install.packages("tibble")
library("tibble")

# creating a new tibble (with data_frame)
friends_data = data_frame(
  name = c("Nicolas", "Thierry", "Bernard", "Jerome"),
  age = c(27, 25, 29, 26),
  height = c(180, 170, 185, 169),
  married = c(TRUE, FALSE, TRUE, TRUE)
)
friends_data

# creating tibble from an existing object with as_tibble()
# or with tibble()
as_tibble(iris)
tibble(x=1:5, y=1, z=x^2+y)

# converting iris dataframe to tibble
data("iris")
class(iris)
data = as_data_frame(iris)
class(data)
data

# creating tibble object
data = tibble(
  "(:" = "smile",
  " " = "space",
  "2000" = "number"
)
data

data = tribble(
  ~x, ~y, ~z,
  "a", 2, 3.6,
  "b", 1, 8.5
)
data

library(lubridate)
data = tibble(
  a = lubridate::now() + runif(1e3)*86400,
  b = lubridate::today() + runif(1e3)*30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace=TRUE)
)
data


install.packages("magrittr")
library(magrittr)
data = tibble(
  x = runif(5),
  y = rnorm(5)
)
data

data %>% .$x
