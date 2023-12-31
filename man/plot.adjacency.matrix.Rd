% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot.adjacency.matrix.R
\name{plot.adjacency.matrix}
\alias{plot.adjacency.matrix}
\title{Plot an adjacency matrix}
\usage{
# S3 method for class 'adjacency.matrix'
plot(adjacency, ...)
}
\arguments{
\item{adjacency}{A square matrix of class \code{adjacency}. This is passed to
\link{is.adjacency.matrix} for checking.}

\item{n_vt}{numeric, the total number of \code{V} and \code{T} nodes
of the graph represented by \code{adjacency}. The default (\code{NULL}) is all. When
specified, \code{n_vt} must be less than or equal to \code{NCOL(adjacency)}.}

\item{mode}{Character scalar, specifies how \code{igraph} should interpret the
supplied matrix. See \code{graph_from_adjacency_matrix} in the library
\code{igraph} for details.}

\item{layout}{Either a function or a numeric matrix. It specifies how the
vertices will be placed on the plot. See \code{igraph.plotting} in the
library \code{igraph} for details.}

\item{vertex.color, edge.arrow.size, ...}{Additional plotting parameters.
See \code{igraph.plotting} in the library \code{igraph} for the complete list.}
}
\value{
Returns \code{NULL}, invisibly.
}
\description{
This function takes an adjacency matrix representing an acyclic graph
and calls \link{igraph::plot.igraph} to plot the graph.
}
\details{
The function's output is random.
Set a random generator seed using \link{set.seed} for reproducibility.
}
\examples{
### Load the network 'networka11'
library(MRGNgeneral)
data(networka11)

### Adjacency matrix of a subset of the network
adjacency <- structure(
  networka11$adjacency[c('V39', 'T39', 'T43', 'T52', 'W11', 'Z2', 'U28'),
                       c('V39', 'T39', 'T43', 'T52', 'W11', 'Z2', 'U28')],
  class = 'adjacency.matrix')
adjacency

### Plot the graph of the subset
plot (adjacency)
}
