library(stats)
library(tidyverse)

# load data
data(iris)
iris_data <- iris[, 1:4]  # remove the label species

# pre-processing code 
z_score_transform <- function(df, cols) {
  df[cols] <- lapply(df[cols], function(x) {
    if (is.numeric(x)) {
      (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
    } else {
      warning("Non-numeric column encountered. Skipping z-score transformation for that column.")
      return(x)
    }
  })
  return(df)
}

# standardize the iris dataset
iris_data <- z_score_transform(iris_data) 

# hyperparameter tuning with the elbow method, check total within-cluster sum of squares for k = 1:10
wss <- numeric(10)

for (k in 1:10) {
  kmeans_result <- kmeans(iris_data, centers = k, nstart = 25) # nstart parameter tries n initial configurations
  wss[k] <- kmeans_result$tot.withinss
}

# plot the elbow chart to ID best k value
plot(1:10, wss, type = "b", pch = 19, 
     xlab = "Clusters (k)", 
     ylab = "Total Within-Cluster SS", 
     main = "Elbow Method for Choosing k")

# run k-means clustering
set.seed(42)
kmeans_result <- kmeans(iris_data, centers = 3) #, nstart = 20)

# add cluster assignment to original data iris (not iris_data)
iris$Cluster <- as.factor(kmeans_result$cluster)

# compare clusters to true species
table(iris$Species, iris$Cluster)

# Visualization
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Cluster, shape = Species)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(title = "K-means Clustering of Iris Data",
       subtitle = "Color = K-means cluster | Shape = Actual species",
       x = "Petal Length", y = "Petal Width") +
  theme_minimal()
