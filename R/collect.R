
#' Collect a grid in memory
#'
#' @inheritParams grd_subset
#'
#' @return A [grd_rct()] or [grd_xy()]
#' @export
#'
#' @examples
#' data <- grd_data_generic(volcano, data_order = c("-y", "x"))
#' (grid <- grd_rct(data))
#' grd_collect(grid)
#'
grd_collect <- function(grid, i = NULL, j = NULL, ...) {
  UseMethod("grd_collect")
}

#' @rdname grd_collect
#' @export
grd_collect.default <- function(grid, i = NULL, j = NULL, ...) {
  # use grd_subset() to calculate the bbox
  grid_empty <- grid
  grid_empty$data <- array(dim = c(dim(grid)[1:2], 0))
  subs <- grd_subset(grid_empty, i, j)

  grid$data <- grd_data_collect(grid$data, i, j, ...)
  grid$bbox <- subs$bbox
  grid
}
