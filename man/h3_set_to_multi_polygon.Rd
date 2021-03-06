% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/h3_regions.R
\name{h3_set_to_multi_polygon}
\alias{h3_set_to_multi_polygon}
\title{Create a (multi) polygon describing the outline(s) of a set of hexagons.}
\usage{
h3_set_to_multi_polygon(h3_indexes)
}
\arguments{
\item{h3_indexes}{character vector of H3 indexes}
}
\value{
\code{sf} object; \code{POLYGON} (if only one outline is created) or \code{MULTIPOLYGON}
}
\description{
Create a (multi) polygon describing the outline(s) of a set of hexagons.
}
