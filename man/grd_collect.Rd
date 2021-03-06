% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/collect.R
\name{grd_collect}
\alias{grd_collect}
\alias{grd_collect.default}
\title{Collect a grid in memory}
\usage{
grd_collect(
  grid,
  i = NULL,
  j = NULL,
  ...,
  ptype = grd_data_ptype(grd_data(grid))
)

\method{grd_collect}{default}(
  grid,
  i = NULL,
  j = NULL,
  ...,
  ptype = grd_data_ptype(grd_data(grid))
)
}
\arguments{
\item{grid}{A \code{\link[=grd_xy]{grd_xy()}}, \code{\link[=grd_rct]{grd_rct()}}, or other object
implementing \verb{grd_*()} methods.}

\item{i}{1-based index values. \code{i} indices correspond to decreasing
\code{y} values; \code{j} indices correspond to increasing \code{x} values.
Values outside the range \code{1:nrow|ncol(data)} will be censored to
\code{NA} including 0 and negative values.}

\item{j}{1-based index values. \code{i} indices correspond to decreasing
\code{y} values; \code{j} indices correspond to increasing \code{x} values.
Values outside the range \code{1:nrow|ncol(data)} will be censored to
\code{NA} including 0 and negative values.}

\item{...}{Passed to subset methods}

\item{ptype}{The R object type that should be used to represent
the data.}
}
\value{
A \code{\link[=grd_rct]{grd_rct()}} or \code{\link[=grd_xy]{grd_xy()}}
}
\description{
Collect a grid in memory
}
\examples{
data <- grd_data_generic(volcano, data_order = c("-y", "x"))
(grid <- grd_rct(data))
grd_collect(grid)

}
