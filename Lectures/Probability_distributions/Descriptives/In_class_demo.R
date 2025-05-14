## Run an experiment using the sample() function
# define sample space
values <- seq(1,8)

# define some weights for our probabilities
probabilities <- c(0.2, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1)

# probabilities must sum to 1
ttl_probs <- 0
for(i in probabilities){
  ttl_probs <- ttl_probs + i
}
print(ttl_probs)

# setting random seed
set.seed(123)

# generate a sample dataset of 10,000 observations
sample_output <- sample(values, size =10000, replace = TRUE, prob = probabilities)

## Create a histogram to see the distribution of values
df <- data.frame(Category = sample_output)
head(df)
dim(df)

library(tidyverse)

ggplot(data = df, aes(x=Category, y = ..prop..))+
  geom_bar(fill = "skyblue", color = "black")+
  labs(title = "Histogram of experiment outcomes",
       x = "Category",
       y = "Frequency (rel)")+
  theme_minimal()


##  Run another experiment
values_2 <- c(10, 20, 30, 40, 50)

## Create a boxplot to see the variability
sample_output2 <- sample(values_2, size = 10000, replace = TRUE)

boxplot(sample_output2,
        main = "Boxplot of sample values",
        ylab = "Value",
        col = "lightblue",
        border = "black")

?boxplot()


min(sample_output)
max(sample_output)

mean(sample_output)
median(sample_output)

sd(sample_output)


####### z scores

sample_df <- data.frame(Category = sample_output2)

head(sample_df)

sample_df <- sample_df %>%
  mutate(std_category = (Category - mean(Category) / sd(Category)))

head(sample_df)
