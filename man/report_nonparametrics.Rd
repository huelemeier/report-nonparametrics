% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/report-nonparametrics.R
\name{report_nonparametrics}
\alias{report_nonparametrics}
\title{Automatic report of findings from various normality tests}
\usage{
report_nonparametrics(x)
}
\value{
A character vector.
}
\description{
This function automatically creates reports of different normality tests, such as
- chisq.test() # Pearson's chi-squared test
- kruskal.test() # Kruskal-Wallis rank sum test
- friedman.test() # Friedman rank sum test
- fisher.test() # Fisher's exact test
}
