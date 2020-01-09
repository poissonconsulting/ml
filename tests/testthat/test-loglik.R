context("loglik")

test_that("logLik.ml_analysis", {
  set.seed(101)
  expr <- "sum(dpois(x, exp(lambda), log = TRUE))"
  pars <- list(lambda = 0)
  data <- list(x = rpois(10, 1.5))
  object <- ml_analyse(expr, pars = pars, data = data)
  expect_equal(logLik(object), -12.3618532841626)
})

