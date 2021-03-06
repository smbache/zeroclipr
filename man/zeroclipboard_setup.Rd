% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/zeroclipboard_setup.R
\name{zeroclipboard_setup}
\alias{zeroclipboard_setup}
\title{Include ZeroClipboard Script and SWF}
\usage{
zeroclipboard_setup(swfPath = "./zeroclipr/ZeroClipboard.swf")
}
\arguments{
\item{swfPath}{character specifying the path to the swf path.
  This is only needed when the relative default path is not approporiate.}
}
\value{
A \code{shiny::tagList}
}
\description{
This will include the ZeroClipboard.js and ZeroClipboard.swf files. It
will do so only once, using \code{shiny::singleton}. This is useful
for specifying more generalized ZeroClipboard functionality than the
included UI components.
}

