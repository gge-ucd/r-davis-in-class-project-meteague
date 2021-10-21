## read csv ##
surveys <- read.csv('data/portal_data_joined.csv')

### subset data ### 
surveys_base <- surveys[c('species_id','weight','plot_type')]

### subset first sixty rows ###
surveys_base <- surveys_base[1:60,]
  
## converting to factors ###
surveys_base$species_id <-as.factor(surveys_base$species_id)
surveys_base$plot_type <- as.factor(surveys_base$plot_type)

## removing NAs ###
#is.na(surveys_base$weight)
#!is.na(surveys_base$weight)
#na.omit(surveys_base,surveys_base$weight)

surveys_base[!is.na(surveys_base$weight),]

#surveys_base[complete.cases(surveys_base),]
#complete.cases(surveys_base)


### challenge 1 ###
challenge_base <- surveys_base[which(surveys_base$weight>150),]
View(challenge_base)

## subset weights greater than 150 ##
surveys_base$weight > 150
