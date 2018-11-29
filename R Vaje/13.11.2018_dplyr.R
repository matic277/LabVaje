library("dplyr")
library("hflights")
data = as_tibble(hflights)

# SUMMARY

# use select() to print out a table that contains only the columns
# ActualElapsedTime, AirTime, ArrDelay and DepDelay of hflights
select(data, c("AirTime", "ArrDelay", "ActualElapsedTime", "DepDelay"))

# selecting all rows from Origin to Cancelled
select(data, "Origin":"Cancelled")

# selecting with helper functins
# print all columns that start with D
select(data, starts_with("D"))

# select UniqueCarrier, FlightNum, TailNum, Cancelled, CancellationCode
# using helper functions
select(data, ends_with("Num"), starts_with("Cancel"), contains("Unique"))

# select DepTime, ArrTime, ActualElapsedTime, AirTime, ArrDelay
# using helper functions 
select(data, starts_with("A"), contains("Time"))

# MUTATE

# add column AcutalGroundTime to hflights, its difference between atualelapsedtime - airtime
data = mutate(data, ActualGroundTime = ActualElapsedTime - AirTime)
data$ActualGroundTime

# add column groundTme, its sum of taxiout and taxiin
# groundtime should be same as actualgrountime
data = mutate(data, GroundTime = TaxiIn + TaxiOut)
select(data, GroundTime, ActualGroundTime)

# add column AverageSpeed, caluclate by formula: distance/airtime * 60
data = mutate(data, AverageSpeed = (Distance / AirTime * 60))
data$AverageSpeed

# add a second variable lossPercent to dataset m1
# variables are built on the fly, you can reuse them in same call
m1 = mutate(data, loss=ArrDelay-DepDelay, lossPercent=((loss/DepDelay)*100))
select(m1, loss, lossPercent)

m3 = mutate(hflights, TotalTaxi=(TaxiIn+TaxiOut), ActualGroundTime=(ActualElapsedTime-AirTime), Diff=(TotalTaxi-ActualGroundTime))

# FILTER

# get flights that traveled more than 3000 units of Distance
filter(data, Distance>3000)

# all flights flown by JetBlue, Southwest or Delta
filter(data, UniqueCarrier %in% c("JetBlue", "Southwest", "Delta"))

# all flights that departed before 5am or arrived after 10pm
filter(data, DepTime<0500 | ArrTime>1000)

# all flights that departed late but arrive ahead of schedule
filter(data, ArrDelay<0, DepDelay>0)

# ARRANGE
dtc = filter(hflights, Cancelled==1, !is.na(DepDelay))

# arrange dtc by departure delays so that the shortest in at the top
arrange(dtc, DepDelay)

# arrange so that cancellation reasons are grouped
arrange(dtc, CancellationCode)

# arrange according to the carrier and departure delays
arrange(dtc, UniqueCarrier, DepDelay)

# arrange according to carrier and decreasing departure delays
arrange(dtc, UniqueCarrier, desc(DepDelay))

# arrange flights by total delay
arrange(dtc, ArrDelay+DepDelay)

# flights leaving to DFW before 8am and arrange according to decreasing AirTime
arrange(filter(dtc, Dest=="DFW" & DepTime>0800), desc(AirTime))

# SUMMARISE

# us summarise() to print out a summary of hflights containing two variables: min_Dist and shortest distance flown,
# and maxdist the longest distance flown
summarise(hflights, min_dist=min(Distance), max_dist=max(Distance))

# print out a smry of hflights with asingle variable, max_div the longest distance for diverted flights
summarise(filter(hflights, Diverted==1), max_div=max(Distance))

# a smry of temp1 with some variables
temp1 = filter(hflights, !is.na(ArrDelay))

summarise(temp1, earliest=min(ArrDelay), average=mean(ArrDelay), latest=max(ArrDelay), sd=sd(ArrDelay))

# SELECT, MUTATE, FILTER vaje

# flights that had JFK as their destination
filter(data, Dest=="JFK")

# combine year, month, delayofmonth variables to create a Date column
data = mutate(data, Date=paste(Year, Month, DayofMonth))
data$day

# how many weekend flights flew a ditance of more than 1000 miles
nrow(filter(data, DayOfWeek>5 & Distance>1000))




