### Week 4 homework ###

#Load packages
install.packages("tidyverse")
install.packages("dplyr")
install.packages("tidyr")
library("tidyverse")


# Create a tibble named surveys
surveys <- read_csv('portal_data_joined.csv')
view(surveys)

## keep weights of 30 to 60 and remove NAs##

surveys_subset <- surveys[surveys$weight >= 30 & surveys$weight <=60 & !is.na(surveys$weight) & !is.na(surveys$sex) & !is.na(surveys$hindfoot_length),]
view(surveys_subset)

### print first 6 rows ##
head(surveys_subset,6)

## new table with max weight and sex combination  

biggest_critters <- aggregate(weight ~ sex+species,surveys_subset,max)
view(biggest_critters)
biggest_critters <- biggest_critters[order(-biggest_critters$weight),]
view(biggest_critters)

### find where NAs are concentrated, found most in rodents ###
surveys_NAs <- surveys[is.na(surveys$weight),]
sapply(surveys_NAs, table)

### remove NAs, add column #
avwt <- aggregate(weight ~ sex+species, surveys[!is.na(surveys$weight),],mean)
surveys_avg_weight <- merge(surveys[!is.na(surveys$weight),],
                      avwt,
                      by =c("sex", "species"),
                      all.x = T, all.y = F)
colnames(surveys_avg_weight)[colnames(surveys_avg_weight)=="weight.x"] <- "weight"
colnames(surveys_avg_weight)[colnames(surveys_avg_weight)=="weight.y"] <- "avg_weight"

### add new column with above average weights ##
surveys_avg_weight$above_average <- surveys_avg_weight$avg_weight > surveys_avg_weight$weight
