#' Coefficient Table
#'
#' @param x An ml_analysis Object
#'
#' @return A tibble of the coefficient table.
#' @export
coef_table <- function(x) {
  chk_s3_class(x, "ml_analysis")
  coef <- coef(x)
  tibble(term = as.term(names(coef)), 
         estimate = unname(coef))
}
