% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chords.R
\name{chord_is_diatonic}
\alias{chord_is_diatonic}
\title{Check if a chord is diatonic}
\usage{
chord_is_diatonic(chord, key = "c")
}
\arguments{
\item{chord}{character, a chord string. May be a vector.}

\item{key}{character, key signature.}
}
\value{
logical
}
\description{
Check whether a chord is diatonic in a given key.
}
\details{
This function strictly accepts chord strings. To check if notes are in a scale, see \code{\link{note_in_scale}}. To check generally if a \code{noteworthy} string is fully diatonic, see \code{\link{is_diatonic}}.
}
\examples{
chord_is_diatonic("ceg ace ce_g", "c")
chord_is_diatonic(c("dfa", "df#a"), "d")
}
\seealso{
\code{\link{note_in_scale}}, \code{\link{is_diatonic}}
}
