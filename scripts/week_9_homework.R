# Week 9 homework - formatting and plotting Mauna Loa 

#load packages
library(tidyverse)
library(lubridate)

#read in Mauna Loa data - I am reading from github, can also downlaod and read from data folder
mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

## look through README file to view data, determine timezone data are reported in, and how missing values are reported 
# null data reported as: relative humidity = -99, temp at 2m = -999.9, wind speed -999.9 
# time is recorded in UTC

#remove null values
new_df = mloa %>% 
  filter(rel_humid != -99) %>% 
  filter(temp_C_2m != -999.9) %>% 
  filter(windSpeed_m_s != -999.9) %>% 

#generate new column called "datetime" using year/month/day/hour/mins 
#need lubridate!
mutate(datetime = ymd_hm(paste0(year,"-", month, "-", day, " ", hour24, ":", min), tz ="UTC")) %>% 
  
#convert to Pacific time
mutate(datetimelocal = with_tz(datetime, tz = "Pacific/Honolulu"))

#using dplyr, calculate mean hourly temp for each month
new_df %>% 
  mutate(localmonth = month(datetimelocal, label = T),
         localhour = hour(datetimelocal)) %>%
  group_by(localmonth, localhour) %>% 

#calculate mean temp
summarize(meantemp = mean(temp_C_2m)) %>% 
  
#plot 
ggplot(aes(x = localmonth,
           y = meantemp)) +
  #color points by hour
  geom_point(aes(col = localhour)) +
  scale_color_viridis_c() +
  #label axes
  xlab("Month") +
  ylab("Mean Temperature (C)") +
  theme_classic()
  

## future questions - look deeper into the differences between scale_color_virdis_b/c/d

  