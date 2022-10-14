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
  
  ```
