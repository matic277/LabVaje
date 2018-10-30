install.packages("stringr")
library("stringr")

# concatenating strings with stringr
glued = stringr::str_c("con", "cat")
glued2 = stringr::str_c("con", "cat", sep = "-")
glued
glued2

# counting chars
# stringr::str_length can count factors, ncar CAN'T !!
stringr:::str_length(c("chars", "cars"))
nchar(c("333", "1", "22"))

# substrings
# vzame characterje iz prvega do cetrtega mesta, za obe besedi
str_sub(c("Beseda", "avtomobil"), 1, 4)
str_sub(c("Beseda", "avtomobil"), -4, -1)

# matching, iskanje substringov v stringih
words = c("cheese", "pepperoni", "sausage and green peppers")
str_detect(words, pattern = "pepper")

# vrne stringe ki vsebujejo pattern substring
str_subset(words, pattern = "pepper")

# stetje substringov v naboru stringov
str_count(words, pattern = "e")

# datumi
dates = c("11.11.2018 - 01.01.2011", "23.21.2012 - 17.07.2007")
split_dates = str_split(dates, pattern = " - ")
split_dates
class(split_dates[[2]][[2]])

# replacing
# replacing all 3 characters with character 2
string = "12345"
str_replace_all(string, "3", "2")



# VAJE

# abbriviating: Surname Name -> S. Name
names = c("Sophia Abbe", "Olivia Abbett", "Emma Abbey", "Ava Abbitt", "Isabella Abbot",
          "Mia Abbott", "Aria Abbs", "Riley Abby", "Zoe Abdon", "Amelia Able", "Layla Abner",
          "Charlotte Abney", "Aubrey Aborn", "Lily Abrahams", "Chloe Abram", "Harper Abram",
          "Evelyn Ace", "Adalyn Acey", "Emily Acker", "Abigail Ackerley", "Madison Ackerly",
          "Aaliyah Ackerman", "Avery Ackers", "Ella Ackert", "Scarlett Ackland", "Maya Ackland",
          "Mila Ackley", "Nora Acklin", "Camilla Ackroyd", "Arianna Acock", "Eliana Acomb",
          "Hannah Acomb", "Leah Acors", "Ellie Acre", "Kaylee Acreman", "Kinsley Acres",
          "Hailey Acton", "Madelyn Acuff", "Paisley Acy", "Elizabeth Adams", "Addison Adcock",
          "Isabelle Adcox", "Anna Addams", "Sarah Adderley", "Brooklyn Adderly", "Mackenzie Addicott",
          "Victoria Addington", "Luna Addy", "Penelope Ade", "Grace Ades")

# naloga 1, 2
split = str_split(names, " ", simplify = TRUE)
split
str_c(str_sub(split[ , 1], 1, 1), ". ", split[, 2])

# naloga 3
surnames = split[, 2]
names_ends = str_sub(surnames, -1, -1)
names_ends

sum(str_count(names_ends, pattern = str_c("a", "h", "s", "e", sep="|")))


