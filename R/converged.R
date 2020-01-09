#' @export
converged.ml_analysis <- function(x, ...) {
  x$optim$convergence == 0L
}
