# Ames housing data
install.packages("AmesHousing")
library(AmesHousing)
ames <- AmesHousing::make_ames()

# in base R --------------------------------------------------------------------
set.seed(42)
index_1 <- sample(1:nrow(ames), round(nrow(ames) * 0.7)) # randomly select 70% of the row indices without replacement
ames_train_1 <- ames[index_1, ]
ames_test_1 <- ames[-index_1, ]


# use caret package ------------------------------------------------------------
install.packages("caret")
library(caret)
set.seed(42)
index_2 <- createDataPartition(ames$Sale_Price, p = 0.7,
                               list = FALSE)
train_2 <- ames[index_2, ]
test_2 <- ames[-index_2, ]

# use rsample package ----------------------------------------------------------
install.packages("rsample")
library(rsample)
set.seed(42)
split_1 <- initial_split(ames, prop = 0.7)
train_3 <- training(split_1)
test_3 <- testing(split_1)
