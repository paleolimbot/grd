
#' Plot grid objects
#'
#' @inheritParams wk::wk_plot
#' @param image A raster or nativeRaster to pass to [graphics::rasterImage()].
#'   use `NULL` to do a quick-and-dirty rescale of the data such that the low
#'   value is black and the high value is white.
#' @param border Color to use for polygon borders. Use `NULL` for the default
#'   and `NA` to skip plotting borders.
#' @param interpolate Use `TRUE` to perform interpolation between color values.
#'
#' @return `x`, invisibly.
#' @export
#' @importFrom graphics plot
#'
#' @examples
#' plot(grd_rct(volcano))
#' plot(grd_xy(volcano))
#'
plot.wk_grd_xy <- function(x, ...) {
  plot(as_xy(x), ...)
  invisible(x)
}

#' @rdname plot.wk_grd_xy
#' @export
plot.wk_grd_rct <- function(x, ...,
                            image = NULL,
                            interpolate = FALSE,
                            border = NA,
                            asp = 1, bbox = NULL, xlab = "", ylab = "",
                            add = FALSE) {
  if (!add) {
    bbox <- unclass(bbox)
    bbox <- bbox %||% unclass(wk_bbox(x))
    xlim <- c(bbox$xmin, bbox$xmax)
    ylim <- c(bbox$ymin, bbox$ymax)

    graphics::plot(
      numeric(0),
      numeric(0),
      xlim = xlim,
      ylim = ylim,
      xlab = xlab,
      ylab = ylab,
      asp = asp
    )
  }

  # empty raster can skip plotting
  rct <- unclass(x$bbox)
  if (identical(rct$xmax - rct$xmin, -Inf) || identical(rct$ymax - rct$ymin, -Inf)) {
    return(invisible(x))
  }

  # as.raster() takes care of the default details here
  # call with native = TRUE, but realize this isn't implemented
  # everywhere (so we may get a regular raster back)
  if (is.null(image)) {
    image <- as.raster(x, native = TRUE)
  }

  if (!inherits(image, "nativeRaster")) {
    image <- as.raster(x, native = TRUE)
  }

  graphics::rasterImage(
    image,
    rct$xmin, rct$ymin, rct$xmax, rct$ymax,
    interpolate = interpolate
  )


  if (!identical(border, NA)) {
    if (is.null(border)) {
      border <- graphics::par("fg")
    }

    # simplify borders by drawing segments
    nx <- dim(x$data)[2]
    ny <- dim(x$data)[1]
    width <- rct$xmax - rct$xmin
    height <- rct$ymax - rct$ymin
    xs <- seq(rct$xmin, rct$xmax, by = width / nx)
    ys <- seq(rct$ymin, rct$ymax, by = height / ny)
    graphics::segments(xs, rct$ymin, xs, rct$ymax, col = border)
    graphics::segments(rct$xmin, ys, rct$xmax, ys, col = border)
  }

  invisible(x)
}
