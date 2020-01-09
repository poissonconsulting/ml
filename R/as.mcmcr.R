#' @export
as.mcmcr.ml_analysis <- function(x, ...) {
  chk_unused(...)
  as.mcmcr(as.nlist(x))
}
