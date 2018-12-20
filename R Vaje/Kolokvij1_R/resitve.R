library("rio")
library("dplyr")
library("ggplot2")
data = rio::import(file="C:/git/SQL-R/LabVaje/R Vaje/Kolokvij1_R/Chicago.xlsx", format="xlsx")

data = data %>% select("Date", "Primary Type", "Description", "Location Description", "Arrest", "Domestic")
  
  
  ##Naloga 1 (5 tock)
  
# Uvozi Chicaco.xlsx, izberi SAMO stolpce Date, Primary Type, Description,
# Location Description, Arrest and Domestic. 
# 
# - Preimenuj "Primary Type" v Type ter "Location Description" v Location.
# - Koliko je vseh vrstic? 
# - Prikazi prvih 7 vrstic.


colnames(data)[2] = "Primary"
colnames(data)[4] = "Location"

nrow(data)

head(data, 7)



##Naloga 2 (5 tock)
# Koliko razlicnih (distinct) vrednosti imajo stolpci:
# - Primary
# - Description
# - Location


d1 = data %>% select(Primary)
primaryRows = nrow(distinct(d1))
primaryRows

d1 = data %>% select(Description)
descriptionRows = nrow(distinct(d1))
descriptionRows

d1 = data %>% select(Location)
locationRows = nrow(distinct(d1))
locationRows




##Naloga 3 (5 tock)
# - Izracunajte in narisite barchart, kjer naj bo na osi x Primary, na y pa stevilo dogodkov. Labele Primary naj bodo vidne!!
#   - Kateri "dogodek" je najpogostejsi. Rezultat, t.j. vrsto dogodka, izpisite ***krepko in posevno***!
#   - Uredite graf z labelami osi.

library("ggplot2")

d2 = data %>% select(Primary) %>% group_by(Primary) %>% summarise(Count=n())
d2

ggplot(d2, aes(x=Count, y=Primary, fill=Count)) + geom_bar(stat="identity")

# labele so ze oznacene

max = d2 %>% select(Primary, Count) %>% arrange(Count) %>% top_n(1)
max$Count
max = max$Primary
max



f = data.frame(
  x = c(1,2,3,4,5),
  y = c(10,11,12,13,15)
)
f
ggplot(f, aes(x=x, y=y)) + geom_bar(stat="identity")
  
  
# Naloga 4 (5 tock)
# - Najprej pretvorite string Date v datumski tip v nov stolpec z imenom datum.
# - Iz stolpca datum naredite se dva dodatna stolpca v vasem dataframu:
#   - leto
#   - mesec(polno ime)
# - Izpisite 10 vrstic dataframe-a, ampak samo stolpce datum, leto, mesec.
# 
library("lubridate")

data2 = data %>% mutate(Datum=ymd(as.Date(Date, "%m/%d/%Y")))
head(data2)

# mesci in leta
data2 = data2 %>% mutate(Leto=year(Datum), Mesec=month.abb[month(Datum)])
head(data2)


# prvih 10 vrstic
d2 = data2 %>% select(Datum, Mesec, Leto)
head(d2, 10)


##Naloga 5 (5 tock)
# Izberite samo naslednje tipe iz Primary:
# - THEFT
# - ROBBERY
# - NARCOTICS

# Izrisite graf (barchart) stevila dogodkov po letih (2012-2016), dogodkih(Primary) ter aretacijah (Arrest).
# Uredite graf z labelami osi. Vrednost Primary naj bodo barve v stolpcih.
# Katerega leta je bilo najmanj aretacij?

head(data2)

data3 = data2 %>% select(Primary, Leto, Arrest) %>%
  filter((Primary=="THEFT" | Primary=="ROBBERY" | Primary=="NARCOTICS") & (Leto>=2012 & Leto<=2016))

data3 = data2 %>% select(Primary, Leto) %>% group_by(Leto, Primary) %>% summarise(Count=n())

# se enkrat filtreramo po letih....??
data3 = data3 %>% filter(Leto>=2012 & Leto<=2016)

head(data3)
data3

ggplot(data3, aes(x=Leto, y=Count, fill=Primary)) + geom_bar(stat="identity")
  
# najmanj aretacij v x letu
d51 = data3 %>% group_by(Leto) %>% summarise(Count=sum(Count)) %>% arrange(Count) %>% top_n(-1)
min = d51$Leto
min




##Naloga 6 (5 tock)
# 
# - Kolikokrat se je pojavil dogodek katerega opis (Description) vsebuje stevilko?
#   - Kolikokrat se je pojavil dogodek, ki se zacne na crko?
#   - Kolikokrat se je pojavil dogodek, ki se zacne na $?
#   - Kolikokrat se je pojavil dogodek, ki vsebuje .(piko)?


# st vrstic z stevilko po description
regex = "[0-9]"

d6 = data %>% select(Description) %>% filter(grepl(regex, Description))
head(d6)
nrow(d6)


# zacne na crko
regex = "^(.+)$"

d6 = data %>% select(Description) %>% filter(grepl(regex, Description))
head(d6)
nrow(d6)

# vsebuje piko
regex = "\\."

d6 = data %>% select(Description) %>% filter(grepl(regex, Description))
head(d6)
nrow(d6)


