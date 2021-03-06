% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\name{grd_data}
\alias{grd_data}
\alias{grd_data_ptype}
\alias{grd_data_ptype.array}
\alias{grd_data_collect}
\alias{grd_data_collect.array}
\alias{grd_data_subset}
\alias{grd_data_subset.default}
\alias{grd_data_subset.nativeRaster}
\alias{grd_data_order}
\alias{grd_data_order.default}
\alias{grd_data_order.nativeRaster}
\title{Grid data interface}
\usage{
grd_data(grid)

grd_data_ptype(grid_data)

\method{grd_data_ptype}{array}(grid_data)

grd_data_collect(
  grid_data,
  i = NULL,
  j = NULL,
  ...,
  ptype = grd_data_ptype(grid_data)
)

\method{grd_data_collect}{array}(
  grid_data,
  i = NULL,
  j = NULL,
  ...,
  ptype = grd_data_ptype(grid_data)
)

grd_data_subset(grid_data, i = NULL, j = NULL, ...)

\method{grd_data_subset}{default}(grid_data, i = NULL, j = NULL, ...)

\method{grd_data_subset}{nativeRaster}(grid_data, i = NULL, j = NULL, ...)

grd_data_order(grid_data)

\method{grd_data_order}{default}(grid_data)

\method{grd_data_order}{nativeRaster}(grid_data)
}
\arguments{
\item{grid}{A \code{\link[=grd_xy]{grd_xy()}}, \code{\link[=grd_rct]{grd_rct()}}, or other object
implementing \verb{grd_*()} methods.}

\item{grid_data}{The \code{data} member of a \code{\link[=grd]{grd()}}. This is typically an
array but can also be an S3 object with the proper methods
implemented (e.g., \code{\link[=grd_data_generic]{grd_data_generic()}}).}

\item{i, j}{1-based index values. \code{i} indices correspond to decreasing
\code{y} values; \code{j} indices correspond to increasing \code{x} values.
Values outside the range \code{1:nrow|ncol(data)} will be censored to
\code{NA} including 0 and negative values.}

\item{...}{Passed to S3 methods.}

\item{ptype}{The R object type that should be used to represent
the data.}
}
\value{
\itemize{
\item \code{grd_data()} returns the data member of a \code{\link[=grd]{grd()}}.
\item \code{grd_data_subset()} returns a subset of the data independent of the
parent \code{\link[=grd]{grd()}} but using the same indexing rules as \code{\link[=grd_subset]{grd_subset()}}.
The non-xy dimensions of \code{grid_data} are not affected.
\item \code{grd_data_order()} returns \code{c("y", "x")} for
data with a column-major internal ordering and
\code{c("x", "y")} for data with a row-major internal
ordering. Both 'x' and 'y' can be modified with
a negative sign to indicate right-to-left
or bottom-to-top internal ordering, respectively. This value
does not affect the axis order or axis direction used to index
in \code{\link[=grd_subset]{grd_subset()}} or \code{\link[=grd_data_subset]{grd_data_subset()}}.
}
}
\description{
Grid data interface
}
\examples{
grd_data(grd(nx = 3, ny = 2))
grd_data_subset(matrix(1:6, nrow = 2), 2, 3)

}
