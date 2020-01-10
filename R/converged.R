#' Converged
#' 
#' Test if an ml_analysis object converged.
#' 
#' @param x An ml_analysis object.
#' @return A flag indicating whether the analysis converged.
#'
#' @export
#' @examples 
#' template <- "sum(dnorm(len, mu, sigma, log = TRUE))"
#' pars <- list(mu = 20, sigma = 8)
#' data <- datasets::ToothGrowth
#' analysis <- ml_analyse(template, pars = pars, data = data)
#' ml_converged(analysis)
ml_converged <- function(x) {
  chk_s3_class(x, "ml_analysis")
  x$optim$convergence == 0L
}
