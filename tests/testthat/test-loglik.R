context("loglik")

test_that("logLik.ml_analysis", {
  set.seed(101)
  expr <- "sum(dpois(x, exp(lambda), log = TRUE))"
  start <- list(lambda = 0)
  data <- list(x = rpois(10, 1.5))
  object <- ml_fit(expr, start = start, data = data)
  expect_equal(logLik(object), structure(-12.3618532841626, class = "logLik", df = 1L))
  expect_equal(AIC(object), 26.7237065683252)
})
