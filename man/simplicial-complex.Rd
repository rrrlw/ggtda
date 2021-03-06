% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simplicial-complex.R
\name{simplicial-complex}
\alias{simplicial-complex}
\alias{stat_disk}
\alias{stat_vietoris0}
\alias{stat_vietoris1}
\alias{stat_vietoris2}
\alias{stat_cech0}
\alias{stat_cech1}
\alias{stat_cech2}
\alias{geom_face}
\title{Disks about data points and skeletons of Vietoris and Čech complexes}
\usage{
stat_disk(
  mapping = NULL,
  data = NULL,
  geom = "face",
  position = "identity",
  na.rm = FALSE,
  radius = NULL,
  diameter = NULL,
  segments = 60,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)

stat_vietoris0(
  mapping = NULL,
  data = NULL,
  geom = "point",
  position = "identity",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)

stat_vietoris1(
  mapping = NULL,
  data = NULL,
  geom = "segment",
  position = "identity",
  na.rm = FALSE,
  radius = NULL,
  diameter = NULL,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)

stat_vietoris2(
  mapping = NULL,
  data = NULL,
  geom = "face",
  position = "identity",
  na.rm = FALSE,
  radius = NULL,
  diameter = NULL,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)

stat_cech0(
  mapping = NULL,
  data = NULL,
  geom = "point",
  position = "identity",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)

stat_cech1(
  mapping = NULL,
  data = NULL,
  geom = "segment",
  position = "identity",
  na.rm = FALSE,
  radius = NULL,
  diameter = NULL,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)

stat_cech2(
  mapping = NULL,
  data = NULL,
  geom = "face",
  position = "identity",
  na.rm = FALSE,
  radius = NULL,
  diameter = NULL,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)

geom_face(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)
}
\arguments{
\item{mapping}{Set of aesthetic mappings created by \code{\link[ggplot2:aes]{aes()}} or
\code{\link[ggplot2:aes_]{aes_()}}. If specified and \code{inherit.aes = TRUE} (the
default), it is combined with the default mapping at the top level of the
plot. You must supply \code{mapping} if there is no plot mapping.}

\item{data}{The data to be displayed in this layer. There are three
options:

If \code{NULL}, the default, the data is inherited from the plot
data as specified in the call to \code{\link[ggplot2:ggplot]{ggplot()}}.

A \code{data.frame}, or other object, will override the plot
data. All objects will be fortified to produce a data frame. See
\code{\link[ggplot2:fortify]{fortify()}} for which variables will be created.

A \code{function} will be called with a single argument,
the plot data. The return value must be a \code{data.frame}, and
will be used as the layer data. A \code{function} can be created
from a \code{formula} (e.g. \code{~ head(.x, 10)}).}

\item{geom}{The geometric object to use display the data; defaults to
\code{segment} in \code{stat_vietoris1()} and to \code{face} in \code{stat_vietoris2}. Pass a
string to override the default.}

\item{position}{Position adjustment, either as a string, or the result of
a call to a position adjustment function.}

\item{na.rm}{Logical; ignored.}

\item{radius}{A positive number; the radius of the disk to render around each
point or to determine simplices from a point cloud.}

\item{diameter}{A positive number; the diameter of the disk to render around
each point or to determine simplices from a point cloud.}

\item{segments}{The number of segments to be used in drawing each disk.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.
It can also be a named logical vector to finely select the aesthetics to
display.}

\item{inherit.aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link[ggplot2:borders]{borders()}}.}

\item{...}{Additional arguments passed to \code{\link[ggplot2:layer]{ggplot2::layer()}}.}

\item{stat}{The statistical transformation to use on the data for this
layer, as a string.}
}
\description{
Annotate 2-dimensional point clouds with TDA constructions.
}
\details{
These plot layers are useful for exposition and education; they illustrate
constructions used by TDA methods but cannot be pipelined into those methods.
}
\section{Definitions}{


A \emph{ball} of radius \eqn{r} around a point \eqn{x} in Euclidean space consists
of all points whose distances from \eqn{x} are less than \eqn{r}.

The \emph{Vietoris complex} of a point cloud is a simplicial complex consisting of
a simplex for each subset of points within a fixed diameter of each other.
The \emph{Čech complex} consists of a simplex for each subset that lies within a
circle of fixed diameter. (This means that the Čech complex depends on the
geometry of the ambient space containing the point cloud, while the Vietoris
complex depends only on the inter-point distances.)

The \emph{0-skeleton} of a complex consists of its vertices (0-simplices), the
\emph{1-skeleton} additionally the edges between pairs of vertices (1-simplices),
and the \emph{2-skeleton} additionally faces among triples of vertices
(2-simplices).
}

\section{Layers}{


\code{geom_face()} is a convenience geom that is equivalent to \code{geom_polygon()}
except that its default aesthetics are more appropriate for the overlapping
elements produced by the stat layers.

Given \code{x} and \code{y} coordinates, \code{stat_vietoris1()} encodes the edges of the
Vietoris complex using \code{x}, \code{y}, \code{xend}, and \code{yend} for \code{geom_segment()}, and
\code{stat_vietoris2()} encodes the faces using \code{x}, \code{y}, and \code{group} for
\code{geom_polygon()}. The edges of a Čech complex are exactly those of the
Vietoris complex, so \code{stat_cech1()} is an alias for \code{stat_vietoris1()}, while
\code{stat_cech2()} encodes the faces of the Čech complex in the same way as
\code{stat_vietoris2()} those of the Vietoris complex. Note that these stat layers
encode only the simplices of fixed dimension; to render the 1- or 2-skeleton,
they can be combined with \code{geom_vietoris0()} or \code{geom_cech0()}, which are
aliases for \code{\link[ggplot2:stat_identity]{ggplot2::stat_identity()}} that default to
\code{\link[ggplot2:geom_point]{ggplot2::geom_point()}}.
}

\examples{

# function to generate noisy 2D circles
make_noisy_circle <- function(n, sd = .01) {
  theta <- stats::runif(n = n, min = 0, max = 2*pi)
  cbind(x = cos(theta) + stats::rnorm(n, 0, sd),
        y = sin(theta) + stats::rnorm(n, 0, sd))
}

# generate a noisy 2D circle
set.seed(1)
d <- as.data.frame(make_noisy_circle(n = 40, sd = .15))
r <- 1/3

# plot balls beneath points
ggplot(d, aes(x = x, y = y)) +
  theme_bw() +
  coord_fixed() +
  stat_disk(radius = r, fill = "aquamarine3") +
  geom_point()

# plot Vietoris 1-skeleton
ggplot(d, aes(x = x, y = y)) +
  theme_bw() +
  coord_fixed() +
  stat_vietoris1(diameter = 2*r, alpha = .25) +
  stat_vietoris0()

# plot Vietoris 2-skeleton
ggplot(d, aes(x = x, y = y)) +
  theme_bw() +
  coord_fixed() +
  stat_vietoris2(diameter = 2*r, fill = "darkgoldenrod") +
  stat_vietoris1(diameter = 2*r, alpha = .25) +
  stat_vietoris0()

# plot Čech 2-skeleton
ggplot(d, aes(x = x, y = y)) +
  theme_bw() +
  coord_fixed() +
  stat_cech2(diameter = 2*r, fill = "darkgoldenrod") +
  stat_cech1(diameter = 2*r, alpha = .25) +
  stat_cech0()

# plot Vietoris 1-skeleton atop balls
ggplot(d, aes(x = x, y = y)) +
  theme_bw() +
  coord_fixed() +
  stat_disk(radius = r, fill = "aquamarine3") +
  stat_vietoris1(diameter = 2*r, size = .2) +
  stat_vietoris0(size = .3)

# plot Vietoris 2-skeleton atop balls
ggplot(d, aes(x = x, y = y)) +
  theme_bw() +
  coord_fixed() +
  stat_disk(radius = r, fill = "aquamarine3") +
  stat_vietoris2(diameter = 2*r, fill = "darkgoldenrod") +
  stat_vietoris1(diameter = 2*r, size = .2) +
  stat_vietoris0(size = .3)

# plot Čech 2-skeleton atop balls
ggplot(d, aes(x = x, y = y)) +
  theme_bw() +
  coord_fixed() +
  stat_disk(radius = r, fill = "aquamarine3") +
  stat_cech2(diameter = 2*r, fill = "darkgoldenrod") +
  stat_cech1(diameter = 2*r, size = .2) +
  stat_cech0(size = .3)
}
\references{
F Chazal and B Michel (2017) An introduction to Topological Data Analysis:
fundamental and practical aspects for data scientists.
\url{https://arxiv.org/abs/1710.04019}
}
\seealso{
\code{\link[ggplot2:layer]{ggplot2::layer()}} for additional arguments.
}
\concept{plot layers for point clouds}
