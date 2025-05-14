set.seed(42)

n_steps <- 10000  # long enough to reach steady state
states <- numeric(n_steps) # create a new state at each time step
states[1] <- sample(0:2, 1) # three possible values of the states (sun, snow, rain)

# define the 3x3 transition matrix
P <- matrix(c(
  0.2, 0.6, 0.2,  # from sun
  0.3, 0, 0.7,  # from snow
  0.5, 0, 0.5   # from rain
), nrow = 3, byrow = TRUE)

for (t in 2:n_steps) {
  current <- states[t - 1] # establish the current weather
  states[t] <- sample(0:2, 1, prob = P[current + 1, ]) # sample the current state based on the last state, get the probabilities from the matrix P
}

# show transition dependence
head(data.frame(Step = 1:n_steps, State = states), 10)
