nll <- function(pars, fixed, data, expr) {
  pars <- c(pars, fixed)
  pars <- as.nlist(pars)
  data <- c(pars, data)
  -with(data, eval(expr))
}

optimal <- function(expr, pars, data) {
  fixed <- data[names(data) %in% names(pars)]
  data <- data[!names(data) %in% names(pars)]
  
  pars <- unlist(pars)
  fixed <- unlist(fixed)
  pars <- pars[!is.na(pars)]
  fixed <- fixed[!is.na(fixed)]
  if(!vld_term(as.term(c(names(pars), names(fixed))), validate = "complete")) {
    err("Duplicate objects must have the same dimensions in `data` and `pars`.")
  }
  if(length(fixed) && names(fixed) %in% names(pars)) {
    err("Duplicate terms must not be defined in `data` and `pars`.")
  }
  expr <- parse(text = expr)
  if(!vld_number(nll(pars = pars, fixed = fixed, data = data, expr))) {
    err("`expr` must evaluate to a scalar number.")
  }
  optim(par = pars, fn = nll, fixed = fixed, data = data, 
        expr = expr, method = "BFGS", hessian = TRUE)
}
