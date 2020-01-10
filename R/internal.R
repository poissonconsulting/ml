loglik <- function(pars, skeleton, data, expr) {
  pars <- relist_nlist(pars, skeleton)
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
  
  skeleton <- pars
  pars <- unlist(pars)
  pars <- pars[!is.na(pars)]
  expr <- parse(text = expr)
  
  if (!vld_number(loglik(pars = pars, skeleton = skeleton, data = data, expr))) {
    err("`expr` must evaluate to a non-missing scalar number.")
  }
  optim(
    par = pars, fn = loglik, skeleton = skeleton, data = data,
    expr = expr, method = "BFGS", hessian = TRUE,
    control = list(fnscale = -1)
  )
}
