#' @export
generics::glance

#' @inherit generics::glance
#' @details  Returns a tibble specifying the number of parameters (df),
#' log-likelihood (logLik), Akaike's Information Criterion (AIC) and 
#' whether or not the model converged.
#'
#' @export
#' @examples
#' expr <- "sum(dnorm(len, mu, sigma, log = TRUE))"
#' start <- list(mu = 20, sigma = 8)
#' analysis <- ml_fit(expr, start, data = datasets::ToothGrowth)
#' glance(analysis)
glance.ml_analysis <- function(x, ...) {
  tibble(df = length(coef(x)), 
         logLik = as.numeric(logLik(x)), 
         AIC = AIC(x), 
         converged = ml_converged(x))
}
