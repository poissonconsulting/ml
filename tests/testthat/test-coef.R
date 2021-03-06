context("coef")

test_that("ml_converged", {
  set.seed(101)
  object <- ml_fit("sum(dpois(x, exp(log_lambda), log = TRUE))",
    start = list(log_lambda = 0), data = list(x = rpois(10, 1.5))
  )
  expect_equal(coef(object), c(log_lambda = 0.262364097539851))
})
