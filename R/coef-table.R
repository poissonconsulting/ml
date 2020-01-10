#' Coefficient Table
#'
#' @param x An ml_analysis Object
#' @param conf_level A number between 0 and 1 specifying the confidence level.
#'
#' @return A tibble of the coefficient table.
#' @export
#'
#' @examples
#' template <- "sum(dnorm(len, mu, sigma, log = TRUE))"
#' pars <- list(mu = 20, sigma = 8)
#' data <- datasets::ToothGrowth
#' analysis <- ml_analyse(template, pars = pars, data = data)
#' ml_coef_table(analysis)
ml_coef_table <- function(x, conf_level = 0.95) {
  chk_s3_class(x, "ml_analysis")
  chk_number(conf_level)
  chk_range(conf_level)

  estimate <- coef(x)
  term <- as.term(names(estimate))
  estimate <- unname(estimate)

  cov <- solve(-x$optim$hessian)
  sd <- sqrt(diag(cov))
  lower <- estimate + sd * qnorm((1 - conf_level) / 2)
  upper <- estimate + sd * qnorm((1 - conf_level) / 2 + conf_level)
  svalue <- -log(2 * pnorm(-abs(estimate / sd)), 2)

  tibble(
    term = term,
    estimate = estimate,
    sd = sd,
    lower = lower,
    upper = upper,
    svalue = svalue
  )
}
