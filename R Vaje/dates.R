install.packages("lubridate")

lubridate::today()
lubridate::now()

d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014

lubridate::mdy(d1)
lubridate::ymd(d2)
lubridate::dmy(d3)
lubridate::mdy(d4)
lubridate::mdy(d5)

# kateri dan je na tisti datum, label omogoca prikaz imena dneva, namesto stevilke
# parameter abbr skrajsa ali podaljsa ta imena, npr: Mon -> Monday
lubridate::wday(lubridate::mdy(d5), label = TRUE, abbr = TRUE)

# diff
my_age = lubridate::today()-lubridate::ymd("1995-2-1")

lubridate::as.duration(my_age)
