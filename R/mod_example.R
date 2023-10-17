#' example UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_example_ui <- function(id){
  ns <- NS(id)
  tagList(
    textInput(ns("name"), "What's your name?"),
    textOutput(ns("greeting")),br(),br(),
    verbatimTextOutput(ns("code")), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(),
    verbatimTextOutput(ns("add_module")), br(),
    textAreaInput(ns("app_ui"), label = "R/app_ui.R",height = 300, width = 500, value = '
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      h1("Shiny App Name")
      )
  )
}
'
),
    textAreaInput(ns("app_server"), label = "R/app_server.R",height = 200, width = 500,
    value = '
app_server <- function(input, output, session) {
  # Your application server logic
}
                  '),
textAreaInput(ns("module"), label = "R/mod_examplemodule.R", height = 600, width = 500,
              value = '
mod_example_ui <- function(id){
  ns <- NS(id)
  tagList(

  )
  }

mod_examplemodule_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
  })
}
## To be copied in the UI
# mod_examplemodule_ui("examplemodule_1")

## To be copied in the server
# mod_examplemodule_server("examplemodule_1")


                  ')
  )
}

#' example Server Functions
#'
#' @noRd
mod_example_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$greeting <- shiny::renderText({
      paste0("Hello ", input$name, "!")
    })

    output$add_module <- renderText({
      'golem::add_module(name = "examplemodule")'
    })
    output$code <- renderText({

      '
library(shiny)
# User Interface (Front end)
ui <- fluidPage(
  textInput(inputId = "name", label = "What\'s your name?"),
  textOutput(outputId = "greeting")
)

# Server (Back end)
server <- function(input, output, session) {
  output$greeting <- renderText({
    paste0("Hello ", input$name, "!")
  })
}
shinyApp(ui, server)'

    })

  })
}

## To be copied in the UI
# mod_example_ui("example_1")

## To be copied in the server
# mod_example_server("example_1")
