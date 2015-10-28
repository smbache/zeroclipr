# zeroclipr: Simple Clipboard for R/Shiny Apps

### Introduction
[ZeroClipboard](http://zeroclipboard.org/) provides an easy way to copy text to the clipboard using an invisible Adobe Flash movie and a JavaScript interface, and is used e.g. by GitHub. The `zeroclipr` R package is a very simple package providing a way of creating reactive copy-to-clipboard action buttons for [Shiny](http:// shiny.rstudio.com/) R applications.

### Requirements and installation
The two necessary files `ZeroClipboard.js` and `ZeroClipboard.swf` are bundled with the package, and is current 
included version is `v2.3.0-beta.1`. The package is not on CRAN, but can be installed from GitHub:

```R
devtools::install_github("smbache/zeroclipr")
```

### Example Usage
So far, there is only one `UI` component, `zeroclipButton`. This can be used either directly in the UI
for a static copy-text, or with `renderUI` for a reactive copy-text.

This example shows how to setup a button for copying data as csv to clipboard:

```R
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

```