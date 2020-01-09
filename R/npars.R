#' @export
npars.ml_analysis <- function(x, ...) {
  length(coef(x))
}
