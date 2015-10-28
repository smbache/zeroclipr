library(zeroclipr)
library(shiny)

# Simple example of a clipboard button for copying data as csv to clipboard
#
runApp(list(

  # The UI
  ui = bootstrapPage(

    # Control the styling of the button. This is not necessary but will make the
    # button feel more natural, with the flash object on top:
    singleton(tags$head(tags$style(
      '
      .zeroclipboard-is-hover { background-color: steelblue; }
      .zeroclipboard-is-active { background-color: firebrick; }
      '
    ))),

    # A select input for selecting subset
    selectInput("species", "Select Species: ", choices = c("setosa", "versicolor", "virginica")),

    # The UI placeholder for the copy button
    uiOutput("clip"),

    # A text input for testing the lipboard content.
    textInput("paste", "Paste here:")
  ),

  # The server
  server = function(input, output) {

    # A reactive data source, based on the input$species
    species_data <- reactive({
      subset(iris, Species == input$species)
    })

    # Create the text representation of the subset for the clipboard and
    # setup the copy button.
    output$clip <- renderUI({
      str <- textConnection("irisdata", open = "w")
      write.csv(species_data(), str, row.names = FALSE)
      close(str)
      zeroclipButton("clipbtn", "Copy", paste(irisdata, collapse= "\n"), icon("clipboard"))
    })
  }
))

