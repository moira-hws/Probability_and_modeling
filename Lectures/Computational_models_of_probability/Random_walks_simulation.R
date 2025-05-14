## SINGLE RANDOM WALK ---------------------------------------------------------

# Set seed for reproducibility
set.seed(42)

# Parameters
n_steps <- 100  # number of steps

# Step choices: -1 (left), +1 (right)
steps <- sample(c(-1, 1), size = n_steps, replace = TRUE)

# Cumulative sum to track position over time
position <- cumsum(steps)

# Add the starting position (0)
position <- c(0, position)

# Plot the walk
plot(position, type = "l", col = "blue", lwd = 2,
     xlab = "Step", ylab = "Position on Number Line",
     main = "1D Random Walk")
abline(h = 0, col = "red", lty = 2)

## MANY RANDOM WALKS -----------------------------------------------------------

install.packages("gganimate")
install.packages("gifski")     # for saving as gif
install.packages("transformr") # for smoother transitions

library(tidyverse)
library(gganimate)


set.seed(42)

# parameters
n_walks <- 500    # number of random walks
n_steps <- 100    # max number of steps

# simulate all walks and store positions at each time step
walk_data <- data.frame()

for (i in 1:n_walks) {
  steps <- sample(c(-1, 1), size = n_steps, replace = TRUE)
  position <- c(0, cumsum(steps))  # include starting point
  walk_df <- data.frame(walk = i, step = 0:n_steps, position = position)
  walk_data <- rbind(walk_data, walk_df)
}

# summarize for histogram at each time step
hist_data <- walk_data %>%
  group_by(step, position) %>%
  summarise(count = n(), .groups = "drop")

# create the animated plot
p <- ggplot(hist_data, aes(x = position, y = count)) +
  geom_col(fill = "steelblue") +
  labs(title = "Distribution of Positions at Step: {frame_time}",
       x = "Position", y = "Frequency") +
  transition_time(step) +
  ease_aes('linear') +
  theme_minimal()

# render the animation
animate(p, fps = 10, duration = 10, width = 600, height = 400, renderer = gifski_renderer())

# optionally save as gif
# anim_save("random_walk_distribution.gif")

