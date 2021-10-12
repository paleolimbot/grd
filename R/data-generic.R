
#' Wrap data sources with non-standard ordering
#'
#' @inheritParams grd_data
#' @param data_order A character vector with the
#'   same length as `dim(grid_data)` specifying the
#'   axis order and axis direction of indices in the
#'   x y direction. The default `c("y", "x")` indicates
#'   column-major ordering with y values decreasing
#'   in the positive i index direction and x values increasing
#'   in the positive j index direction. Use `"-y"` or `"-x"` to
#'   switch axis directions. Use `NA` to indicate a non-xy
#'   dimension.
#'
#' @return An object of class `grd_data_generic`.
#' @export
#'
grd_data_generic <- function(grid_data,
                             data_order = grd_data_order(grid_data),
                             ptype = grd_data_ptype(grid_data)) {
  stopifnot(
    length(data_order) == length(dim(grid_data))
  )

  structure(
    list(
      grid_data = grid_data,
      data_order = data_order,
      ptype = ptype
    ),
    class = "grd_data_generic"
  )
}

#' @export
dim.grd_data_generic <- function(x) {
  axis_order <- gsub("^-", "", x$data_order)
  xy <- c(which(axis_order == "y"), which(axis_order == "x"))
  dims <- dim(x$grid_data)
  dims[c(xy, setdiff(seq_along(dims), xy))]
}

#' @export
grd_data_ptype.grd_data_generic <- function(grid_data) {
  grid_data$ptype
}

#' @export
grd_data_order.grd_data_generic <- function(grid_data) {
  grid_data$data_order
}

#' @export
`[.grd_data_generic` <- function(x, ..., drop = FALSE) {
  # doesn't make sense with drop argument
  stopifnot(identical(drop, FALSE), ...length() == length(dim(x)))

  # requires some magic to rearrange arguments that may be missing
  call <- match.call()
  call[[1]] <- `[`
  call[[2]] <- x$grid_data
  call$drop <- FALSE

  axis_order <- gsub("^-", "", x$data_order)
  xy <- c(which(axis_order == "y"), which(axis_order == "x"))

  # apply index reverse if needed
  xy_rev <- grepl("^-", x$data_order[!is.na(x$data_order)])
  dims <- dim(x$grid_data)

  if (!identical(call[[2L + xy[1]]], quote(expr = ))) {
    if (xy_rev[1]) {
      i <- dims[xy[1]] - ...elt(xy[1]) + 1L
      i[i <= 0 | i > dims[xy[1]]] <- NA_integer_
      call[[2L + xy[1]]] <- i
    } else {
      call[[2L + xy[1]]] <- ...elt(xy[1])
    }
  }

  if (!identical(call[[2L + xy[2]]], quote(expr = ))) {
    if (xy_rev[2]) {
      j <- dims[xy[2]] - ...elt(xy[2]) + 1L
      j[j <= 0 | j > dims[xy[2]]] <- NA_integer_
      call[[2L + xy[2]]] <- j
    } else {
      call[[2L + xy[2]]] <- ...elt(xy[2])
    }
  }

  call[seq_len(...length()) + 2L] <- call[c(xy, setdiff(seq_along(dims), xy)) + 2L]
  x$grid_data <- eval(call, envir = parent.frame())
  x
}
