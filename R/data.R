
#' Grid data interface
#'
#' @inheritParams grd_summary
#' @param grid_data The `data` member of a [grd()].
#' @param i,j 1-based index values. `i` indices correspond to decreasing
#'   `y` values; `j` indices correspond to increasing `x` values.
#'   Values outside the range `1:nrow|ncol(data)` will be censored to
#'   `NA` including 0 and negative values.
#' @param ... Passed to S3 methods.
#'
#' @return
#'   - `grd_data()` returns the data member of a [grd()].
#'   - `grd_data_subset()` returns a subset of the data independent of the
#'     parent [grd()] but using the same indexing rules as [grd_subset()].
#'   - `grd_data_order()` returns `c("y", "x")` for
#'     data with a column-major internal ordering and
#'     `c("x", "y")` for data with a row-major internal
#'     ordering. Both 'x' and 'y' can be modified with
#'     a negative sign to indicate right-to-left
#'     or bottom-to-top ordering, respectively.
#' @export
#'
#' @examples
#' grd_data(grd(nx = 3, ny = 2))
#' grd_data_subset(matrix(1:6, nrow = 2), 2, 3)
#'
grd_data <- function(grid) {
  grid$data
}

#' @rdname grd_data
#' @export
grd_data_subset <- function(grid_data, i = NULL, j = NULL, ...) {
  UseMethod("grd_data_subset")
}

#' @rdname grd_data
#' @export
grd_data_subset.default <- function(grid_data, i = NULL, j = NULL, ...) {
  ij <- ij_from_args(i, j)
  ij$i <- ij_expand_one(ij$i, dim(grid_data)[1], out_of_bounds = "censor")
  ij$j <- ij_expand_one(ij$j, dim(grid_data)[2], out_of_bounds = "censor")

  # we want to keep everything for existing dimensions
  # this means generating a list of missings to fill
  # the correct number of additional dimensions
  n_more_dims <- length(dim(grid_data)) - 2L
  more_dims <- alist(1, )[rep(2, n_more_dims)]
  do.call("[", c(list(grid_data, ij$i, ij$j), more_dims, list(drop = FALSE)))
}

#' @rdname grd_data
#' @export
grd_data_subset.nativeRaster <- function(grid_data, i = NULL, j = NULL, ...) {
  ij <- ij_from_args(i, j)
  ij$i <- ij_expand_one(ij$i, dim(grid_data)[1], out_of_bounds = "censor")
  ij$j <- ij_expand_one(ij$j, dim(grid_data)[2], out_of_bounds = "censor")

  # special case the nativeRaster, whose dims are lying about
  # the ordering needed to index it
  attrs <- attributes(grid_data)
  dim(grid_data) <- rev(dim(grid_data))
  grid_data <- grid_data[ij$j, ij$i, drop = FALSE]
  attrs$dim <- rev(dim(grid_data))
  attributes(grid_data) <- attrs
  grid_data
}

#' @rdname grd_data
#' @export
grd_data_order <- function(grid_data) {
  UseMethod("grd_data_order")
}

#' @rdname grd_data
#' @export
grd_data_order.default <- function(grid_data) {
  c("y", "x")
}

#' @rdname grd_data
#' @export
grd_data_order.nativeRaster <- function(grid_data) {
  c("x", "y")
}
