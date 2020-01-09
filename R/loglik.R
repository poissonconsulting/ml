#' @export
logLik.ml_analysis <- function(object, ...) {
  chk_unused(...)
  x <- -object$optim$value
  df <- npars(object)
  structure(x, class = "logLik", df = df)
}
