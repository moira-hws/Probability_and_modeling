### The first part of this Random_Forest.R file includes the Decision tree script
### from Tuesday, 4/3 (Moira mistakenly programmed DTs here, a copy is also now available in the Decision_trees.R script)

# Decision tree packages
library(dplyr)
library(ggplot2)
library(rpart) # model packages
library(caret) # model packages
library(rpart.plot)
library(vip)
library(pdp)
library(AmesHousing)


# import data
ames <- AmesHousing::make_ames()

# prep data for DT classification task
set.seed(42)
index_1 <- sample(1:nrow(ames), round(nrow(ames) * 0.7)) # randomly select 70% of the row indices without replacement
ames_train_1 <- ames[index_1, ]
ames_test_1 <- ames[-index_1, ]

# prep data for DT regression task
set.seed(123)
index_2 <- sample(1:nrow(ames), round(nrow(ames) * 0.7)) # randomly select 70% of the row indices without replacement
ames_train_2 <- ames[index_2, ]
ames_test_2 <- ames[-index_2, ] 


# Decision trees: Classification task-------------------------------------------

# fit model
ames_dt1 <- rpart(formula = Central_Air ~.,
                  data = ames_train_1,
                  method = "class",
                  parms = list(split = "gini")
)


# visualize tree output
ames_dt1
rpart.plot(ames_dt1)

# visualizing feature importance
vip(ames_dt1, num_features = 15)

# make predictions
pred_class <- predict(ames_dt1, newdata = ames_test_1, type = "class")


# evaluate performance
table(Predicted = pred_class, Actual = ames_test_1$Central_Air)

confusionMatrix(pred_class, ames_test_1$Central_Air)

# Decision trees: regression task ----------------------------------------------

# fit model
ames_dt2 <- rpart(
  formula = Year_Built ~ .,
  data = ames_train_2,
  method = "anova",
  control = list(cp = 0, xval = 10)
)

# visualize tree output
ames_dt2
rpart.plot(ames_dt2)


# hyperparameter tuning
plotcp(ames_dt2)
abline(v = 10, lty = "dashed")

# new hyperparameter, depth = 5
ames_dt2 <- rpart(
  formula = Year_Built ~ .,
  data = ames_train_2,
  method = "anova",
  control = rpart.control(maxdepth = 5)
)

# visualize the updated model
rpart.plot(ames_dt2)
vip(ames_dt2, num_features = 15)

# make predictions
pred_val <- predict(ames_dt2, newdata = ames_test_2)

# evaluate performance # root mean squared error
rmse <- sqrt(mean((pred_val - ames_test_2$Year_Built)^2))
rmse


#-------------------------------------------------------------------------------



# Random Forest packages
library(randomForest) # classic, though ranger is faster
library(AmesHousing)
library(caret)

ames <- AmesHousing::make_ames()

# in base R
set.seed(100) # 
index_3 <- sample(1:nrow(ames), round(nrow(ames) * 0.7)) # randomly select 70% of the row indices without replacement
ames_train_3 <- ames[index_3,] # select rows from index_1
ames_test_3 <- ames[-index_3,] # select those rows outside of index_1


set.seed(111)
index_4 <- sample(1:nrow(ames), round(nrow(ames) * 0.7)) # randomly select 70% of the row indices without replacement
ames_train_4 <- ames[index_4,] # select rows from index_1
ames_test_4 <- ames[-index_4,] # select those rows outside of index_1


# Random Forest: classification task -------------------------------------------

rf_model <- randomForest(
  Central_Air ~ .,
  data = ames_train_3,
  ntree = 100,
  importance = TRUE
)

pred_class <- predict(rf_model, newdata = ames_test_3, type = "class")

table(Predicted = pred_class, Actual = ames_test_3$Central_Air)

confusionMatrix(pred_class, ames_test_3$Central_Air)

# Random forest: regression task -----------------------------------------------

rf_reg_model <- randomForest(
  Year_Built ~ .,
  data = ames_train_4,
  ntree = 100,
  importance = TRUE
)

pred_val <- predict(rf_reg_model, newdata = ames_test_4)
rmse <- sqrt(mean((pred_val - ames_test_4$Year_Built)^2))
rmse
