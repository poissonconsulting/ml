#' Analyse R Function
#' 
#' @param expr A string of the R code that uses pars and data to calculate the negative log-likelihood (nll).
#' @param pars An nlist object of the parameters to estimate.
#' @param data An nlist object of the data.
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
