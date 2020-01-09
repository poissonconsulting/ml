#' Converged
#' 
#' Test if an ml_analysis object converged.
#' 
#' @param x An ml_analysis object.
#' @return A flag indicating whether the analysis converged.
#'
#' @export
#' @examples 
#' analysis <- ml_analyse("sum(dpois(x, lambda, log = TRUE))",
#'   pars = list(lambda = 1), data = list(x = rpois(1000, 1.5)))
#' ml_converged(analysis)
ml_converged <- function(x) {
  chk_s3_class(x, "ml_analysis")
  x$optim$convergence == 0L
}
