context("analyse")

test_that("ml_analyse", {
  set.seed(101)
  ml_analyse("nll <- -sum(dpois(x, exp(log_lambda), log = TRUE)); nll",
             pars = nlist::nlist(log_lambda = 0), data = nlist::nlist(x = rpois(10, 1.5)))
})
