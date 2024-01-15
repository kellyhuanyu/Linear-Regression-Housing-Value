# Goal of the analysis
1. Linear Regression: Using single linear regression and multiple linear regression in R to see the relationships between different variables
2. Predictive Analysis: Using single linear regression and multiple linear regression in R to predict housing value
# Data Source
This dataset contains information collected by the U.S Census Service concerning housing in the area of Boston Mass. It was obtained from the StatLib archive (http://lib.stat.cmu.edu/datasets/boston), and has been used throughout the literature to benchmark algorithms.

The data was originally published by Harrison, D. and Rubinfeld, D.L. `Hedonic prices and the demand for clean air', J. Environ. Economics & Management, vol.5, 81-102, 1978.
### Column description
```
Variables in order:
 CRIM     per capita crime rate by town
 ZN       proportion of residential land zoned for lots over 25,000 sq.ft.
 INDUS    proportion of non-retail business acres per town
 CHAS     Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)
 NOX      nitric oxides concentration (parts per 10 million)
 RM       average number of rooms per dwelling
 AGE      proportion of owner-occupied units built prior to 1940
 DIS      weighted distances to five Boston employment centres
 RAD      index of accessibility to radial highways
 TAX      full-value property-tax rate per $10,000
 PTRATIO  pupil-teacher ratio by town
 B        1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
 LSTAT    % lower status of the population
 MEDV     Median value of owner-occupied homes in $1000's
```
# Data Exploration
### 0. Set up
#### Load library and import file.
```
library(tidyverse)
housing <- read.delim(file="../boston.csv.bz2", sep = '\t')
```
### 1. Data cleaning
#### Making sure if there's any missing or unreasonable data, and clean those data.

There's no missing rows or unreasonable numbers.
```
missing_housing <- sum(is.na(housing))
print(missing_housing)
nrow(housing)
```
### 2. Data exploration
#### (1) Scatterplot: Find the relationships between different variables
Make a scatterplot that displays how median value of housings is related to average number of rooms.

We can see from the plot that more room it is in the house, the higher the median value will be.
```
ggplot(data = housing, aes(rm, medv)) +
  geom_point() +
  geom_smooth(method="lm") +
  labs(x="Avg House Size", y="Median value")
```
<img width="686" alt="Screenshot 2024-01-15 at 3 02 04 PM" src="https://github.com/kellyhuanyu/Linear_Regression_Housing_Value/assets/105426157/bce820e5-1e2d-46e5-8a70-b7d683ca4036">

Now make a scatterplot that displays how median value of housings is related to the percentage of lower status people.

We can see from the plot that the higher percentage of the lower status population, the lower the median value will be.
```
ggplot(data = housing, aes(lstat, medv)) +
  geom_point() +
  geom_smooth(method="lm") +
  labs(x="Percent of lower status population", y="Median value")
```
<img width="684" alt="Screenshot 2024-01-15 at 3 07 07 PM" src="https://github.com/kellyhuanyu/Linear_Regression_Housing_Value/assets/105426157/01fab2a1-2933-4bfe-a2f5-1ab31676768e">

Then we can explore more variables and make another scatterplot that displays how median value of housings is related to crime rate per capita by town.

We can see from the plot that the lower the crime rate is, the higher the median value will be.
```
ggplot(data = housing, aes(crim, medv)) +
  geom_point() +
  geom_smooth(method="lm") +
  labs(x="Crime Rate", y="Median value")
```
#### (2) Single Regression: Predict possible outcomes with different variables
First, let's analyze the relationship between the median value of the housing and average number of rooms with single linear regression.

We can see from the result that the average house size B0 is -34.671 and B1 is 9.102. B0 means when X=0, then Y=-34.671, which means when there is an average of 0 room of the house in the neighborhood, the median value would be $-34,671. B1 tells us if that’s positive or negative correlation, and in this case it is positive correlation, which means the bigger the average house size it is in the neighborhood, the higher the median value will be. We can also see the p-value for the lower status is really small and is very close to 0, which makes us reject the null hypotheses.

```
rm_medv <- lm(medv ~ rm, data=housing)
summary(rm_medv)
```
Result:
```
## Call:
## lm(formula = medv ~ rm, data = housing)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -23.346  -2.547   0.090   2.986  39.433 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  -34.671      2.650  -13.08   <2e-16 ***
## rm             9.102      0.419   21.72   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.616 on 504 degrees of freedom
## Multiple R-squared:  0.4835, Adjusted R-squared:  0.4825 
## F-statistic: 471.8 on 1 and 504 DF,  p-value: < 2.2e-16
```

Then let's analyze the relationship between the median value of the housing and lower status of the population.

We can see from the result that the lower status of the population B0 is 34.55 and B1 is -0.95. B0 means when X=0, then Y=34.55, which means when there is 0 percentage of the lower status of the population in the neighborhood, the median value would be $34,553. B1 tells us if that’s positive or negative correlation, and in this case it is negative correlation, which means the lower the percentage of lower status population is, the higher the median value will be. We can also see the p-value for the lower status is really small and is very close to 0, which makes us reject the null hypotheses.

```
lstat_medv <- lm(medv ~ lstat, data=housing)
summary(lstat_medv)
```
Result:
```
## Call:
## lm(formula = medv ~ lstat, data = housing)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -15.168  -3.990  -1.318   2.034  24.500 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 34.55384    0.56263   61.41   <2e-16 ***
## lstat       -0.95005    0.03873  -24.53   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.216 on 504 degrees of freedom
## Multiple R-squared:  0.5441, Adjusted R-squared:  0.5432 
## F-statistic: 601.6 on 1 and 504 DF,  p-value: < 2.2e-16
```

Lastly, let's analyze the relationship between the median value of the housing and crime rate.

Crime rate B0 is 24.03 and B1 is -0.42. B0 means when X=0, then Y=24.03, which means when there is 0 crime rate in the neighborhood, the median value would be $24,033. B1 tells us if that’s positive or negative correlation, and in this case it is negative correlation, which means the lower the crime rate is, the higher the median value will be. We can also see the p-value for the crime rate is really small and is very close to 0, which makes us reject the null hypotheses.

```
crim_medv <- lm(medv ~ crim, data=housing)
summary(crim_medv)
```
Result:
```
## Call:
## lm(formula = medv ~ crim, data = housing)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -16.957  -5.449  -2.007   2.512  29.800 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 24.03311    0.40914   58.74   <2e-16 ***
## crim        -0.41519    0.04389   -9.46   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 8.484 on 504 degrees of freedom
## Multiple R-squared:  0.1508, Adjusted R-squared:  0.1491 
## F-statistic: 89.49 on 1 and 504 DF,  p-value: < 2.2e-16
```
#### (3) Multiple Regression: Predict possible outcomes with different variables
The H0 null hypothesis here is to assume that the median value of the houses in the neighborhoods has nothing to do with all the other variables. So let's see if we can reject the null hypothesis or not.

First, let's have the multiple regression with the variables of number of rooms, lower status people population and crime rate.

From the result, we can see that all three predictors are highly statistically significant to reject the null hypotheses.
```
multi_medv <- lm(formula = medv ~ rm + lstat + crim, data = housing)
summary(multi_medv)
```
Result:
```
## Call:
## lm(formula = medv ~ rm + lstat + crim, data = housing)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -17.925  -3.567  -1.157   1.906  29.024 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -2.56225    3.16602  -0.809  0.41873    
## rm           5.21695    0.44203  11.802  < 2e-16 ***
## lstat       -0.57849    0.04767 -12.135  < 2e-16 ***
## crim        -0.10294    0.03202  -3.215  0.00139 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 5.49 on 502 degrees of freedom
## Multiple R-squared:  0.6459, Adjusted R-squared:  0.6437 
## F-statistic: 305.2 on 3 and 502 DF,  p-value: < 2.2e-16
```
Let's try other variable in the multiple regression. Let's replace crime rate with "indus", which means the proportion of non-retail business acres per town.

From the result, we can see that the average house size and lower status proportion of people are both highly statistically significant to reject the null hypotheses, while for the “indus” which is the proportion of non-retail business acres per neighborhood, it has a high p-value which fails to reject the null hypotheses.
```
multi_medv_2 <- lm(formula = medv ~ rm + lstat + indus, data = housing)
summary(multi_medv_2)
```
Result:
```
## Call:
## lm(formula = medv ~ rm + lstat + indus, data = housing)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -17.3179  -3.5006  -0.9387   2.0762  28.8816 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -0.96865    3.18168  -0.304    0.761    
## rm           5.07379    0.44428  11.420   <2e-16 ***
## lstat       -0.60671    0.05046 -12.025   <2e-16 ***
## indus       -0.06364    0.04506  -1.412    0.159    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 5.535 on 502 degrees of freedom
## Multiple R-squared:   0.64,  Adjusted R-squared:  0.6378 
## F-statistic: 297.5 on 3 and 502 DF,  p-value: < 2.2e-16
```
### 3. Conclusion
We analyze the relationships of the average number of rooms, population of lower status people, crime rate, and the proportion of non-retail business acres per town.

It makes a lot of sense for the median value of the house to be higher if there are more rooms in the house, since the houses are very likely to be bigger with more rooms. For the population of lower status people, they will tend to find neighborhood with a lower house price, and people with the similar income rate will be in the same neighborhoods, and as time goes by, there will be more and more lower status people in the same neighborhood. Lastly, the neighborhoods with higher crime rates having the lower median value housings makes sense too, since people will not feel safe, and the house owners need to lower the price since it will be harder to sell the houses there. Finally, we fail to reject the null hypothesis on the proportion of non-retail business acres per town with high p-value, so we can know that it has no correlation between the pricing of houses.





