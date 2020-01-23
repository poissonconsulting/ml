#' @export
generics::tidy

#' @inherit generics::tidy
#' @details 
#' Returns a data.frame of the coefficient tables with their
#' estimates, standard errors (sd), lower and upper confidence limits
#' and surprisal values (svalue).
#' @param constant A logical scalar specifying whether to include constant terms.
#' @param conf_level A number between 0 and 1 specifying the confidence level.
#'
#' @export
#'
#' @examples
#' expr <- "sum(dnorm(len, mu, sigma, log = TRUE))"
#' start <- list(mu = 20, sigma = 8)
#' data <- datasets::ToothGrowth
#' fitted <- ml_fit(expr, start, data = data)
#' tidy(fitted)
tidy.ml_analysis <- function(x, constant = FALSE, conf_level = 0.95, ...) {
  chk_s3_class(x, "ml_analysis")
  chk_lgl(constant)
  chk_number(conf_level)
  chk_range(conf_level)
  chk_unused(...)
  
  if (vld_false(constant)) {
    return(coef_tidy(x, conf_level))
  }
  if (vld_true(constant)) {
    return(const_tidy(x))
  }
  
  coef <- coef_tidy(x, conf_level)
  const <- const_tidy(x)
  
  table <- rbind(coef, const)
  table <- table[order(table$term), ]
  table
}
