variables <- function(expr) {
  all.vars(parse(text = expr))
}

fn <- function(pars, data, expr) {
  data <- c(pars, data)
  data <- as.nlist(data) # see if speed up
  ll <- with(data, eval(expr))
  if(!vld_number(ll)) err("`expr` must evaluate to a scalar number.")
  -ll
}

optimal <- function(expr, pars, data) {
  pars <- unlist(pars)
  data <- unlist(data)
  pars <- pars[!is.na(pars)]
  data <- data[!is.na(data)]
  # speed up by only collapsing those data that also in pars!
  duplicates <- names(data) %in% names(pars)
  if(any(duplicates)) {
    wrn("Dropped ", sum(duplicates), " (non-missing) values from `data` as estimated in `pars`")
    data <- data[!duplicates]
  }
  if(!vld_term(as.term(names(data)), validate = "complete")) {
    err("Objects with the same name in both `data` and `pars` must have the same dimensions.")
  }
  expr <- parse(text = expr)
  optim(par = pars, fn = fn, data = data, expr = expr, method = "BFGS")
}
