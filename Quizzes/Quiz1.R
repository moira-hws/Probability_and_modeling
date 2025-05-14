# DATA 271 - QUIZ 1 - February 13, 2025

# //////////////////////////////////////////////////////////////////////////////
# DIRECTIONS:   Use a mix of code and comments to answer the questions below.
#               You may consult any outside sources, but be conscious of your time.
#               This quiz is due at the end of the class period.
# //////////////////////////////////////////////////////////////////////////////

##  (Questions 1-10)    Sample spaces, experiments, and outcomes----------------


## [1]  Define a sample space called "jar_of_marbles" for drawing red, green, or blue marbles from a jar.


## [2]  In this scenario, there are a total of 100 marbles, of which 13 are red,
##      45 are blue, and the rest are green.  Define a vector called "marble_weights"
##      that encodes the probability of drawing red, blue, and green marbles.


## [3]  Write a for loop to verify that your probabilities from # 2 sum to 1.


## [4]  Simulate drawing marbles from this jar 1,000 times WITH replacement.


## [5]  How many times did you pull a green marble?  Calculate the difference between what you expected and what you observed.


## [6]  Run the following 4 lines of code to establish and look at the dataframe output from "deck_of_cards":
card_numbers = c("2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A")
card_suites = c("hearts", "diamonds", "spades", "clubs")
deck_of_cards = expand.grid("Numbers" = card_numbers, "Suites" = card_suites)
print(deck_of_cards)


## [7]  What counting principle does the expand.grid() help to encode?


## [8]  Create a new variable column in "deck_of_cards" called "Cards" that combines the values from the "Numbers" and "Suites" columns.
##      Hint: use the paste() function to concatenate the character values from these two variable columns.


## [9]  Set the seed to 123.  Then, using the sample space deck_of_cards$Cards, simulate drawing 1 card without replacement and print the results.


## [10]  Given your answer from number 8 (and the fact that you didn't replace this card), what is the probability that the next card you draw is a spade?


##(Questions 11-20)  Visualizing and describing the results of a random experiment----------


## [11]  Define a sample space "random_x" ranging from integers 1 to 20.


## [12]  Run the following line of code to set the weights for each value of random_x:
random_x_weights <- c(.065, .065,.075, .085, .1, .095,.085, .075,.065, .05,.05, .035,.025, .025,.035, .05,.005, .005, .005, .005)


## [13]  Simulate an experiment that randomly draws from the sample space of random_x 5000 times, with replacement.  Include the weights from #12.


## [14]  Visualize the RELATIVE frequencies of this random variable with a histogram.  Hint: first convert the sample output to a column in a dataframe.


## [15]  Is the histogram more positively or more negatively skewed?


## [16]  Would you describe the histogram as more leptokurtic or more platykurtic?


## [17]  Calculate the mean of the random variable you just plotted.


## [18]  Now calculate the median.


## [19]  Use a boxplot to visualize the min, max, and interquartile range of this random variable.


## [20]  What's the variable's sample standard deviation?
