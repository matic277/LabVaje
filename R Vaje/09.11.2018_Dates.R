install.packages("lubridate")
library(lubridate)

currentL = Sys.getlocale()


# izpis celotnega imena trenutnega meseca v cescini
Sys.setlocale("LC_ALL", "Czech")
date = Sys.Date()

month(date, label=TRUE, abbr=FALSE)


# izpis celotnega imena trenutnega dneva v ruscini
Sys.setlocale("LC_ALL", "Russian")
date = Sys.Date()

wday(date, label=TRUE, abbr=FALSE)


# pretvorba v english
Sys.setlocale("LC_ALL", "English")

# converting
date = as.Date("08,30,1930", format="%m,%d,%Y")
date
date = as.Date("Aug30,1930", format="%b%d,%Y")
date
date = as.Date("3aug1930", format="%d%b%Y")
date




