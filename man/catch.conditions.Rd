% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/catch.conditions.R
\name{catch.conditions}
\alias{catch.conditions}
\title{Condition Handling and Recovery}
\usage{
catch.conditions(expr)
}
\arguments{
\item{expr}{expression to be evaluated.}
}
\value{
A named list of two elements:
\item{value}{the result of the evaluation, a regular R object or an error
message.}
\item{warning}{any warning message generated by the evaluation, \code{NULL}
if none.}
}
\description{
This function provides a mechanism for handling unusual
conditions such as errors and warnings.
}
\details{
The function calls \link{withCallingHandlers} and \link{tryCatch} to
catch and return, after the evaluation of \code{expr}, any unusual conditions
such as errors and warnings.

Conditions are represented as objects that contain information about the
condition that occurred, such as a message and the call in which the
condition occurred.
}
\seealso{
\link{tryCatch}.
}
\author{
The R core Team.
}
