
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggtda

[![Travis-CI Build
Status](https://travis-ci.org/rrrlw/ggtda.svg?branch=master)](https://travis-ci.org/rrrlw/ggtda)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/rrrlw/ggtda?branch=master&svg=true)](https://ci.appveyor.com/project/rrrlw/ggtda)
[![Coverage
Status](https://img.shields.io/codecov/c/github/rrrlw/ggtda/master.svg)](https://codecov.io/github/rrrlw/ggtda?branch=master)

[![License: GPL
v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![CRAN
version](http://www.r-pkg.org/badges/version/ggtda)](https://CRAN.R-project.org/package=ggtda)
[![CRAN
Downloads](http://cranlogs.r-pkg.org/badges/grand-total/ggtda)](https://CRAN.R-project.org/package=ggtda)

## Overview

The **ggtda** package provides **ggplot2** layers for the visualization
of persistence data and other summary data arising from topological data
analysis.

## Installation

The development version of **ggtda** can be installed used the
**remotes** package:

``` r
# install from GitHub
remotes::install_github("rrrlw/ggtda", vignettes = TRUE)
#> Downloading GitHub repo rrrlw/ggtda@master
#> ggplot2 (3.1.0 -> 3.1.1) [CRAN]
#> rlang   (0.3.3 -> 0.3.4) [CRAN]
#> Installing 2 packages: ggplot2, rlang
#> Installing packages into '/private/var/folders/gf/zt09cmj52pn18v2vlp_2d3w80000gp/T/Rtmp3WUAdL/temp_libpath4a0b49092ea9'
#> (as 'lib' is unspecified)
#> 
#> The downloaded binary packages are in
#>  /var/folders/gf/zt09cmj52pn18v2vlp_2d3w80000gp/T//Rtmp3WUAdL/downloaded_packages
#>   
   checking for file ‘/private/var/folders/gf/zt09cmj52pn18v2vlp_2d3w80000gp/T/Rtmp3WUAdL/remotes4a0b55e62924/rrrlw-ggtda-1e1744e/DESCRIPTION’ ...
  
✔  checking for file ‘/private/var/folders/gf/zt09cmj52pn18v2vlp_2d3w80000gp/T/Rtmp3WUAdL/remotes4a0b55e62924/rrrlw-ggtda-1e1744e/DESCRIPTION’
#> 
  
─  preparing ‘ggtda’:
#> 
  
   checking DESCRIPTION meta-information ...
  
✔  checking DESCRIPTION meta-information
#> 
  
─  installing the package to process help pages
#> 
  
─  saving partial Rd database (1.6s)
#> 
  
─  checking for LF line-endings in source and make files and shell scripts
#> 
  
─  checking for empty or unneeded directories
#> ─  looking to see if a ‘data/datalist’ file should be added
#> 
  
   
#> 
  
─  building ‘ggtda_0.1.0.tar.gz’
#> 
#> Installing package into '/private/var/folders/gf/zt09cmj52pn18v2vlp_2d3w80000gp/T/Rtmp3WUAdL/temp_libpath4a0b49092ea9'
#> (as 'lib' is unspecified)
```

For an introduction to **ggtda** functionality, read the vignettes:

``` r
# read vignettes
vignette(topic = "intro-ggtda", package = "ggtda")
#> Warning: vignette 'intro-ggtda' not found
```

We aim to submit ggtda to [CRAN](https://CRAN.R-project.org) soon.

## Example

**ggtda** visualizes persistence data but also includes stat layers for
common TDA constructions. This example illustrates them together. First,
generate an artificial “noisy circle” data set and calculate its
persistent homology (PH) using the **TDAstats** package, which ports the
`ripser` implementation into R:

``` r
# generate a noisy circle
n <- 36; sd <- .2
set.seed(0)
t <- stats::runif(n = n, min = 0, max = 2*pi)
d <- data.frame(
  x = cos(t) + stats::rnorm(n = n, mean = 0, sd = sd),
  y = sin(t) + stats::rnorm(n = n, mean = 0, sd = sd)
)
# compute the persistent homology
ph <- as.data.frame(TDAstats::calculate_homology(as.matrix(d), dim = 1))
ph <- transform(ph, dimension = as.factor(dimension))
```

Second, pick an example proximity, or diameter, at which to recognize
features in the persistence data. This choice corresponds to a specific
Čech complex in the filtration underlying the calculation of PH. It is
not the best way to identify features (it ignores persistence), but it
is easy to link back to the geometric construction.

``` r
# attach *ggtda*
library(ggtda)
#> Loading required package: ggplot2
# fix a proximity for a Čech complex
prox <- 2/3
# visualize disks of fixed radii and the Čech complex for this proximity
p_d <- ggplot(d, aes(x = x, y = y)) +
  theme_bw() +
  coord_fixed() +
  stat_disk(radius = prox/2, fill = "aquamarine3", alpha = .15) +
  geom_point()
p_sc <- ggplot(d, aes(x = x, y = y)) +
  theme_bw() +
  coord_fixed() +
  stat_cech2(diameter = prox, fill = "darkgoldenrod", alpha = .1) +
  stat_cech1(diameter = prox, alpha = .25) +
  stat_cech0()
# visualize the persistence data, indicating cutoffs at this proximity
p_bc <- ggplot(ph,
       aes(start = birth, end = death, colour = dimension)) +
  theme_tda() +
  geom_barcode() +
  geom_vline(xintercept = prox, color = "darkgoldenrod", linetype = "dashed")
p_pd <- ggplot(ph,
       aes(start = birth, end = death, colour = dimension)) +
  theme_tda() +
  stat_persistence() +
  lims(x = c(0, NA), y = c(0, NA)) +
  geom_abline(
    intercept = prox, slope = - 1,
    color = "darkgoldenrod", linetype = "dashed"
  )
# combine the plots
gridExtra::grid.arrange(
  p_d, p_sc, p_bc, p_pd,
  layout_matrix = matrix(c(1,3, 2,4), nrow = 2)
)
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

## Contribute

To contribute to **ggtda**, you can create issues for any bugs you find
or any suggestions you have on the [issues
page](https://github.com/rrrlw/ggtda/issues).

If you have a feature in mind you think will be useful for others, you
can also [fork this
repository](https://help.github.com/en/articles/fork-a-repo) and [create
a pull
request](https://help.github.com/en/articles/creating-a-pull-request).
