context("analyse")

test_that("ml_analyse", {
  set.seed(101)
  object <- ml_analyse("sum(dpois(x, exp(log_lambda), log = TRUE))",
             pars = nlist::nlist(log_lambda = 0), data = nlist::nlist(x = rpois(10, 1.5)))
  expect_is(object, "ml_analysis")
})
