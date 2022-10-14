# Report results from nonparametric tests
This repository provides the function ```report_nonparametrics``` to automatically generate the results from the most common nonparametric tests, like Pearson's chi-squared test, Kruskal-Wallis or Fisher's Z.
If you have questions, feedback, or further ideas, feel free to contact me. 

# Installation
The package is not yet published on CRAN. Nevertheless, you can install this package from Github. Type in the following lines of code:
```r
install.packages("remotes")

remotes::install_github("huelemeier/report-nonparametrics")
```

Load the package every time you start R:
```r
library(reportnonparametrics)
```

The ```report_nonparametrics()``` is compatible with: 
```r 
chisq.test() # Pearson's chi-squared test
```




## Examples

```R
## Pearson's chi-squared test
# Data preparation
iris$size <- ifelse(iris$Sepal.Length < median(iris$Sepal.Length),
  "small", "big")
  
# report findings
report_non_parametrics(chisq.test(table(iris$Sepal.Length, iris$size))
We performed Pearson's Chi-squared test of independence to assess the relationship between table(iris$Sepal.Length, iris$size). At the 5% significance level, the data provide evidence to conclude that there is a significant association between the two variables, (X2(34) = 150, p = .000)

report_non_parametrics(chisq.test(table(iris$Sepal.Length, iris$size), simulate.p.value = TRUE, B = 429))
We performed Pearson's Chi-squared test with simulated p-value (based on 429 replicates) to assess the relationship between table(iris$Sepal.Length, iris$size). At the 5% significance level, the data provide evidence to conclude that there is a significant association between the two variables, (X2(NA) = 150, p = .002)


## Kruskal-Wallis test 
report_nonparametrics(kruskal.test(iris$Petal.Length,iris$Species))
We performed Kruskal-Wallis rank sum test to assess the median difference between iris$Petal.Length and iris$Species. We found one or more of the groups has a different median and, thus, comes from a different distribution. In other words, at the 5% significance level, we conclude that at least one of the variables performs differently than the others, (H(2) = 130.41, p = .000). 
  
  
## Friedman rank sum test
# Data preparation
data <- data.frame(person = rep(1:5, each=4),
                   drug = rep(c(1, 2, 3, 4), times=5),
                   score = c(30, 28, 16, 34, 14, 18, 10, 22, 24, 20,
                             18, 30, 38, 34, 20, 44, 26, 28, 14, 30))
                             
report_nonparametrics(friedman.test(data$score, data$drug, data$person))
A non-parametric Friedman rank sum test among repeated measures of data$score depending on the grouping and block variables data$drug and data$person was conducted. The test rendered a significant Chi-square value suggesting the effect differs between groups (X2(3) = 13.56, p = .004).                              
                             
                             
```
