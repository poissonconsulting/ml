#' Maximum Likelhood Analysis
#' 
#' @param expr A string of R code that evaluates to the log-likelihood.
#' @param pars An nlist object of the parameter initial values.
#' @param data An nlist object of the data.
#' @return An ml_analysis object.
#' @export
ml_analyse <- function(expr, pars, data) {
  chk_string(expr)
  chk_nlist(pars)
  chk_nlist(data)

  analysis <- list(expr = expr, pars = pars, data = data)
  analysis$optim <- optimal(expr = expr, pars = pars, data = data)
  class(analysis) <- "ml_analysis"
  analysis
}
