
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ml

<!-- badges: start -->

[![Lifecycle:
deprecated](https://img.shields.io/badge/lifecycle-deprecated-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#deprecated)
[![License:
MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
<!-- [![Tinyverse status](https://tinyverse.netlify.com/badge/ml)](https://CRAN.R-project.org/package=ml) -->
<!-- [![CRAN status](https://www.r-pkg.org/badges/version/ml)](https://cran.r-project.org/package=ml) -->
<!-- ![CRAN downloads](https://cranlogs.r-pkg.org/badges/ml) -->
<!-- badges: end -->

`ml` is an R package to fit R expression based Maximum Likelihood
models.

It is designed to be simple but flexible.

## Demonstration

### Flexible Analyses

``` r
library(ml)
library(tibble)

# the R expression is currently passed as unparsed text
# it should evaluate to the log likelihood
expr <- "sum(dnorm(len, mu, b[1,1] + b[1,2], log = TRUE))"

# the list of starting can include arrays and matrices
# the values are the initial values (NAs are fixed at 0)
start <- list(mu = 20, b = matrix(c(8, NA), ncol = 2))

# data can be a data.frame or list of numeric atomic objects
data <- datasets::ToothGrowth

# perform the analysis
analysis <- ml_fit(expr, start = start, data = data)

# glance at the analysis
glance(analysis)
#> # A tibble: 1 x 4
#>      df logLik   AIC converged
#>   <int>  <dbl> <dbl> <lgl>    
#> 1     2  -207.  417. TRUE

# the coefficient table includes svalues (in place of pvalues)
tidy(analysis)
#> # A tibble: 2 x 6
#>   term   estimate    sd lower upper svalue
#>   <term>    <dbl> <dbl> <dbl> <dbl>  <dbl>
#> 1 mu        18.8  0.979 16.9  20.7   271. 
#> 2 b[1,1]     7.59 0.692  6.23  8.94   90.4
```

## Installation

<!-- To install the latest release from [CRAN](https://cran.r-project.org) -->

To install the developmental version from
[GitHub](https://github.com/poissonconsulting/ml)

``` r
# install.packages("remotes")
remotes::install_github("poissonconsulting/ml")
```

To install the latest developmental release from the Poisson drat
[repository](https://github.com/poissonconsulting/drat)

``` r
# install.packages("drat")
drat::addRepo("poissonconsulting")
install.packages("ml")
```

## Contribution

Please report any
[issues](https://github.com/poissonconsulting/ml/issues).

[Pull requests](https://github.com/poissonconsulting/ml/pulls) are
always welcome.

Please note that the ml project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
