library(tidyverse) # for plotting
library(class) # model package

# prepare data
data(iris)
iris2d <- iris[, c("Sepal.Length", "Sepal.Width", "Species")]

# example distances using built-in dist()


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
iris_df <- z_score_transform(iris2d)

# split pre-processed data into train and test sets
set.seed(42)
train_index <- sample(1:nrow(iris_df), round(nrow(iris_df) * 0.8))
train_iris <- iris_df[train_index,]
test_iris <- iris_df[-train_index,]

# apply KNN (k = 5)
knn_pred <- knn(train_iris[, 1:2], test_iris[, 1:2], cl = train_iris$Species, k = 5)
test_iris$Predicted <- knn_pred

# plot actual vs predicted

ggplot() +
  geom_point(data = train_iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species), shape = 16, alpha = 0.6) +
  geom_point(data = test_iris, aes(x = Sepal.Length, y = Sepal.Width, shape = Species, color = Predicted), size = 3) +
  labs(title = "KNN classes, Iris dataset, k =5",
       color = "Predicted Species",
       shape = "True Species")+
  theme_minimal()
