context("as-nlist")

test_that("as.nlist.ml_analysis", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(100, 0.1, exp(1.5)))
  object <- ml_analyse(expr, pars = list(par = c(0, 1)), data = data)

  expect_equal(
    nlist::as.nlist(object),
    structure(list(par = c(-0.0667616239076422, 1.42687283939368)), class = "nlist")
  )
})
