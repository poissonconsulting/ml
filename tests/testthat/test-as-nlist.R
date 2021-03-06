context("as-nlist")

test_that("as.nlist.ml_analysis", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(100, 0.1, exp(1.5)))
  object <- ml_fit(expr, start = list(par = c(0, 1)), data = data)

  expect_equal(
    nlist::as.nlist(object),
    structure(list(par = c(-0.0667616239076422, 1.42687283939368)), class = "nlist")
  )
})

test_that("as.nlist.ml_analysis with NA", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(100, 0.1, exp(1.5)))
  object <- ml_fit(expr, start = list(par = c(NA, 1.5)), data = data)

  expect_equal(
    nlist::as.nlist(object),
    structure(list(par = c(0, 1.4268444810352)), class = "nlist")
  )
})


test_that("as.nlist.ml_analysis with NA last!", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[2], exp(par[1]), log = TRUE))"
  data <- list(x = rnorm(100, 0.1, exp(1.5)))
  object <- ml_fit(expr, start = list(par = c(1.5, NA)), data = data)

  expect_equal(
    nlist::as.nlist(object),
    structure(list(par = c(1.4268444810352, 0)), class = "nlist")
  )
})
