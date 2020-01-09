#' @export
coef.ml_analysis <- function(object, ...) {
  object$optim$par
}
