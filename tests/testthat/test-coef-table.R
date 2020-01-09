context("coef-table")

test_that("coef_table", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(10, 2, 1.5), par = c(1.5, NA))

  object <- ml_analyse(expr, pars = list(par = c(NA, 0)), data = data)
  expect_equal(as.data.frame(coef_table(object)),
               structure(list(term = structure("par[2]", class = c("term", "character"
)), estimate = 0.183794587081123), class = "data.frame", row.names = c(NA, 
-1L)))
})
