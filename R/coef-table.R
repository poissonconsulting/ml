#' Coefficient Table
#'
#' @param x An ml_analysis Object
#' @param conf_level A number between 0 and 1 specifying the confidence level.
#'
#' @return A tibble of the coefficient table.
#' @export
#' 
#' @examples
#'  set.seed(101)
#'  object <- ml_analyse("sum(dpois(x, exp(log_lambda), log = TRUE))",
#'             pars = list(log_lambda = 0), data = list(x = rpois(10, 1.5)))
#'  ml_coef_table(object)
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
  svalue <- -log(2 * pnorm(-abs(estimate/sd)), 2)

  tibble(term = term, 
         estimate = estimate,
         sd = sd,
         lower = lower,
         upper = upper,
         svalue = svalue)
}
