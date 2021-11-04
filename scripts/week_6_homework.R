# Homework 6
library(tidyverse)
gapminder <- read_csv ("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

head(gapminder)
colnames(gapminder)

# Quesiton 1 Caclualate mean life expectancy by continent, plot how it changes over time

gapminder %>%  group_by(year,continent) %>% 
  summarize(mean_lifeexp = mean(lifeExp)) %>% 
  ggplot() +
  geom_point(aes(x=year, y = mean_lifeexp, color = continent)) +
  geom_line(aes(x = year, y = mean_lifeexp, color = continent))
                      
# Question 2, what does geom_smooth and scale_x_log10 do
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# ANSWER TO QUESTION 2 
# scale_x_log() transforms the x axis into a log scale with base 10
# geom_smooth adds a regression line

# Challenge - modify code so points are in proportion to the population
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# Question 3 - create boxplot showing life expectancy by country

countries <- c("Brazil", "China", "El Salvador", "Niger", "United States")

gapminder %>% filter(country %in% countries) %>% 
  ggplot(aes(x = country, y = lifeExp)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.5, color = "green") +
  theme_minimal() +
  ggtitle("Life Expectancy of Five Countries") +
  theme(plot.title = element_text()) +
  xlab("Country") + ylab("Life Expectancy")

