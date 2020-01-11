
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ml

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.com/poissonconsulting/ml.svg?branch=master)](https://travis-ci.com/poissonconsulting/ml)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/poissonconsulting/ml?branch=master&svg=true)](https://ci.appveyor.com/project/poissonconsulting/ml)
[![Codecov test
coverage](https://codecov.io/gh/poissonconsulting/ml/branch/master/graph/badge.svg)](https://codecov.io/gh/poissonconsulting/ml?branch=master)
[![License:
MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
<!-- [![Tinyverse status](https://tinyverse.netlify.com/badge/ml)](https://CRAN.R-project.org/package=ml) -->
<!-- [![CRAN status](https://www.r-pkg.org/badges/version/ml)](https://cran.r-project.org/package=ml) -->
<!-- ![CRAN downloads](https://cranlogs.r-pkg.org/badges/ml) -->
<!-- badges: end -->

`ml` is an R package to perform Maximum Likelihood analysis using R
expressions.

It is designed to be simple but flexible.

## Demonstration

### Flexible Analyses

``` r
library(ml)

# the R expression is currently passed as unparsed text
# it should evaluate to the log likelihood
expr <- "sum(dnorm(len, mu, b[1,1] + b[1,2], log = TRUE))"

# the list of parameters can include arrays and matrices
# the values are the initial values (NAs are fixed at 0)
pars <- list(mu = 20, b = matrix(c(8, NA), ncol = 2))

# data can be a data.frame or list of numeric atomic objects
data <- datasets::ToothGrowth

# perform the analysis
analysis <- ml_analyse(expr, pars = pars, data = data)

# glance at the analysis
glance(analysis)
#>   df    logLik      AIC converged
#> 1  2 -206.7091 417.4181      TRUE

# the coefficient table includes svalues (in place of pvalues).
tidy(analysis)
#>     term  estimate        sd     lower     upper    svalue
#> 1     mu 18.813413 0.9792587 16.894101 20.732724 270.84065
#> 2 b[1,1]  7.585305 0.6924406  6.228146  8.942464  90.35263
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

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/poissonconsulting/ml/blob/master/CODE_OF_CONDUCT.md).
By contributing, you agree to abide by its terms.
