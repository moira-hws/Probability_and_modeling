
## Binomial dist ---------------------------------------------------------------



## factorial function

## combinations


## binomial distribution function

bino <- function(n, x, p){
  prob_X_x <- (choose(n, x)) * p^x * ((1-p)^(n-x))
  return(prob_X_x)
}


## example 1
## calculate p from observed "successes"; 


## What's the probability of observing more than 3 accidents in the next month?
## time unit = 30 days
# n = 30
# p = .05
# x = 0, 1, 2, 3

1 - (bino(n = 30, x = 0, p = .05) + bino(n = 30, x = 1, p = .05) + bino(n = 30, x = 2, p = .05) + bino(n = 30, x = 3, p = .05))


## same Q, but now the time unit = 60 days
# n = 60
# p = .025
# x = 0, 1, 2, 3
1 - (bino(n = 60, x = 0, p = .025) + bino(n = 60, x = 1, p = .025) + bino(n = 60, x = 2, p = .025) + bino(n = 60, x = 3, p = .025))

## Poisson dist ----------------------------------------------------------------

## how would we define a function for calculating the Pr(X = x) for a Poisson dist?

pois <- function(lambda, x) {
  pr_X_x <- ((2.718)^(-lambda) * (lambda^x))/(factorial(x))
  return(pr_X_x)
}


## example 1
## What's the probability of observing more than 3 accidents in the next month?
# lambda = 1.5
# x = 0, 1, 2, 3

1 - (pois(lambda = 1.5, x = 0) + pois(lambda = 1.5, x = 1) + pois(lambda = 1.5, x = 2) + pois(lambda = 1.5, x = 3))



## example 2
## Suppose that traffic accidents occur once every ten days.  
## Find the probability that there are 3 accidents during the next 25-day period.
pois(lambda = 2.5, x = 3)


## example 3
## What is the probability that there will be exactly one 50-year flood during the next 50-year period?


## Hypergeometric dist ---------------------------------------------------------

##  How would you define a function for calculating Pr(X=x) for a hypergeometric distribution?

hypergeo <- function(n, r, x, N){
  Pr_X_x <- (choose(r,x) * choose(N-r, n-x))/ (choose(N, n))
  return(Pr_X_x)
}

## example 1
## A box contains *N* = 5 balls; *r* = 3 are red, and *N-r* = 2 are blue.  A sample of *n* = 2 balls is drawn from the box without replacement.  
## Find the probability that exactly one of the balls is red.
hypergeo(r = 3, n = 2, N = 5, x = 1)

## example 2
## What is the probability that a 5-card hand contains fewer than three Kings?
1 - (hypergeo(r = 4, n = 5, N = 52, x = 3) + hypergeo(r = 4, n = 5, N = 52, x = 4))
hypergeo(r = 4, n = 5, N = 52, x = 0) +hypergeo(r = 4, n = 5, N = 52, x = 1) + hypergeo(r = 4, n = 5, N = 52, x = 2)
