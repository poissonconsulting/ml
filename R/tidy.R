coef_tidy <- function(x, conf_level) {
  estimate <- coef(x)
  term <- names(estimate)
  term <- as.term(term)
  estimate <- unname(estimate)
  
  if(ml_converged(x)) {
    cov <- solve(-x$optim$hessian)
    sd <- sqrt(diag(cov))
  } else
    sd <- rep(NA_real_, length(estimate))
  
  lower <- estimate + sd * qnorm((1 - conf_level) / 2)
  upper <- estimate + sd * qnorm((1 - conf_level) / 2 + conf_level)
  svalue <- -log(2 * pnorm(-abs(estimate / sd)), 2)
  
  table <- tibble(
    term = term,
    estimate = estimate,
    sd = sd,
    lower = lower,
    upper = upper,
    svalue = svalue
  )
  table
}

const_tidy <- function(x) {
  estimate <- unlist(x$start)
  term <- names(estimate)
  term <- as.term(term)
  estimate <- unname(estimate)
  
  is_const <- is.na(estimate)
  
  table <- tibble(
    term = term,
    estimate = 0,
    sd = 0,
    lower = 0,
    upper = 0,
    svalue = 0
  )
  table[is_const, ]
}

#' Turn an ml_analysis Object into a tidy tibble
#'
#' @param x An ml_analysis Object
#' @param constant A logical scalar specifying whether to include constant terms.
#' @param conf_level A number between 0 and 1 specifying the confidence level.
#' @param ... Unused
#'
#' @return A data.frame of the coefficient tables with their
#' estimates, standard errors (sd), lower and upper confidence limits
#' and surprisal values (svalue).
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