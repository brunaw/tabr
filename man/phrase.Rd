% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/phrase.R
\name{phrase}
\alias{phrase}
\alias{p}
\title{Create a musical phrase}
\usage{
phrase(notes, info, string = NULL, bar = FALSE)

p(notes, info, string = NULL, bar = FALSE)
}
\arguments{
\item{notes}{character, notes \code{a} through \code{g}, comprising a noteworthy string. \code{notes}. See details.}

\item{info}{character, metadata pertaining to the \code{notes }. See details.}

\item{string}{character, optional string that specifies which guitar strings to play for each specific note.}

\item{bar}{logical, insert a bar check at the end of the phrase.}
}
\value{
a phrase.
}
\description{
Create a musical phrase from character strings that define notes, note metadata, and optionally explicit strings fretted. The latter can be used to ensure proper tablature layout.
}
\details{
Meeting all of the requirements for a string of notes to be valid \code{tabr} syntax is referred to as \emph{noteworthy}. Noteworthy strings are referred to throughout the documentation.
Such requirements are outlined below.

Noteworthy strings use space-delimited time. This means that notes and chords separated in time are separated in the \code{notes} string by spaces.
This is by far the most common usage. However, many functions in \code{tabr}, including \code{phrase},
allow a \code{notes} or similar first function argument to be provided in vector form where each vector element is a single note or chord (single point in time).
Internally, functions like \code{phrase} will manipulate these forms back and forth as needed. Having both input options provides useful flexibility for music programming in \code{tabr} in general.
The pipe operator can also be leveraged to chain several functions together.

Sharps and flats are indicated by appending \code{#} and \code{_}, respectively, e.g. \code{f#} or \code{g_}.

Specifying notes that are one or multiple octaves below or above the middle can be done by appending one or multiple commas or single quote tick marks, respectively, e.g. \code{c,} or \code{c''}.
But this is not necessary. Instead, you can use octave numbering. This may easier to read, generally more familiar, potentially requires less typing, can still be omitted completely
for the middle octave (no need to type c3, d3, ...), and is automatically converted for you by \code{phrase} to the tick mark format interpreted by LilyPond.
That said, using the raised and lowered tick mark approach can be surprisingly easier to read for chords, which have no spaces between notes, especially six-string chords,
given that the tick marks help break up the notes in the chord visually much more so than integers do. See examples.

The function \code{p} is a convenient shorthand wrapper for \code{phrase}.

Tied notes indicated by \code{~} are part of the \code{note} notation and not part of the \code{info} notation, e.g. \code{c''~}.

Notes can comprise chords. These are bound tightly rather than space-delimited, as they are not separated in time.
For example, a C chord could be given as \code{ceg} and in the case of tied notes would be \code{c~e~g~}.

Other information about a note is indicated with the \code{info} string.
The most pertinent information, minimally required, is the note duration. A string of space-delimited \code{notes} will always be accompanied by a space-delimited string of an equal number of integer durations.
Durations are powers of 2: 1, 2, 4, 8, 16, 32, 64. They represent the fraction of a measure, e.g., 2 means 1/2 of a measure and 8 refers to an eighth note.
Dotted notes are indicated by adding \code{.} immediately after the integer, e.g., \code{2.} or \code{2..}.
Any other note metadata is appended to these durations. See examples.

Opening and closing slurs (or hammer ons and pull offs) are indicated with opening and closing parentheses, slides with \code{-}, and simple bends with \code{^}.
Text annotations aligned vertically with a note in time on the staff is done by appending the text to the note info entry itself. See \code{\link{notate}}.
For more details and example, see the package vignettes.
}
\examples{
phrase("c ec'g' ec'g'", "4 4 2") # no explicit string specification (not recommended)
phrase("c ec4g4 ec4g4", "4 4 2") # same as above
phrase("c b, c", "4. 8( 8)", "5 5 5") # direction implies hammer on
phrase("b2 c d", "4( 4)- 2", "5 5 5") # hammer and slide

phrase("c ec'g' ec'g'", "1 1 1", "5 432 432")
p("c ec'g' ec'g'", "1 1 1", "5 432 432") # same as above
}
