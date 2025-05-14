# DATA 271 - R tune up - January 28-30, 2025

# ///////////////////////////////////////////////////////////////////
# PART ONE: IN-CLASS CODE ALONG
# ///////////////////////////////////////////////////////////////////

# LOADING AND VIEWING DATA IN R --------------------------------------

## print out a list of pre-loaded data in base R


## choose one and look at the data


## import the dataset "Sample_Dataset_2019.csv" using base R


## import the same dataset using the readr package
### install.packages("readr")



## import the dataset "Sample_Dataset_2019.xlsx" using the readxl package
### install.packages("readxl")


# VARIABLE TYPES --------------------------------------------------

## use the str() function to check data types:


## create a numeric variable (numeric is the set of all real numbers (includes decimals))


## create a logical value (TRUE or FALSE)


## create a character (types include numbers, letters, and symbols saved as strings)



# INDEXING ----------------------------------------------------------

## For 1D arrays (aka vectors):
## create an array (aka vector) named "ex_array"


## call the first element of ex_array, which is 3


## return all elements except elements 2 and 3:


## for dataframes:
## extract column by column number


## call by variable (column) name



# CHANGING DATA TYPES IN DATA FRAME -----------------------------------------

## save the bday column in the dataframe df as date:


## and gender as  a string

## check to see the changes took effect



# USING DPLYR TO MANIPULATE DATA----------------------------------------------

###install.packages("tidyverse")


# The most commonly-used dplyr functions include (list and definitions derived from https://dplyr.tidyverse.org/):
# - mutate(), which applies functions to existing variables in order to create new variables
# - select(), which activates certain variables (columns) by calling their names
# - filter(), which activates certain observations (rows) based on their values
# - summarise(), which simplifies many observations by providing a summary
# - arrange(), which changes how the rows are ordered
# - group_by(), which allows you to identify groups and perform an observation on them

## Create a new dataframe, df_oos, for only out-of-state students



## check that there are more observations in the original df



## Combine a few dplyr functions to further modify the new dataframe



## take a look at the first 5 rows of the new-new dataframe



## check the dimensions of the updated dataframe



# HANDLING MISSING VALUES---------------------------------------------------

## find the total number of NA values in a variable column:


## drop rows where Height is missing


## drop rows where weight is missing



# VISUALIZING DATA USING GGPLOT2--------------------------------------

### library(ggplot2)
## create a scatterplot to visualize the relationship between Height and Weight



# MATHEMATICAL FUNCTIONS-----------------------------------------------

## start by experimenting with various built-in mathematical functions in base R



## use built-in functions to calculate the minimum, maximum, mean, and median in the dataframe's Age column



# WRITING YOUR OWN FUNCTIONS IN R---------------------------------------


# function_name <- function(args){function body}


# example function 1: calculate the circumference of a circle



# ///////////////////////////////////////////////////////////////////
# PART TWO: HOMEWORK PROMPTS
# ///////////////////////////////////////////////////////////////////

# FUNDAMENTALS--------------------------------------------------------

# create a vector of 5 values named "example_vec"

# using indexing, return the last element of the vector

# use indexing to assign the first value to the variable "first"

# use indexing to assign the third value to the variable "third"

# multiply the first value by the third value


# MANIPULATING DATA---------------------------------------------------

# load the built-in dataset "attitude" and rename it tude

# look at the first 7 rows of tude

# drop the critical column

# create a new variable called "overall" by subtracting complaints from raises

# filter the dataset to include only observations where the value for overall > 0


# VISUALIZING DATA----------------------------------------------------

# use the geom_bar() function in ggplot2 to visualize the variable "privileges" in the filtered tude dataset


# DEVELOPING YOUR OWN FUNCTIONS---------------------------------------

# create an R function "awake_index" that takes numerical units of sleep (hrs) and coffee (number of cups) as arguments and multiplies them together to generate an overall awake score
