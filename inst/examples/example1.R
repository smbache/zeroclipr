library(zeroclipr)
library(shiny)

# Simple example of a clipboard button reacting to changes in a shiny textInput
#
runApp(list(

  # The UI
  ui = bootstrapPage(
    # Control the styling of the button, with the flash object on top:
    singleton(tags$head(tags$style(
      '
      .zeroclipboard-is-hover { background-color: #eee; }
      .zeroclipboard-is-active { background-color: #aaa; }
      '
    ))),

    # Add a text input
    textInput("copytext", "Copy this:", "R is awesome!"),

    # A UI output for the copy-to-clipboard button
    uiOutput("clip"),

    # A text input for testing the clipboard content.
    textInput("paste", "Paste here:")
  ),

  # The server
  server = function(input, output) {

    # Add a clipboard button, reacting to changes in the input$copytext
    output$clip <- renderUI({
      zeroclipButton("clipbtn", "Copy", input$copytext, icon("clipboard"))
    })

  }

))
