context("coef-table")

test_that("ml_coef_table", {
  set.seed(101)
  expr <- "sum(dnorm(x, par[1], exp(par[2]), log = TRUE))"
  data <- list(x = rnorm(1000, 2, exp(1.5)))

  object <- ml_analyse(expr, pars = list(par = c(1, exp(0))), data = data)
  expect_equal(as.data.frame(ml_coef_table(object)),
               structure(list(term = structure(c("par[1]", "par[2]"), class = c("term", 
"character")), estimate = c(1.84430816228133, 1.45780108358927
), sd = c(0.135867308741607, 0.0223617707697989), lower = c(1.57801313047139, 
1.41397281824993), upper = c(2.11060319409126, 1.50162934892862
), svalue = c(137.0136029432, Inf)), class = "data.frame", row.names = c("par[1]", 
"par[2]")))
})
