context("coef-table")

test_that("ml_coef_table", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(1000, 2, exp(1.5)))

  object <- ml_analyse(expr, pars = list(par = c(1, exp(0))), data = data)
  expect_equal(
    as.data.frame(ml_coef_table(object)),
    structure(list(term = structure(c("par[1]", "par[2]"), class = c(
      "term",
      "character"
    )), estimate = c(1.84430816228133, 1.45780108358927), sd = c(0.135867308741607, 0.0223617707697989), lower = c(
      1.57801313047139,
      1.41397281824993
    ), upper = c(2.11060319409126, 1.50162934892862), svalue = c(137.0136029432, Inf)), class = "data.frame", row.names = c(
      "par[1]",
      "par[2]"
    ))
  )
})

test_that("ml_coef_table", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(1000, 2, exp(1.5)))

  object <- ml_analyse(expr, pars = list(par = c(1, exp(0))), data = data)
  expect_equal(
    as.data.frame(ml_coef_table(object)),
    structure(list(term = structure(c("par[1]", "par[2]"), class = c(
      "term",
      "character"
    )), estimate = c(1.84430816228133, 1.45780108358927), sd = c(0.135867308741607, 0.0223617707697989), lower = c(
      1.57801313047139,
      1.41397281824993
    ), upper = c(2.11060319409126, 1.50162934892862), svalue = c(137.0136029432, Inf)), class = "data.frame", row.names = c(
      "par[1]",
      "par[2]"
    ))
  )
})

test_that("ml_coef_table 1 term", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(1.5), log = TRUE))"
  data <- list(x = rnorm(1000, 2, exp(1.5)))

  object <- ml_analyse(expr, pars = list(par = 1), data = data)
  expect_equal(
    as.data.frame(ml_coef_table(object)),
    structure(list(term = structure("par", class = c("term", "character"
)), estimate = 1.8437591040218, sd = 0.141723452215587, lower = 1.56598624191456, 
    upper = 2.12153196612903, svalue = 126.122658362137), class = "data.frame", row.names = "par")
  )
})

test_that("ml_coef_table fixed term", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(1000, 0, exp(1.5)))

  object <- ml_analyse(expr, pars = list(par = c(NA, exp(1.6))), data = data)
  expect_equal(
    as.data.frame(ml_coef_table(object)),
    structure(list(term = structure("par[2]", class = c("term", "character"
)), estimate = 1.4584124597619, sd = 0.0223606648861098, lower = 1.41458636191475, 
    upper = 1.50223855760904, svalue = Inf), class = "data.frame", row.names = "par[2]")
  )
})
