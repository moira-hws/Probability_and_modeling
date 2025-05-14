# DE MERE'S GAMBLING PROBLEM

## What is the probability of observing 
## at least one (1) ace in four (4) rolls of a die?

prob_rolling_ace <-function(n){
  # n = number of roles
  # complement rule: 1 - p(no aces in n rolls)
  prob <- 1 - (5/6)^n
  return(prob)
}

prob_rolling_ace(n=1)
prob_rolling_ace(n=2)
prob_rolling_ace(n=3)
prob_rolling_ace(n=4)

## What is the probability of observing at least one 
## double-ace in 24 rolls of two dice?

dbl_ace_probability <- function(n_rolls){
  prob_no_dbl <- (35/36)^n_rolls # probability of no rolls in 'n_rolls' of the dice
  prob_snake_eyes <- 1 - prob_no_dbl
  return(prob_snake_eyes)
}

dbl_ace_probability(n_rolls = 24)

dbl_ace_probability(n_rolls = 25)

