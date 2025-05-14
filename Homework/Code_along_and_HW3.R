# DATA 271 - Binomial and geometric distributions - February 25-27, 2025

# //////////////////////////////////////////////////////////////////////////////
# PART ONE: IN-CLASS CODE ALONG
# //////////////////////////////////////////////////////////////////////////////

## If we were starting from scratch, what sub-functions do we need to define
## to define a master function for calculating the binomial distribution?

## factorials :: REMEMBER to address the special case of 0! = 1

## combinations

## define a function for calculating the probability that X=x
## when you're dealing with a binomial distribution

## Binomial processes - example 2:
## The annual probability of flooding in a community is 0.25.
## What is the probability of three floods in the next four years?

## What if we were to change the question slightly, and instead ask what the probability
## of at least three floods in the next four years?

## Now define a function for calculating the probability that X=x
## when you're dealing with a geometric distribution

##  Geometric distribution - example 2
## The probability of flooding on the Ellicott Creek in any given year is 0.19.
## What is the probability that the next flood will occur four years from now?


# //////////////////////////////////////////////////////////////////////////////
# PART TWO: HOMEWORK PROMPTS
# //////////////////////////////////////////////////////////////////////////////

## [1]  Problems two and three use the data in the table "prob_data".  
##      Run this code to view the probabilities you'll need to solve them:

## create vectors
distance <- c("<5", "5-9.99", "10-14.99", "15-19.99", "20-24.99", "25-29.99")
rel_freq <- c(0.15, 0.1, 0.15, 0.25, 0.15, 0.20)
## create and view data frame
prob_data <- data.frame(distance, rel_freq)
print(prob_data)

## [2]  Use the sum() function to add all the values in the "rel_freq" column together.
##      What does this value reflect about the relative frequencies of a random variable?

## [3]  What is the probability that five individuals chosen at random will each
##      travel five miles or more?


## [4]  What is the likelihood that exactly one individual in a set of five 
##      surveyed individuals will travel less than five miles?


## [5]  The annual probability that an individual makes an interstate move is 0.03.
##      What is the probability that at least two out of a sample of ten people
##      will make an interstate move next year?


## [6]  Create a table containing all the probabilities when x = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 in the sample
##      of 10 people from question 5 above.


## [7]  The probability of a residential move in a given year is p = 0.18.  
##      Make a table displaying the probability that an individual's next move will 
##      be in year x = 1, 2, 3, 4, 5, 6, 7, 8.

## [8]  A fair six-sided die is rolled repeatedly until a 6 appears.  
##      What is the probability that the first 6 appears on the 4th roll?

## [9]  A student is taking a multiple-choice exam where each question has four options,
##      and only one is correct.  The student is randomly guessing on each question, so
##      the probability of a correct answer is p = 0.25.  What is the probability
##      that the student gets the first correct answer on the 2nd question attempted?

## [10] Recall de Mere's problem from the first week of class.  The first part of the
##      problem was: what is the probability of having at least 1 ace in 4 rolls of a fair six-sided die?
##      The second part of the problem was: what is the probability of having at least one (1) double-ace
##      in 24 rolls of two die?  Use the binomial formula to answer each question again.


