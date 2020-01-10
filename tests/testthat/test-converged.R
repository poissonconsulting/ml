context("converged")

test_that("ml_converged", {
  set.seed(101)
  object <- ml_analyse("sum(dpois(x, exp(log_lambda), log = TRUE))",
    pars = list(log_lambda = 0), data = list(x = rpois(10, 1.5))
  )
  expect_true(ml_converged(object))
})

test_that("ml_converged ", {
  set.seed(101)
  expr <- "1"
  data <- list(x = rnorm(10, 2, 1.5))
  expect_warning(analysis <- ml_analyse(expr, pars = list(par = c(0, 0)), data = data), "Model failed to converge.")
  
  expect_false(ml_converged(analysis))
})
