#' Include ZeroClipboard Script and SWF
#'
#' This will include the ZeroClipboard.js and ZeroClipboard.swf files. It
#' will do so only once, using \code{shiny::singleton}. This is useful
#' for specifying more generalized ZeroClipboard functionality than the
#' included UI components.
#'
#' @param swfPath character specifying the path to the swf path.
#'   This is only needed when the relative default path is not approporiate.
#'
#' @importFrom shiny singleton tags
#'
#' @return A \code{shiny::tagList}
#' @export
zeroclipboard_setup <- function(swfPath = "./zeroclipr/ZeroClipboard.swf")
{
  config <- sprintf('ZeroClipboard.config( { swfPath: "%s" } );', swfPath)

  tagList(
    singleton(tags$head(tags$script(src = "zeroclipr/ZeroClipboard.js"))),
    singleton(tags$head(tags$script(config)))
  )
}

