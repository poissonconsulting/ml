#' @export
as.nlist.ml_analysis <- function(x, ...) {
  chk_unused(...)
  pars <- x$optim$par
  pars <- as.nlist(pars)
  fill_na(pars)
}
