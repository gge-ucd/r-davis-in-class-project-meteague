# Week 7 homework ggplot - recreating graphs and googling

#load packages
library(tidyverse)

#read in csv
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

#create new data frame with country in each row and columns for 2002 and 2007
df_new <- gapminder %>% filter(year %in% c(2002, 2007)) %>% 
  pivot_wider(id_cols = c(country, continent), names_from = year,values_from = pop) %>% 
  mutate(popDiff = `2007` - `2002`) %>% 
  filter(continent != "Oceania")

ggplot(df_new) + facet_wrap(~ continent, scales = 'free') +
  geom_bar(aes(x = reorder(country, popDiff), y = popDiff),stat = 'identity') +
  labs(x = 'Country', y= 'Change in Population 2002-2007') + 
  theme_linedraw() +
  theme(axis.text.x = element_text(colour = 'blue', angle = 45, hjust = 1)) 



