# RDAVIS Final

library(tidyverse)
library(lubridate)
library(sparklyr)

#download CSVs, join together
flights <- read_csv("data/nyc_13_flights_small.csv")
planes <- read_csv("data/nyc_13_planes.csv")
weather <- read_csv("data/nyc_13_weather.csv")

#join csvs
df <- left_join(flights, weather)
df_2 <- left_join(df, planes)

#plot
plot(df_2$dep_delay ~ df_2$precip,
     xlab = "Precipitation",
     ylab = "Depature Delay")
abline(lm(dep_delay~precip, df_2),
       col = "darkred")
######################################################
q2 <- aggregate(dep_delay ~ year + month + day + carrier,
                df_2, mean)

q2$date <- paste(q2$year,
                 sprintf("%02d",q2$month), 
                 sprintf("%02d",q2$day),
                 sep = "/")

q2$date2 <- as.Date(q2$date, "%Y/%m/%d")

plot(q2$dep_delay[q2$month %in% c(9:12)] ~ 
       q2$date2[q2$month %in% c(9:12)],
     type = "n", axes = F,
     xlab = "Date",
     ylab = "Mean Depature Delay")
axis(1, pretty(q2$date2[q2$month %in% c(9:12)]),
     format(pretty(q2$date2[q2$month %in% c(9:12)]), "%b-%d"))
axis(2)
box()
count = 1
for(icar in sort(unique(q2$carrier))){
  
  points(q2$dep_delay[q2$month %in% c(9:12) & q2$carrier == icar] ~ 
           q2$date2[q2$month %in% c(9:12) & q2$carrier == icar],
         pch = count, col = count)
  
  count = count + 1
  
}

legend("topright",
       pch = 1:count,
       col = 1:count,
       legend = sort(unique(q2$carrier)),
       ncol = 2)
#########################################################
#Create a dataframe with these columns: date (year, month and day), 
#mean_temp, where each row represents the airport, based on airport code. 
#Save this is a new csv into you data folder called mean_temp_by_origin.csv

q3 <-  aggregate(temp ~ year + month + day + origin,
                      df_2, mean)
colnames(q3)[colnames(q3) == "temp"] <- "mean_temp"
write.csv(q3, "mean_temp_by_origin.csv", row.names = F)

########################################################
#Make a function that can: (1) convert hours to minutes; and (2) convert minutes to hours 
#(i.e., it’s going to require some sort of conditional setting in the function that determines
#which direction the conversion is going). 
#Use this function to convert departure delay (currently in minutes) to hours and then 
#generate a boxplot of departure delay times by carrier. 
#Save this function into a script called “customFunctions.R” in your scripts/code folder.

convert_time <- function(time, input_unit){
  
  if (input_unit == "minute") {
    
    x = round(time / 60,2)
    return(x)
  } else if (input_unit == "hour"){
    
    x = time * 60
    return(x)
  } else {
    
    stop(print("input unit must be either 'minute' or 'hour'"))
    
  }
  
  
}

#testing
convert_time(3, "hour")
convert_time(180, "minute")
convert_time(1234, "asdf")

q4 <- df_2
q4$dep_delay_hr <- convert_time(q4$dep_delay, "minute")

boxplot(q4$dep_delay_hr ~ q4$carrier,
        xlab = "Carrier", ylab = "Departure Delay (hr)")
####################################################################



