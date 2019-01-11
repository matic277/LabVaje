# semi join
# duplicates are removed
# 1 2     1 2
# 1 2     2 2
# 2 2 ->  2 4
# 2 4
# 2 4

# anti join
# returns those who do not match
d1 <- data_frame(
  x = letters[1:3],
  y = LETTERS[1:3],
  a = rnorm(3)
)

d2 <- data_frame(
  x2 = letters[3:1],
  y2 = LETTERS[3:1],
  b = rnorm(3)
)

d1
d2
left_join(d1, d2, by = c("x" = "x2", "y" = "y2"))


#######


library("rio")
people = rio::import(file = "baseballdatabank-master/core/People.csv", format = "csv")
fielding = rio::import(file = "baseballdatabank-master/core/FieldingOF.csv", format = "csv")

# Display the name (firstname+lastname) of the player who had the second highest number of games
# played in center field for each year from 1990 to 2000 (hint: explore slice() function)
head(fielding)
head(people)

people %>% inner_join(fielding, by=c("playerID"="playerID")) %>%
  mutate_if(is.factor, as.character) %>%
  select(nameGiven, yearID, Gcf) %>%
  filter(yearID>=1900 & yearID<=1910 & Gcf>0) %>%
  group_by(yearID, nameGiven) %>%
  mutate(number=sum(Gcf)) %>%
  arrange(yearID, desc(Gcf)) %>%
  group_by(yearID) %>%
  top_n(2, number) %>%
  slice(2)



