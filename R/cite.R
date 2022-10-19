# cite the R package:
cite <- function(x) {
  if (x == "reportnonparametrics") {
    text <- c("You can cite this package as following:

Hülemeier, A.-G. (2022).
Automatic report of findings from various non-parametric tests.
Available from https://github.com/huelemeier/report-nonparametrics:


BibTeX entry for LaTeX:

@Article{Anna-Gesina Hülemeier
  title = {Automatic report of findings from various non-parametric tests}
  author = {Anna-Gesina Hülemeier}
  year = {2022}
  url = {https://github.com/huelemeier/report-nonparametrics}
}")

    cat(text, sep = "\n") # print output
  }
  end
}
