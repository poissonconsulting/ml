#' @export
logLik.ml_analysis <- function(object, ...) {
  chk_unused(...)
  x <- object$optim$value
  df <- length(coef(object))
  structure(x, class = "logLik", df = df)
}
