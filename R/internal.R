coef_tidy <- function(x, conf_level) {
  estimate <- coef(x)
  term <- names(estimate)
  term <- as.term(term)
  estimate <- unname(estimate)
  
  if(ml_converged(x)) {
    cov <- solve(-x$optim$hessian)
    sd <- sqrt(diag(cov))
  } else
    sd <- rep(NA_real_, length(estimate))
  
  lower <- estimate + sd * qnorm((1 - conf_level) / 2)
  upper <- estimate + sd * qnorm((1 - conf_level) / 2 + conf_level)
  svalue <- -log(2 * pnorm(-abs(estimate / sd)), 2)
  
  table <- tibble(
    term = term,
    estimate = estimate,
    sd = sd,
    lower = lower,
    upper = upper,
    svalue = svalue
  )
  table
}

const_tidy <- function(x) {
  estimate <- unlist(x$start)
  term <- names(estimate)
  term <- as.term(term)
  estimate <- unname(estimate)
  
  is_const <- is.na(estimate)
  
  table <- tibble(
    term = term,
    estimate = 0,
    sd = 0,
    lower = 0,
    upper = 0,
    svalue = 0
  )
  table[is_const, ]
}

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
