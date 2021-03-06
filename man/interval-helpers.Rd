% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/intervals.R
\name{interval-helpers}
\alias{interval-helpers}
\alias{pitch_interval}
\alias{scale_interval}
\alias{tuning_intervals}
\title{Interval helpers}
\usage{
pitch_interval(note1, note2, ignore_octave = FALSE)

scale_interval(note1, note2, format = c("mmp_abb", "mmp", "ad_abb",
  "ad"), ignore_octave = FALSE)

tuning_intervals(tuning = "standard")
}
\arguments{
\item{note1}{character, first note. Must be a single note.}

\item{note2}{character, second note.}

\item{ignore_octave}{logical, reduce the interval to that defined by notes within a single octave.}

\item{format}{character, format of the scale notation: major/minor/perfect, augmented/diminished, and respective abbreviations. See argument options in defaults.}

\item{tuning}{character, string tuning.}
}
\value{
a musical interval, integer or character depending on the function.
}
\description{
Helper functions for musical intervals defined by two notes.
}
\details{
Intervals are directional. \code{pitch_interval} returns the number of semitones defining the distance between two notes. The interval is negative if \code{note1} has higher pitch than \code{note2}.
For \code{scale_interval}, a character string is returned that provides the named main interval, simple or compound, defined by  the two notes.
This function will return \code{NA} for any uncommon interval not listed in \code{\link{mainIntervals}}.
}
\examples{
pitch_interval("b", "c4")
pitch_interval("c,", "d")
scale_interval("c", "e_")
}
\seealso{
\code{\link{mainIntervals}}
}
