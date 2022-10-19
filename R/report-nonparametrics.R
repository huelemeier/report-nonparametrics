#' Automatic report of findings from various normality tests
#'
#' This function automatically creates reports of different normality tests, such as
#' - chisq.test() # Pearson's chi-squared test
#' - kruskal.test() # Kruskal-Wallis rank sum test
#' - friedman.test() # Friedman rank sum test
#' - fisher.test() # Fisher's exact test
#'
#' @inheritParams report_nonparametrics
#' @return A character vector.
#'
#' @import{stats}
#'
#' library(stats)
#' report_nonparametrics(kruskal.test(iris$Petal.Length,iris$Species))
#' iris$size <- ifelse(iris$Sepal.Length < median(iris$Sepal.Length),"small", "big")
#' report_non_parametrics(chisq.test(table(iris$Sepal.Length, iris$size))
#' data <- data.frame(person = rep(1:5, each=4),
#' drug = rep(c(1, 2, 3, 4), times=5),
#' score = c(30, 28, 16, 34, 14, 18, 10, 22, 24, 20, 18, 30, 38, 34, 20, 44, 26, 28, 14, 30))
#' report_nonparametrics(friedman.test(data$score, data$drug, data$person))
#' report_nonparametrics(fisher.test(table(iris$Sepal.Length, iris$size), alternative = "less"))
#'
#' @export
report_nonparametrics <- function(x) {
  p <- x[["p.value"]]

  # Pearson's Chi-squared test of independence
  if (x[["method"]][[1]] == "Pearson's Chi-squared test") {
    if (x[["p.value"]] < 0.05) {
      text <- c("We performed ", x[["method"]], " of independence to assess the relationship between ", x[["data.name"]], ". At the 5% significance level, the data provide evidence to conclude that there is a significant association between the two variables, (X2(", x[["parameter"]][["df"]], ") = ", x[["statistic"]], ", p = ", sub("^(-?)0.", "\\1.", sprintf("%.3f", p)), ").")
    } else { # Output for non-significant values
      text <- c(
        "We performed ", x[["method"]], " of independence to assess the relationship between ", x[["data.name"]], ". At the 5% significance level, the data provide evidence that the two variables are independent, (X2(", x[["parameter"]][["df"]], ") = ", x[["statistic"]], ", p = ", sub("^(-?)0.", "\\1.", sprintf("%.3f", p)), ")."
      )
    }
    end
  }
  # Pearson's Chi-squared test of independece with simluated p-value
  else if (str_detect(x[["method"]],"Pearson's Chi-squared test with simulated p-value") == TRUE) { # Output for non-significant values
    if (x[["p.value"]] < 0.05) {
      text <- c("We performed ", x[["method"]], " to assess the relationship between ", x[["data.name"]], ". At the 5% significance level, the data provide evidence to conclude that there is a significant association between the two variables, (X2(", x[["parameter"]][["df"]], ") = ", x[["statistic"]], ", p = ", sub("^(-?)0.", "\\1.", sprintf("%.3f", p)), ").")
    } else { # Output for non-significant values
      text <- c("We performed ", x[["method"]], " to assess the relationship between ", x[["data.name"]], ". At the 5% significance level, the data provide evidence that the two variables are independent, (X2(", x[["parameter"]][["df"]], ") = ", x[["statistic"]], ", p = ", sub("^(-?)0.", "\\1.", sprintf("%.3f", p)), ")."
      )
    }

    end
  }

  # Kruskal-Wallis test
  else if (x[["method"]][[1]] == "Kruskal-Wallis rank sum test") {
    if (x[["p.value"]] < 0.05) {
      text <- c("We performed ", x[["method"]], " to assess the median difference between ", x[["data.name"]], ". We found one or more of the groups has a different median and, thus, comes from a different distribution. In other words, at the 5% significance level, we conclude that at least one of the variables performs differently than the others, (H(", x[["parameter"]][["df"]], ") = ", round(x[["statistic"]], 2), ", p = ", sub("^(-?)0.", "\\1.", sprintf("%.3f", p)), ").")
    } else { # Output for non-significant values
      text <- c(
        "We performed ", x[["method"]], " to assess the median difference between ", x[["data.name"]], ". We found no significant differences between the medians. At the 5% significance level, we conclude the data origin from the same distribution, (H(", x[["parameter"]][["df"]], ") = ", round(x[["statistic"]], 2), ", p = ", sub("^(-?)0.", "\\1.", sprintf("%.3f", p)), ")."
      )
    }
    end
  }


  # Friedman rank sum test
  else if (x[["method"]][[1]] == "Friedman rank sum test") {
    v <- unlist(strsplit(x[["data.name"]],","))
    if (x[["p.value"]] < 0.05) {
      text <- c("A non-parametric ", x[["method"]], " among repeated measures of ", v[1], " depending on the grouping and block variables", v[2], " was conducted. The test rendered a significant Chi-square value suggesting the effect differs between groups (X2(", x[["parameter"]][["df"]], ") = ", round(x[["statistic"]], 2), ", p = ", sub("^(-?)0.", "\\1.", sprintf("%.3f", p)), ").")
    } else { # Output for non-significant values
      text <- c(
        "A non-parametric ", x[["method"]], " among repeated measures of ", v[1], " depending on the grouping and block variables", v[2], " was conducted. The test rendered a non-significant Chi-square value indicating no significant effect difference between groups (X2(", x[["parameter"]][["df"]], ") = ", round(x[["statistic"]], 2), ", p = ", sub("^(-?)0.", "\\1.", sprintf("%.3f", p)), ")."
      )
    }
    end
  }


  # Fisher's exact test
  else if (x[["method"]][[1]] == "Fisher's Exact Test for Count Data") {
    if (x[["alternative"]] != "two-sided") {
      p <- p/2
    }
    if (p < 0.05) {
      text <- c( # Output for significant values
        "The ", x[["method"]], " was applied to determine if there was a significant association between ", x[["data.name"]], ". The results suggest the effect is statistically significant, thus confirming a relation between the two variables (p = ", sub("^(-?)0.", "\\1.", sprintf("%.3f", p)), "). "
      )
    } else { # Output for non-significant values
      text <- c(
        "The ", x[["method"]], " was applied to determine if there was a significant association between ", x[["data.name"]], ". The results suggest the effect is statistically not-significant, thus rejecting a relation between the two variables (p = ", sub("^(-?)0.", "\\1.", sprintf("%.3f", p)), "). "
      )
    }

    if (x[["alternative"]] == "two-sided") {
      alternative <- c("We applied a two-tailed test.")
      text <- c(text, alternative)
    } else if (x[["alternative"]] == "less") {
      alternative <- c("We applied a one-sided test assuming a negative association.")
      text <- c(text, alternative)
    } else if (x[["alternative"]] == "greater") {
      alternative <- c("We applied a one-sided test assuming a positive association.")
      text <- c(text, alternative)
    }
    end

  }



  text <- (paste(text, collapse = "")) # format output
  cat(text, collapse = "") # print output
}




