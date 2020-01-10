loglik <- function(pars, data, expr) {
  pars <- as.nlist(pars)
  pars <- fill_na(pars)
  data <- c(pars, data)
  with(data, eval(expr))
}

optimal <- function(expr, pars, data) {
  names <- pars(data)
  names <- names[names %in% pars(pars)]
  if(length(names)) {
    abort_chk("The following `pars` object%s %r also in `data`: ", 
              cc(names, conj = " and "), n = length(names))
  }
  
  pars <- unlist(pars)
  pars <- pars[!is.na(pars)]
  expr <- parse(text = expr)
  
  if (!vld_number(loglik(pars = pars, data = data, expr))) {
    err("`expr` must evaluate to a non-missing scalar number.")
  }
  optim(
    par = pars, fn = loglik, data = data,
    expr = expr, method = "BFGS", hessian = TRUE,
    control = list(fnscale = -1)
  )
}
