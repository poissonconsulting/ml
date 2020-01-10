coef_coef_table <- function(x, conf_level) {
  estimate <- coef(x)
  term <- names(estimate)
  term <- as.term(term)
  estimate <- unname(estimate)

  cov <- solve(-x$optim$hessian)
  sd <- sqrt(diag(cov))
  lower <- estimate + sd * qnorm((1 - conf_level) / 2)
  upper <- estimate + sd * qnorm((1 - conf_level) / 2 + conf_level)
  svalue <- -log(2 * pnorm(-abs(estimate / sd)), 2)

  table <- data.frame(
    term = term,
    estimate = estimate,
    sd = sd,
    lower = lower,
    upper = upper,
    svalue = svalue,
    stringsAsFactors = FALSE
  )
  row.names(table) <- NULL
  table
}

const_coef_table <- function(x) {
  estimate <- unlist(x$pars)
  term <- names(estimate)
  term <- as.term(term)
  estimate <- unname(estimate)

  is_const <- is.na(estimate)

  table <- data.frame(
    term = term,
    estimate = 0,
    sd = 0,
    lower = 0,
    upper = 0,
    svalue = 0,
    stringsAsFactors = FALSE
  )
  table <- table[is_const, ]
  row.names(table) <- NULL
  table
}

#' Coefficient Table
#'
#' @param x An ml_analysis Object
#' @param constant A logical scalar specifying whether to include constant terms.
#' @param conf_level A number between 0 and 1 specifying the confidence level.
#'
#' @return A data.frame of the coefficient table.
#' @export
#'
#' @examples
#' template <- "sum(dnorm(len, mu, sigma, log = TRUE))"
#' pars <- list(mu = 20, sigma = 8)
#' data <- datasets::ToothGrowth
#' analysis <- ml_analyse(template, pars = pars, data = data)
#' ml_coef_table(analysis)
ml_coef_table <- function(x, constant = FALSE, conf_level = 0.95) {
  chk_s3_class(x, "ml_analysis")
  chk_lgl(constant)
  chk_number(conf_level)
  chk_range(conf_level)

  if (vld_false(constant)) {
    return(coef_coef_table(x, conf_level))
  }
  if (vld_true(constant)) {
    return(const_coef_table(x))
  }

  coef <- coef_coef_table(x, conf_level)
  const <- const_coef_table(x)

  table <- rbind(coef, const)
  table <- table[order(table$term), ]
  row.names(table) <- NULL
  table
}
