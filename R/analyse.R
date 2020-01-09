#' Maximum Likelhood Analysis
#' 
#' @param expr A string of R code that evaluates to the log-likelihood.
#' @param pars An named list of the parameter initial values (coerced to an nlist object).
#' @param data An named list of the data (coerced to an nlist object).
#' @return An ml_analysis object.
#' @export
ml_analyse <- function(expr, pars, data) {
  pars <- as.nlist(pars)
  data <- as.nlist(data)
  
  chk_string(expr)
  chk_nlist(pars)
  chk_nlist(data)

  analysis <- list(expr = expr, pars = pars, data = data)
  analysis$optim <- optimal(expr = expr, pars = pars, data = data)
  class(analysis) <- "ml_analysis"
  analysis
}
