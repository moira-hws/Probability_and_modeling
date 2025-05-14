# DATA 271 - QUIZ 3 - 4/10/25

# //////////////////////////////////////////////////////////////////////////////
# DIRECTIONS:   Use a mix of code and comments to respond to the prompts below
#               (each prompt can be identified by the double hashtags "##" at the 
#               beginning of the corresponding line).  Outside sources are permitted.
# //////////////////////////////////////////////////////////////////////////////


# PART ONE ---------------------------------------------------------------------

## Import any packages you want to use to (1) read and visualize your data and outputs, 
## (2) run decision tree and random forest models, and (3) evaluate model performance.


## Read in the dataset "bc_data.csv", which can be found in the project's "Data" folder.


## Use a function like glimpse() or head() to look at the dataset; this data includes
## variables related to the relationship between breast tissue features and breast cancer diagnoses.


## Set the seed to 42 and split your data into 70% training and 30% testing sets.


## Train a decision tree model to predict whether a breast mass will be diagnosed as
## malignant (M) or benign (B) using the Gini Index to partition the data.


## Which 5 features are most important?  List them below as a comment, and then
## visualize feature importance with a bar graph.


## Use this decision tree model to predict cancer diagnoses for your test set, name the 
## prediction object "pred_bc".


## Adapt these two lines of code to suit your needs in order to ensure the predicted 
## and actual classes have the same level formatting.
pred_bc <- factor(pred_bc, levels = c("B", "M"))
actual_bc <- factor(bdf_test$diagnosis, levels = c("B", "M"))

## Use the confusionMatrix() function to evaluate model performance.


# PART TWO ---------------------------------------------------------------------

## Import "housing" data from the Data folder; this is a dataset on California housing prices.


## Omit NAs from the dataframe using na.omit().


## Split the california housing data into train and test sets, set seed = 123.


## Use this training data set to develop a predictive Decision Tree model for housing prices.


## What are the 3 most important features that predict housing prices?  List them below as 
## a comment, and then visualize feature importance with a bar graph.


## Use this trained model to make predictions about home prices in the test set.


## Evaluate model performance: How close are we, on average, to an accurate estimate of home prices?


# PART THREE -------------------------------------------------------------------

## Split California housing data into new train and test sets, set seed = 100.


## Use this new training data to develop a predictive random forest model with 100 trees, 
## using the same target and feature variables as before.


## Use this trained RF model to make predictions about the home prices in the test set.


## Evaluate the performance.  Does the Random Forest's "wisdom of the crowd" improve 
## performance over the single Decision Tree? If so, by how much?

