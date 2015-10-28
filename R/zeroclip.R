#' ZeroClipboard Button Output
#'
#' Create an Action Button with a ZeroClipboard data-clipboard-text attribute.
#'
#' @param inputId The button Id.
#' @param label The  button Label.
#' @param clipText The text to be copied on click.
#' @param icon The button Id.
#' @param width The button width.
#'
#' @return htmlOutput
#'
#' @importFrom shiny tagList tags actionButton singleton
#' @export
zeroclipButton <- function(inputId, label, clipText, icon = NULL, width = NULL)
{
  tagList(
    singleton(tags$head(tags$script(src = "zeroclipr/ZeroClipboard.js"))),
    singleton(tags$head(tags$script('ZeroClipboard.config( { swfPath: "./zeroclipr/ZeroClipboard.swf" } );'))),
    actionButton(inputId = inputId, label = label, icon = icon, width = NULL,
                 `data-clipboard-text` = clipText),
    tags$script(sprintf('var client_%s = new ZeroClipboard( $("#%1$s") );',
                        inputId))
  )
}