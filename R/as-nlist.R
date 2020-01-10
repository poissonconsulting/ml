#' @export
as.nlist.ml_analysis <- function(x, ...) {
  chk_unused(...)
  coef <- coef(x)
  coef <- as.nlist(coef)
  fill_na(coef)
}
