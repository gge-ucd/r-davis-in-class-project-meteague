# Week 5 homework

# load tidyverse
library("tidyverse")

# bring in data, create tibble
surveys <- read.csv("data/portal_data_joined.csv")
str(surveys)
colnames(surveys)

## Problem 1

# remove NAs in hindfoot so you can calculate mean
surveys %>% filter(!is.na(hindfoot_length))

# create new df with additional columns, find mean of hindfoot
surveys_wide <- surveys %>% 
  group_by(genus, plot_type) %>% 
  summarise(mean_hindfoot = mean(hindfoot_length))

# rearrange surveys_wide so all plot types are columns

surveys_wide %>% 
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot) %>% 
  arrange(Control)

# Problem 2

# find array of weights
summary(surveys$weight)

# create new weight_cat feature with small, med, lg with case_when
surveys %>% mutate(weight_cat = case_when(weight <= 20.0 ~ "Small",
                                          weight > 20.0 & weight < 48.0 ~ "Medium",
                                          weight >= 48.0 ~ "Large"))

# create new weight_cat using ifelse
surveys %>% mutate(weight_cat = ifelse(weight <= 20.0, "Small",
                                       ifelse(weight > 20.0 & weight < 48.0, "Medium", "Large")))

## BONUS - softcode quantile values 

quantiles <- summary(surveys$weight)

quantiles[1]
quantiles[[1]]
quantiles[2]
quantiles[[2]]
quantiles[[3]]
quantiles[[4]]
quantiles[[5]]

surveys %>% mutate(weight_cat = case_when(weight <= quantiles[[2]] ~ "Small",
                                          weight > quantiles[[2]] & weight < quantiles[[5]] ~ "Medium",
                                          weight>= quantiles[[5]] ~ "Large"))
