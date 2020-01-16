context("glance")

test_that("glance.ml_analysis", {
  expr <- "sum(dnorm(len, mu, sigma, log = TRUE))"
  start <- list(mu = 20, sigma = 8)
  analysis <- ml_fit(expr, start, data = datasets::ToothGrowth)
  expect_is(glance(analysis), "tbl_df")
  expect_equal(as.data.frame(glance(analysis)),
               structure(list(df = 2L, logLik = -206.709065875074, 
    AIC = 417.418131750147, converged = TRUE), row.names = c(NA, 
-1L), class = "data.frame"))
})
