context("analyse")

test_that("ml_analyse", {
  set.seed(101)
  object <- ml_analyse("sum(dpois(x, exp(log_lambda), log = TRUE))",
    pars = list(log_lambda = 0), data = list(x = rpois(10, 1.5))
  )
  expect_is(object, "ml_analysis")

  expect_equal(object, structure(list(
    expr = "sum(dpois(x, exp(log_lambda), log = TRUE))",
    pars = structure(list(log_lambda = 0), class = "nlist"),
    data = structure(list(x = c(
      1L, 0L, 2L, 2L, 1L, 1L, 2L, 1L,
      2L, 1L
    )), class = "nlist"), optim = list(
      par = c(log_lambda = 0.262364097539851),
      value = -12.3618532841626, counts = c(
        `function` = 19L,
        gradient = 6L
      ), convergence = 0L, message = NULL, hessian = structure(-13.0000021631993, .Dim = c(
        1L,
        1L
      ), .Dimnames = list("log_lambda", "log_lambda"))
    )
  ), class = "ml_analysis"))
})

test_that("ml_analyse two parameters", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(10, 2, 1.5))
  object <- ml_analyse(expr, pars = list(par = c(0, 0)), data = data)

  expect_equal(object, structure(list(
    expr = "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))",
    pars = structure(list(par = c(0, 0)), class = "nlist"), data = structure(list(
      x = c(
        1.51094526422692, 2.82869278312871, 0.987584234066254,
        2.32153918856514, 2.4661538259704, 3.76094943134405,
        2.92818478343895, 1.83089852786868, 3.37554243426907,
        1.66511095305911
      )
    ), class = "nlist"), optim = list(
      par = c(
        `par[1]` = 2.36756017450177,
        `par[2]` = -0.184380313221117
      ), value = -12.3455805163068,
      counts = c(`function` = 34L, gradient = 15L), convergence = 0L,
      message = NULL, hessian = structure(c(
        -14.4594144209087,
        9.2326146727828e-07, 9.2326146727828e-07, -20.0000199326311
      ), .Dim = c(2L, 2L), .Dimnames = list(c("par[1]", "par[2]"), c("par[1]", "par[2]")))
    )
  ), class = "ml_analysis"))
})

test_that("ml_analyse fixed parameter", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(10, 2, 1.5), par = c(1.5, NA))
  expect_error(
    ml_analyse(expr, pars = list(par = c(0, 0)), data = data),
    "^Duplicate terms must not be defined in `data` and `pars`[.]$"
  )

  object <- ml_analyse(expr, pars = list(par = c(NA, 0)), data = data)

  expect_equal(object, structure(list(
    expr = "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))",
    pars = structure(list(par = c(NA, 0)), class = "nlist"),
    data = structure(list(x = c(
      1.51094526422692, 2.82869278312871,
      0.987584234066254, 2.32153918856514, 2.4661538259704, 3.76094943134405,
      2.92818478343895, 1.83089852786868, 3.37554243426907, 1.66511095305911
    ), par = c(1.5, NA)), class = "nlist"), optim = list(
      par = c(`par[2]` = 0.183794587081123),
      value = -16.0273406365919, counts = c(
        `function` = 9L,
        gradient = 4L
      ), convergence = 0L, message = NULL, hessian = structure(-20.0000644010601, .Dim = c(
        1L,
        1L
      ), .Dimnames = list("par[2]", "par[2]"))
    )
  ), class = "ml_analysis"))
})
