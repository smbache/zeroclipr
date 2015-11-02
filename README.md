# zeroclipr: Simple Clipboard for R/Shiny Apps

### Introduction
[ZeroClipboard](http://zeroclipboard.org/) provides an easy way to copy text to 
the clipboard using an invisible Adobe Flash movie and a JavaScript interface, 
and is used e.g. by GitHub. The `zeroclipr` R package is a very simple package 
providing a way of creating reactive copy-to-clipboard action buttons 
for [Shiny](http:// shiny.rstudio.com/) R applications. The package has a 
single UI component, the `zeroclipButton`, but is also meant for easy 
implementations of more generalized usage of ZeroClipboard.

### Requirements and installation
The two necessary files `ZeroClipboard.js` and `ZeroClipboard.swf` are bundled 
with the package, and the current included version is `v2.3.0-beta.1`. 
The package is not on CRAN, but can be installed from GitHub:

```R
devtools::install_github("smbache/zeroclipr")
```

### Example Usage
So far, there is only one `UI` component, `zeroclipButton`. This can be used 
either directly in the UI for a static copy-text, or with `renderUI` for a 
reactive copy-text.

This example shows how to setup a button for copying data as csv to clipboard:

```R
library(zeroclipr)
library(shiny)

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
    selectInput("species", "Select Species: ", 
                choices = c("setosa", "versicolor", "virginica")),

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

### Creating Other Clipboard UI components
The package, by design, does not ship with many different components, nor 
does it try to interface all the available functionality of ZeroClipboard.js.
It merely exposes the required `js` and `swf` components, and makes it easy to create 
whatever kind of component you need. Inspecting the included `zeroclipButton`
you'll see that you can easily tailor other components:

```R
zeroclipButton <- function(inputId, label, clipText, icon = NULL, width = NULL)
{
  tagList(
    zeroclipboard_setup(),
    actionButton(inputId = inputId, label = label, icon = icon, 
                 width = NULL, `data-clipboard-text` = clipText),
    tags$script(sprintf('var client_%s = new ZeroClipboard( $("#%1$s") );', inputId))
  )
}
``` 

You just need `zeroclipr` to be loaded, and to include the `zeroclipboard_setup()`
in your component.



