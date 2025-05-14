# install any necessary packages
install.packages("tm")       # text mining package
install.packages("e1071")    # Naive Bayes classifier

# import libraries
library(tm)
library(e1071)
library(caret) # will use this to partition data
library(tidyverse)

# import data
df <- read_csv("Data/spam.csv") 

dim(df)

# prep message column for text mining, creating "corpus"
corpus <- VCorpus(VectorSource(df$Message)) # creates a new object of class "Large VCorpus"

# clean the text...make all lowercase, remove special characters and numbers, remove stopwords
corpus_clean <- corpus %>%
  tm_map(content_transformer(tolower)) %>%    # lowercase
  tm_map(removeNumbers) %>%                   # delete numbers
  tm_map(removePunctuation) %>%               # delete punctuation
  tm_map(removeWords, stopwords("en")) %>%    # delete common stopwords
  tm_map(stripWhitespace)                     # delete excess whitespace

# create Document-Term Matrix, such that rows represent the documents and columns represent terms
dtm <- DocumentTermMatrix(corpus_clean)
dtm <- removeSparseTerms(dtm, 0.99) # sparse factor of 0.99

dtm

# convert to a dataframe and assign target category variable
dtm_data <- as.data.frame(as.matrix(dtm))
dtm_data$Category <- df$Category

# prep train and test sets
set.seed(42)  # 
trainIndex <- createDataPartition(dtm_data$Category, p = 0.8, list = FALSE)
train_data <- dtm_data[trainIndex, ]
test_data <- dtm_data[-trainIndex, ]

# use the naiveBayes() function from the e1071 library to run the model
model_nb <- naiveBayes(Category ~ ., data = train_data)

# make predictions
predictions <- predict(model_nb, newdata = test_data)

# justify factor levels
predictions <- factor(predictions, levels = c("ham", "spam"))
reference <- factor(test_data$Category, levels = c("ham", "spam"))

# evaluate the accuracy using caret's confusion matrix
confusionMatrix(predictions, reference)
