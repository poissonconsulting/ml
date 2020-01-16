#' Fit an R Expression based Maximum Likelihood Model to Data
#'
#' @param expr A string of R code that evaluates to the log-likelihood.
#' @param start An named list of the starting values for the parameter terms 
#' (coerced to an nlist object). Missing values are fixed at 0.
#' @param data An named list or data frame of the data (coerced to an nlist object).
#' @return A fitted ml_analysis object.
#' @export
#' @examples
#' expr <- "sum(dnorm(len, mu, sigma, log = TRUE))"
#' start <- list(mu = 20, sigma = 8)
#' data <- datasets::ToothGrowth
#' analysis <- ml_fit(expr, start = start, data = data)
#' analysis
ml_fit <- function(expr, start, data) {
  start <- as.nlist(start)
  analysis <- list(expr = expr, start = start, data = data)

  data <- as.nlist(data)

  chk_string(expr)
  chk_nlist(start)
  chk_nlist(data)
  chk_not_empty(start)
  chk_not_empty(data)

  analysis$optim <- optimal(expr = expr, start = start, data = data)
  class(analysis) <- "ml_analysis"
  if(!ml_converged(analysis)) wrn("Model failed to converge.")
  analysis
}
