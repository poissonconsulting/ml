context("converged")

test_that("ml_converged", {
  set.seed(101)
  object <- ml_fit("sum(dpois(x, exp(log_lambda), log = TRUE))",
    start = list(log_lambda = 0), data = list(x = rpois(10, 1.5))
  )
  expect_true(ml_converged(object))
})

test_that("ml_converged ", {
  set.seed(101)
  expr <- "1"
  data <- list(x = rnorm(10, 2, 1.5))
  expect_warning(analysis <- ml_fit(expr, start = list(par = c(0, 0)), data = data), "Model failed to converge.")
  
  expect_false(ml_converged(analysis))
})
