#' @export
logLik.ml_analysis <- function(object, ...) {
  chk_unused(...)
  -object$optim$value
}
