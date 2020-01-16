#' @export
as.nlist.ml_analysis <- function(x, ...) {
  chk_unused(...)
  coef <- coef(x)
  coef <- relist_nlist(coef, x$start)
  coef <- fill_na(coef)
  coef
}
