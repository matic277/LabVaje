library(tidyr)

data = read.table(textConnection("1|a,b,c\n2|a,c\n3|b,d\n4|e,f"), header=F, sep="|", stringsAsFactor=F)
print(data)

# unnesting, spliting rows by ','
data %>% unnest(strsplit(V2, ","))


# user defined functions
# dodajanje novega stolpca TempC ki pretvoti Franheit enote iz stolpca Temp
fTOc <- function(x) { round((x-32)*5/9,0) }
airquality %>% mutate(TempC=fTOc(Temp)) %>% head()


data = as.data.frame(Titanic)

# WRITE A FUNCTION:
# - if a person was a child and didn't survive, the function should return "Poor child"
# - if a person was a woman and didn't survive, the function should return "Oh no"
# - if a person was an adult man and did survive, the function should return
#   "You shouldn't save you if there were still women and children aboard"

fun = function(sex, age, survived) {
  if (age == "Child" && survived == "No")
    return("Poor child")
  else if (sex == "Male" && age == "Adult" && survived == "Yes")
    return("You shouldn't save you if there were still women and children aboard")
  else if (age == "Adult" && sex == "Female" && survived == "No")
    return("Oh no")
  else 
    return("Its ok")
}

data %>% rowwise() %>% mutate_if(is.factor, as.character()) %>% 
  mutate(output=fun(Sex, Age, Survived))



# user defined functions are more
data = mtcars

convert = function(mpg) { return (235.214583 / mpg) }

# write a function which will tranform mpg to l/100 kms and assign values to a new column consumption
data %>% mutate(converted=convert(mpg))

# display mean and median for mpg, hp, consumption
data %>% mutate(converted=convert(mpg)) %>% summarise_at(vars(mpg, hp, converted), funs(mean, median), na.rm=TRUE)

# identify the worst and best economic car (use top_n function)
# best
data %>% mutate(converted=convert(mpg)) %>%
  top_n(-1, converted)

# worst
data %>% mutate(converted=convert(mpg)) %>%
  top_n(1, converted)


