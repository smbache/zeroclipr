#' @importFrom shiny addResourcePath
#'
.onLoad <- function(libname, pkgname)
{
  addResourcePath("zeroclipr", system.file("www", package = .packageName))
}
