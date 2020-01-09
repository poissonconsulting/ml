#' @export
npars.ml_analysis <- function(x, ...) {
  length(x$optim$par)
}
