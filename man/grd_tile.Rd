% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tile.R
\name{grd_tile}
\alias{grd_tile}
\alias{grd_tile.grd_rct}
\title{Extract normalized grid tiles}
\usage{
grd_tile(grid, level, i, j = NULL, ..., ptype = grd_data_ptype(grd_data(grid)))

\method{grd_tile}{grd_rct}(grid, level, i, j = NULL, ..., ptype = grd_data_ptype(grd_data(grid)))
}
\arguments{
\item{grid}{A \code{\link[=grd_xy]{grd_xy()}}, \code{\link[=grd_rct]{grd_rct()}}, or other object
implementing \verb{grd_*()} methods.}

\item{level}{An integer describing the overview level. This is related to
the \code{step} value by a power of 2 (i.e., a level of \code{1} indicates a step of
\code{2}, a level of \code{2} indicates a step of \code{4}, etc.).}

\item{i}{1-based index values. \code{i} indices correspond to decreasing
\code{y} values; \code{j} indices correspond to increasing \code{x} values.
Values outside the range \code{1:nrow|ncol(data)} will be censored to
\code{NA} including 0 and negative values.}

\item{j}{1-based index values. \code{i} indices correspond to decreasing
\code{y} values; \code{j} indices correspond to increasing \code{x} values.
Values outside the range \code{1:nrow|ncol(data)} will be censored to
\code{NA} including 0 and negative values.}

\item{...}{Passed to S3 methods}

\item{ptype}{The R object type that should be used to represent
the data.}
}
\value{
A \code{\link[=grd_collect]{grd_collect()}}ed version
}
\description{
Extract normalized grid tiles
}
\examples{
grid <- grd_rct(volcano)
plot(grd_tile(grid, 4, 1, 1))
plot(grd_tile(grid, 3, 1, 1), add = TRUE)

}
