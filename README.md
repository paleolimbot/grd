
<!-- README.md is generated from README.Rmd. Please edit that file -->

# grd

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/paleolimbot/grd/branch/master/graph/badge.svg)](https://codecov.io/gh/paleolimbot/grd?branch=master)
[![R-CMD-check](https://github.com/paleolimbot/grd/workflows/R-CMD-check/badge.svg)](https://github.com/paleolimbot/grd/actions)
<!-- badges: end -->

The goal of grd is to do provide data structures and a minimal set of
generics to work with grids of points or rectrangles (i.e., raster
data). The grd package is built on top of
[wk](https://github.com/paleolimbot/wk)

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("paleolimbot/grd")
```

## Example

Use `grd_rct()` or `grd_xy()` to construct a grid from a matrix and a
`wk::rct()`.

``` r
library(grd)

bbox <- rct(
  5917000,       1757000 + 870,
  5917000 + 610, 1757000,
  crs = "EPSG:2193"
)

grid <- grd_rct(volcano, bbox)
plot(grid)
```

<img src="man/figures/README-example-1.png" width="100%" />

You can use `grd_crop()`, `grd_extend()`, or `grd_subset()` to select
parts of a grid whilst keeping each cell’s relationship to space:

``` r
plot(grd_subset(grid, 1:30, 1:30))
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

Use `grd_index()` or `grd_index_range()` to find cell indices based on a
spatial query; use `grd_cell_bounds()` or `grd_cell_center()` to get
information about specific cells:

``` r
(cell_ids <- grd_index(grid, xy(5917100, 1757700)))
#> $i
#> [1] 18
#> 
#> $j
#> [1] 11
grd_cell_bounds(grid, cell_ids)
#> <wk_rct[1] with CRS=EPSG:2193>
#> [1] [5917100 1757690 5917110 1757700]
```
