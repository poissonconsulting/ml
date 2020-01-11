#' Glance at an ml_analysis Object
#'
#' Construct a summary "glance" of an ml_analysis object.
#'
#' @param x An ml_analysis object.
#' @param ... Unused.
#' @return A tibble specifying the number of parameters (df),
#' log-likelihood (logLik), Akaike's Information Criterion (AIC) and 
#' whether or not the model converged.
#'
#' @export
#' @examples
#' expr <- "sum(dnorm(len, mu, sigma, log = TRUE))"
#' pars <- list(mu = 20, sigma = 8)
#' analysis <- ml_analyse(expr, pars = pars, data = datasets::ToothGrowth)
#' glance(analysis)
glance.ml_analysis <- function(x, ...) {
  tibble(df = length(coef(x)), 
         logLik = as.numeric(logLik(x)), 
         AIC = AIC(x), 
         converged = ml_converged(x))
}
