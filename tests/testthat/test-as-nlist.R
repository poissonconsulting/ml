context("as-nlist")

test_that("as.nlist.ml_analysis", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(10, 2, 1.5), par = c(1.5, NA))
  object <- ml_analyse(expr, pars = list(par = c(NA, 0)), data = data)
  
  expect_equal(nlist::as.nlist(object),
               structure(list(par = c(NA, 0.183794587081123)), class = "nlist"))
})