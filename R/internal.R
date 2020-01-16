loglik <- function(start, skeleton, data, expr) {
  start <- relist_nlist(start, skeleton)
  start <- fill_na(start)
  data <- c(start, data)
  with(data, eval(expr))
}

optimal <- function(expr, start, data) {
  names <- pars(data)
  names <- names[names %in% pars(start)]
  if (length(names)) {
    abort_chk("The following `start` object%s %r also in `data`: ",
      cc(names, conj = " and "),
      n = length(names)
    )
  }

  skeleton <- start
  start <- unlist(start)
  start <- start[!is.na(start)]
  expr <- parse(text = expr)

  if (!vld_number(loglik(start = start, skeleton = skeleton, data = data, expr))) {
    err("`expr` must evaluate to a non-missing scalar number.")
  }
  optim(
    par = start, fn = loglik, skeleton = skeleton, data = data,
    expr = expr, method = "BFGS", hessian = TRUE,
    control = list(fnscale = -1)
  )
}
