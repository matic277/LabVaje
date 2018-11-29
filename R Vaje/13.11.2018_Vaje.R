install.packages("tidyverse")
library("dplyr")

install.packages("hflights")
library("hflights")

data = hflights::hflights
head(data)
summary(data)

typeof(data)

# stevilo stolpcev
ncol(data)

# stevilo vrstic
nrow(data)

# convert to tibble
library("tibble")
data2 = tbl_df(data) # ali tibble::as_data_frame(data)
class(data2)
data2

# put UniqueCarrier collumn in an object
carrierObj = data2$UniqueCarrier
carrierObj

# convert abbr of carrierObj to full name
# AA = American, ...

# primer
sample = c("AA", "AS")
fullNames = c(
  "AA" = "American",
  "AS" = "Alaska",
  "B6" = "JetBlue",
  "CO" = "Continental",
  "DL" = "Delta",
  "OO" = "SkyWest"
  "UA" = "United"
)
fullNames[sample]

carrierObj = fullNames[carrierObj]
head(carrierObj)

# add carrierObj column to data2
head(data2)
data2 = add_column(data2, carrier=carrierObj)
data2

# replacing UniqueCarrier collumn with carrierObj
data2$UniqueCarrier = carrierObj
glimpse(data2)

# fill up empty entris in calcellationcode with "E"
data = as_data_frame(hflights)
data$CancellationCode
unique(data$CancellationCode)

# index empty spaces
cancellationEmpty = data$CancellationCode == ""

# replace empty spaces with "E"
data$CancellationCode[cancellationEmpty] = "E"
data$CancellationCode

# repalcing "A", "E",... values with fullnames
lut = c(
  "A" = "carrier",
  "B" = "weather",
  "C" = "FFA",
  "D" = "security",
  "E" = "not cancelled"
)
data$CancellationCode = lut[data$CancellationCode]
data$CancellationCode
