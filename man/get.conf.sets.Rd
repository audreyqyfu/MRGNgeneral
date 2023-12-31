% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get.conf.sets.R
\name{get.conf.sets}
\alias{get.conf.sets}
\title{Select confounding variables for a genomic network}
\usage{
get.conf.sets(
  data,
  scale.data = TRUE,
  n_v,
  n_t,
  n_c,
  skip.V = FALSE,
  skip.T = FALSE,
  skip.C = FALSE,
  T.measure = c("partial", "marginal"),
  C.measure = T.measure,
  blocksize = 100,
  FDRcontrol = c("qvalue", "bonferroni", "none"),
  V.FDRcontrol = FDRcontrol,
  T.FDRcontrol = FDRcontrol,
  C.FDRcontrol = FDRcontrol,
  WZ.FDRcontrol = FDRcontrol,
  adjust_by = c("individual", "all", "none"),
  V.adjust_by = adjust_by,
  T.adjust_by = adjust_by,
  C.adjust_by = adjust_by,
  WZ.adjust_by = adjust_by,
  fdr = 0.05,
  lambda = 0.05,
  pi0.method = c("smoother", "boostrap"),
  alpha = 0.01,
  parallel = FALSE,
  cl = parallel::getDefaultCluster(),
  chunk.size = NULL,
  verbose = 0,
  save.list = FALSE,
  save.path = "/path/to/save/location/"
)
}
\arguments{
\item{data}{\code{matrix} or \code{dataframe} of size \code{N} samples by \code{m} variables
where the first \code{n_v} columns represents genetic variants, the following
\code{n_t} columns represent target genes (e.g. expression values), and the next \code{n_c} columns
represent potential confounding variables (e.g. sex, age, other genes).
Hence \code{m} must equal \code{n_t+n_v+n_c} or more.}

\item{scale.data}{logical scalar, should the data be scaled before processing?
Scaling refers here to standardization, \code{i.e.} subtracting the sample mean
and dividing by the sample standard deviation as achieved by \link{scale}. Only
genes and confounders are scaled, variants are not scaled even when
\code{scale.data = TRUE} (the default).}

\item{n_v, n_t, n_c}{numeric scalars, numbers of respectively \code{T}-nodes (genes/expression),
\code{V}-nodes (variants) and \code{C}-nodes (candidate confounding variables) in the
genomic network. The number of columns of \code{data} must be \code{n_t+n_v+n_c} or more.}

\item{skip.V, skip.T, skip.C}{logical, should the selection of respectively
\code{V}-nodes, \code{T}-nodes, or \code{C}-nodes be skipped? If \code{TRUE},
the corresponding selection is skipped and an empty list is returned. This can be
useful when a dataset is expanded with only one or two types of nodes, and there
is no need to select again confounding variables from the set(s) that remained unchanged.}

\item{T.measure, C.measure}{characters, indicating the association measures to
be used for different selections. One of \code{"partial"} for conditional
Pearson's correlation given \code{V}-nodes, and \code{"marginal"} for correlation
coefficient. The measure used for \code{V}-nodes selection is always the
marginal correlation coefficient.}

\item{FDRcontrol, T.FDRcontrol, C.FDRcontrol, V.FDRcontrol}{characters indicating
the FDR control methods to be used for different selections.
One of \code{"none"}, \code{"qvalue"} (see \link[qvalue]{qvalue}), or
\code{"bonferroni"} (see \link[stats]{p.adjust}).
If any of \code{T.FDRcontrol}, \code{C.FDRcontrol}, \code{V.FDRcontrol} is missing,
\code{FDRcontrol} is used, otherwise \code{FDRcontrol} is ignored.}

\item{adjust_by, T.adjust_by, C.adjust_by, V.adjust_by}{character indicating the
adjustment scheme for tests. One of \code{"none"} (no adjustment is desired),
\code{"individual"} (adjust p-values for each gene separately),
and \code{"all"} (adjust all p-values for all genes at once).
If any of \code{T.adjust_by}, \code{C.adjust_by}, \code{V.adjust_by} is missing,
\code{adjust_by} is used, otherwise \code{adjust_by} is ignored.}

\item{fdr, lambda, pi0.method, alpha}{See \link[MRGN]{get.conf.matrix}
(\code{selection_fdr} is used there for \code{fdr}).}

\item{parallel}{logical, should computations be parallelized?}

\item{cl, chunk.size}{a cluster object (\code{cl}) for parallel computations,
and a numeric scalar (\code{chunk.size}) to schedule parallel tasks.
Only used if \code{parallel = TRUE}.}

\item{save.list}{(logical) if TRUE the output is saved as a \code{.RData}
object (default = FALSE).}

\item{save.path}{string specifying the path name of the output list to be save
as a \code{.RData} structure. Only used if \code{save.list = TRUE}.}
}
\value{
an object of class \code{'conf.sets'}, i.e. a named list with elements:
\describe{
\item{\code{Vconfounders}}{a list of length \code{n_t} giving the vector of
\code{V}-nodes selected as confounders for each of the \code{n_t}
\code{T}-nodes in the network.}
\item{\code{Tconfounders}}{a list of length \code{n_t} giving the vector of
\code{T}-nodes selected as confounders for each of the \code{n_t}
\code{T}-nodes in the network.}
\item{\code{Uconfounders}}{a list of length \code{n_t} giving the vector of
\code{U}-nodes selected as confounders for each of the \code{n_t}
\code{T}-nodes in the network.}
\item{\code{confounders}}{a list of length \code{n_t} obtained as
\code{lbind(Vconfounders, Tconfounders, Uconfounders)}.}
\item{\code{UWZconfounders}}{a list of length \code{n_t} giving the vector of
\code{U,W,Z}-nodes selected as confounders for each of the \code{n_t}
\code{T}-nodes in the network.}
\item{\code{WZconfounders}}{a list of length \code{n_v} giving the vector of
\code{W,Z}-nodes identified as associated to each of the \code{n_v}
\code{V}-nodes in the network.}
\item{\code{UWZindices}}{a vector giving the pool of all selected
\code{U,W,Z}-nodes.}
\item{\code{WZindices}}{a vector giving the pool of all selected
\code{W,Z}-nodes.}
\item{\code{raw}}{a list of the raw results (as returned by
\link[MRGN]{get.conf.matrix}) for each selection step.}
\item{\code{time}}{a list of the CPU time (as returned by
\link{system.time}) for each selection step.}
\item{new.order}{ \code{NULl} (not returned by this function),
but can be a numeric vector of new column-orders used to alter other slots
(except \code{time}), see \link{reorder.conf.sets}.}
}
}
\description{
Build a set of confounding variables for genes in a genomic network including
genes (e.g. expression values), genetic variants, and confounding variables (e.g. sex, age,
PC scores from whole-genome expression) by testing marginal or partial associations
of each potential confounding variable and each gene. For each gene, the function
finds variants and/or other genes (in the network) that can confound the
regulatory mechanisms between a particular gene and another target gene.
}
\details{
For a graph \code{G(V, T, C)} where \code{V} is the set of genetic variants,
\code{T} is the set of gene expressions, and \code{C} is the set of candidate
confounding variables in the network; \code{get.conf.sets} performs
three independent tasks.
\describe{
\item{V-node selection:}{ the \emph{marginal} association between each gene (\code{T}-node) and
each variant (\code{V}-node) is tested using a \emph{t}-test. If none of \code{V.adjust_by}
and \code{adjust_by} is \code{'none'}, then either all the tests involving a
particular \code{T}-node (when \code{adjust_by = 'individual'}), or all the tests
involving all \code{T}-nodes (when \code{adjust_by = 'all'}) are adjusted for
multiple comparison using the method \code{V.FDRcontrol}. All \code{V}-nodes
significantly associated with a particular \code{T}-node are then retained as
selected confounders for the \code{T}-node.}
\item{T-node selection:}{ the process is similar to \emph{V-node selection} except
that here, the associations between each \code{T}-node and all other \code{T}-nodes
in the network are tested, and the association measure between two \code{T}-nodes can
be partial (the default) or marginal correlation (specified via \code{T.measure}).
When \code{T.measure = "partial"}, partial correlations are computed given all
\code{V}-nodes in the network, and \emph{z}-tests are used instead of \emph{t}-tests.}
\item{C-node selection:}{ this step has two sub-steps. The first sub-step is a pre-selection
which is similar to \emph{T-node selection}, except that the association of each \code{T}-node
with each \code{C}-node is tested. The results is a pool of confounding variables
that can include true confounders (\code{U}-nodes) on one hand (\code{U}-nodes
are marginally uncorrelated with the \code{V}-nodes in the network), and
intermediate variables (\code{W}-node) and common children (\code{Z}-node)
on the other hand (\code{W} and \code{Z}-nodes are marginally correlated
with some \code{V}-nodes). The second sub-step thus tests for marginal
association between all \code{V}-nodes and each pre-selected \code{C}-node,
to assign the later as a confounder (\code{U}-node) or not (\code{W} or
\code{Z}-node).}
}

Correlation matrices are computed using \link[propagate]{bigcor} which is
more efficient in large datasets \insertCite{Spiess2018propagate}{MRGNgeneral}.
Partial correlations are obtained using \link[ppcor]{pcor} \insertCite{kim2015ppcor}{MRGNgeneral}.
The \code{C}-node selection step follows
\insertCite{yang2017identifying}{MRGNgeneral}.
}
\examples{
## Simulate some data with 20 phenotypes
set.seed(167)
net20data <- sample.graph.data (n_t = 20,
                                n_v.t = 1,
                                family.n_v = NULL,
                                conf.num.vec = c(W = 10, Z = 10,
                                                 U = 40, K = 0, I = 20),
                                graph_type = "scale-free",
                                degree = 3,
                                theta = .4,
                                b0 = 0,
                                b.snp = c(-0.5, 0.5),
                                b.med = c(-0.8, 0.8),
                                sigma = 0.1,
                                neg.freq = 0.5,
                                conf.coef.ranges = list(W = c(0.4, 0.5),
                                                        Z = c(1, 1.5),
                                                        U = c(0.4, 0.5),
                                                        K = c(0.01, 0.1)),
                                scale = FALSE,
                                sample.size = 100)

## Performing confounding variable selection
confnet20 <- get.conf.sets(data = net20data$data,
                           n_v = net20data$dims$n_v,
                           n_t = net20data$dims$n_t,
                           n_c = NCOL(net20data$data) - net20data$dims$n_v - net20data$dims$n_t,
                           blocksize = 10,
                           T.measure = 'partial',
                           C.measure = 'partial',
                           FDRcontrol = 'qvalue',
                           adjust_by = 'individual',
                           alpha = 0.01,
                           fdr = 0.05,
                           lambda = 0.05,
                           pi0.method = 'smoother')

## Recall and precision of the selection procedure
Perf <- assess.conf.selection (confnet20,
                               adjacency = net20data$adjacency,
                               n_v = net20data$dims$n_v,
                               n_t = net20data$dims$n_t,
                               n_w = net20data$dims$n_w,
                               n_z = net20data$dims$n_z,
                               n_u = net20data$dims$n_u)
Perf$recall
Perf$precision

}
\references{
\insertAllCited{}
}
\seealso{
\link{assess.conf.selection} to evaluate the performance of the
selection procedure given the adjacency matrix of the true network.
}
