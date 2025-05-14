set.seed(42)

# target distribution: Standard Normal (unnormalized)
target_density <- function(x) {
  exp(-0.5 * x^2)  # This is proportional to dnorm(x)
}

# metropolis parameters
n_samples <- 10000
samples <- numeric(n_samples)
samples[1] <- 0  # starting point
proposal_sd <- 1  # standard deviation of proposal distribution

# metropolis algorithm
for (i in 2:n_samples) {
  current <- samples[i - 1] # start at a given state
  proposal <- rnorm(1, mean = current, sd = proposal_sd) # let's try jumping to another state -- this gives us a new proposed distribution
  
  ## calculate the acceptance rate, which basically evaluates the proposal distribution versus
  ## our most up-to-date understanding of the target distribution
  acceptance_ratio <- target_density(proposal) / target_density(current) # how much more or less likely the proposal is to the target
  accept <- runif(1) < acceptance_ratio # accept if less than the threshold we set, in this case 1
  
  samples[i] <- if (accept) proposal else current # if accepted, move to new proposal, if rejected, stay at current
}

# discard initial samples due to bias (those before settles into target distribution) aka removing burn-in (optional)
burn_in <- 1000
samples_post_burn <- samples[(burn_in + 1):n_samples]

# Plot histogram of samples vs. true density
hist(samples_post_burn, breaks = 50, probability = TRUE,
     col = "skyblue", border = "white", main = "Metropolis Samples vs. Target Density",
     xlab = "x")
curve(dnorm(x), col = "red", lwd = 2, add = TRUE)
legend("topright", legend = c("Samples", "True N(0,1)"), col = c("skyblue", "red"), lwd = 2)
