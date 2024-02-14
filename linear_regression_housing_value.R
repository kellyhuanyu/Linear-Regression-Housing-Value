
```{r setup}
# Load standard libraries
library(tidyverse)

# Read file
housing <- read.delim(file="/Users/Kelly/Desktop/UW/IMT573/pset06/boston.csv.bz2", sep = '\t')

# Data cleaning
missing_housing <- sum(is.na(housing))
row <- nrow(housing)

# Make a scatterplot that displays how medv is related to rm
ggplot(data = housing, aes(rm, medv)) +
  geom_point() +
  geom_smooth(method="lm") +
  labs(x="Avg House Size", y="Median value")

# Make a scatterplot that displays how medv is related to lstat
ggplot(data = housing, aes(lstat, medv)) +
  geom_point() +
  geom_smooth(method="lm") +
  labs(x="Percent of lower status population", y="Median value")

# Make a scatterplot that displays how medv is related to crim
ggplot(data = housing, aes(crim, medv)) +
  geom_point() +
  geom_smooth(method="lm") +
  labs(x="Crime Rate", y="Median value")

# linear regression model
rm_medv <- lm(medv ~ rm, data=housing)
summary(rm_medv)

# linear regression model
lstat_medv <- lm(medv ~ lstat, data=housing)
summary(lstat_medv)

# linear regression model
crim_medv <- lm(medv ~ crim, data=housing)
summary(crim_medv)

# Use multiple regression model to predict the response regarding the indicators of rm+lstat+crim
multi_medv <- lm(formula = medv ~ rm + lstat + crim, data = housing)
summary(multi_medv)

# Use multiple regression model to predict the response regarding the indicators of rm+lstat+indus
multi_medv_2 <- lm(formula = medv ~ rm + lstat + indus, data = housing)
summary(multi_medv_2)
```






