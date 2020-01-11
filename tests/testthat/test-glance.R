context("glance")

test_that("", {
  expr <- "sum(dnorm(len, mu, sigma, log = TRUE))"
  pars <- list(mu = 20, sigma = 8)
  analysis <- ml_analyse(expr, pars = pars, data = datasets::ToothGrowth)
  expect_equal(glance(analysis),
               structure(list(df = 2L, logLik = -206.709065875074, AIC = 417.418131750147, 
                              converged = TRUE), class = "data.frame", row.names = c(NA, 
                                                                                     -1L)))
})
