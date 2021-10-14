Macall Teague
she/her/hers
Landscape Ecology, Remote sensing

letters
a <- 1

### creating vector - collection of numbers
(number_vector = c(23, 32, 45))

### calling out second number in vector
number_vector[2]

#### trying to have R read numbers in reverse order, two different ways to do so
number_vector[c(3,2,1)]
rev(number_vector)

### adding new number to vector
number_vector <- c(number_vector,54)

### creating a string - collection of letters/terms. saying don't treat as #
my_string <- c("dog", "walrus", "salmon")

str(my_string)

### creating a data frame
?data.frame

#### creating df with two columns
data.frame(my_string)
data.frame <- data.frame(c(my_string, number_vector))

data.frame(first_column = my_string, second_column = c(my_string))


#### list

test_list <- list("first string entry into list")
str(test_list)
test_list[1][[1]]

#### adding second string to list 

test_list <- list("first string entry into list")
test_list[[1]][2] <- "second string entry into list"



### adding df to list

test_df <- data.frame(letters,letters)

c(test_list,test_df)

test_list[[3]] <- test_df

str(test_list)
head(test_df)
test_list[[3]] <-test_df
str(test_list)



##### know how to make a vector in R, how to pull a value out of the vector, and how to add that vector to that dataframe, or make a dataframe and add it to a list 


