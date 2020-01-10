context("coef-table")

test_that("ml_coef_table", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(1000, 2, exp(1.5)))

  object <- ml_analyse(expr, pars = list(par = c(1, exp(0))), data = data)
  expect_equal(
    ml_coef_table(object),
    structure(list(term = structure(c("par[1]", "par[2]"), class = c(
      "term",
      "character"
    )), estimate = c(1.84430816228133, 1.45780108358927), sd = c(0.135867308741607, 0.0223617707697989), lower = c(
      1.57801313047139,
      1.41397281824993
    ), upper = c(2.11060319409126, 1.50162934892862), svalue = c(137.0136029432, Inf)), class = "data.frame", row.names = c(
      NA,
      -2L
    ))
  )

  expect_equal(
    ml_coef_table(object, constant = NA),
    structure(list(term = structure(c("par[1]", "par[2]"), class = c(
      "term",
      "character"
    )), estimate = c(1.84430816228133, 1.45780108358927), sd = c(0.135867308741607, 0.0223617707697989), lower = c(
      1.57801313047139,
      1.41397281824993
    ), upper = c(2.11060319409126, 1.50162934892862), svalue = c(137.0136029432, Inf)), class = "data.frame", row.names = c(
      NA,
      -2L
    ))
  )

  expect_equal(
    ml_coef_table(object, constant = TRUE),
    structure(list(
      term = structure(character(0), class = c(
        "term",
        "character"
      )), estimate = numeric(0), sd = numeric(0), lower = numeric(0),
      upper = numeric(0), svalue = numeric(0)
    ), row.names = integer(0), class = "data.frame")
  )
})

test_that("ml_coef_table 1 term", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(1.5), log = TRUE))"
  data <- list(x = rnorm(1000, 2, exp(1.5)))

  object <- ml_analyse(expr, pars = list(par = 1), data = data)
  expect_equal(
    ml_coef_table(object),
    structure(list(
      term = structure("par", class = c("term", "character")), estimate = 1.8437591040218, sd = 0.141723452215587, lower = 1.56598624191456,
      upper = 2.12153196612903, svalue = 126.122658362137
    ), class = "data.frame", row.names = c(
      NA,
      -1L
    ))
  )
})

test_that("ml_coef_table constant term", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(1000, 0, exp(1.5)))

  object <- ml_analyse(expr, pars = list(par = c(NA, exp(1.6))), data = data)
  expect_equal(
    ml_coef_table(object),
    structure(list(
      term = structure("par[2]", class = c("term", "character")), estimate = 1.4584124597619, sd = 0.0223606648861098, lower = 1.41458636191475,
      upper = 1.50223855760904, svalue = Inf
    ), class = "data.frame", row.names = c(
      NA,
      -1L
    ))
  )
  expect_equal(
    ml_coef_table(object, constant = NA),
    structure(list(term = structure(c("par[1]", "par[2]"), class = c(
      "term",
      "character"
    )), estimate = c(0, 1.4584124597619), sd = c(0, 0.0223606648861098), lower = c(0, 1.41458636191475), upper = c(0, 1.50223855760904), svalue = c(0, Inf)), row.names = c(NA, -2L), class = "data.frame")
  )
  expect_equal(
    ml_coef_table(object, constant = TRUE),
    structure(list(term = structure("par[1]", class = c("term", "character")), estimate = 0, sd = 0, lower = 0, upper = 0, svalue = 0), row.names = c(
      NA,
      -1L
    ), class = "data.frame")
  )
})

test_that("coef_table matrix", {
  expr <- "sum(dnorm(len, mu, b[1,1] + b[1,2], log = TRUE))"
  pars <- list(mu = 20, b = matrix(c(8, NA), ncol = 2))
  data <- datasets::ToothGrowth

  analysis <- ml_analyse(expr, pars = pars, data = data)

  expect_equal(
    ml_coef_table(analysis, constant = NA),
    structure(list(term = structure(c("b[1,1]", "b[1,2]", "mu"), class = c(
      "term",
      "character"
    )), estimate = c(7.58530491010422, 0, 18.8134127104156), sd = c(0.692440634780261, 0, 0.979258651599005), lower = c(
      6.22814620450286,
      0, 16.8941010217323
    ), upper = c(8.94246361570559, 0, 20.7327243990989), svalue = c(90.3526269568688, 0, 270.840651307944)), row.names = c(
      NA,
      -3L
    ), class = "data.frame")
  )
})
