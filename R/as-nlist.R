#' @export
as.nlist.ml_analysis <- function(x, ...) {
  chk_unused(...)
  pars <- x$optim$par
  as.nlist(pars)
}
