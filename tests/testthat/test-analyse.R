context("analyse")

test_that("ml_analyse", {
  set.seed(101)
  object <- ml_analyse("sum(dpois(x, exp(log_lambda), log = TRUE))",
             pars = list(log_lambda = 0), data = list(x = rpois(10, 1.5)))
  expect_is(object, "ml_analysis")
  
  expect_equal(object, structure(list(expr = "sum(dpois(x, exp(log_lambda), log = TRUE))", 
    pars = structure(list(log_lambda = 0), class = "nlist"), 
    data = structure(list(x = c(1L, 0L, 2L, 2L, 1L, 1L, 2L, 1L, 
    2L, 1L)), class = "nlist"), optim = list(par = c(log_lambda = 0.262364097539851), 
        value = 12.3618532841626, counts = c(`function` = 19L, 
        gradient = 6L), convergence = 0L, message = NULL, hessian = structure(13.0000021631993, .Dim = c(1L, 
        1L), .Dimnames = list("log_lambda", "log_lambda")))), class = "ml_analysis"))
})
