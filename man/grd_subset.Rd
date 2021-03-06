% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/subset.R
\name{grd_subset}
\alias{grd_subset}
\alias{grd_crop}
\alias{grd_extend}
\alias{grd_crop.grd_rct}
\alias{grd_crop.grd_xy}
\alias{grd_extend.grd_rct}
\alias{grd_extend.grd_xy}
\title{Subset grid objects}
\usage{
grd_subset(grid, i = NULL, j = NULL, ...)

grd_crop(grid, bbox, ..., step = 1L, snap = NULL)

grd_extend(grid, bbox, ..., step = 1L, snap = NULL)

\method{grd_crop}{grd_rct}(grid, bbox, ..., step = 1L, snap = NULL)

\method{grd_crop}{grd_xy}(grid, bbox, ..., step = 1L, snap = NULL)

\method{grd_extend}{grd_rct}(grid, bbox, ..., step = 1L, snap = NULL)

\method{grd_extend}{grd_xy}(grid, bbox, ..., step = 1L, snap = NULL)
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

\item{bbox}{An \code{\link[wk:rct]{wk::rct()}} object.}

\item{step}{The difference between adjascent indices in the output}

\item{snap}{A function that transforms real-valued indices to integer
indices (e.g., \code{\link[=floor]{floor()}}, \code{\link[=ceiling]{ceiling()}}, or \code{\link[=round]{round()}}).
For \code{\link[=grd_cell_range]{grd_cell_range()}}, a \code{list()} with exactly two elements to be called
for the minimum and maximum index values, respectively.}
}
\value{
A modified \code{grid} whose cell centres have not changed location
as a result of the subset.
}
\description{
The \code{\link[=grd_subset]{grd_subset()}} method handles the subsetting of a \code{\link[=grd]{grd()}}
in x-y space. Ordering of indices is not considered and logical
indies are recycled silently along dimensions. The result of
a \code{\link[=grd_subset]{grd_subset()}} is always a \code{\link[=grd]{grd()}} of the same type whose
relationship to x-y space has not changed.
}
\examples{
grid <- grd_rct(volcano)
grd_subset(grid, 1:20, 1:30)
grd_crop(grid, rct(-10, -10, 10, 10))
grd_extend(grid, rct(-10, -10, 10, 10))

}
