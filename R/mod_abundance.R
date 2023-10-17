#' abundance UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_abundance_ui <- function(id){
  ns <- NS(id)
  tagList(
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::textAreaInput(
          inputId = ns("peptide"),
          label = "Peptide sequence",
          width = 300,
          height = 100,
          placeholder = "Insert peptide sequence"
        )
      ),
      shiny::mainPanel(
        shiny::plotOutput(
          outputId = ns("abundance")
          )

      )
    )
  )
}

#' abundance Server Functions
#'
#' @noRd
mod_abundance_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$abundance <- renderPlot({
      if(input$peptide == ""){
        NULL
      } else{
        input$peptide |>
          centralDogma::plot_abundance() +
          ggplot2::theme(legend.position = "none")
        }
    })

    # peptide <- reactive({
    #   input$peptide
    # })
    #
    #
    # observeEvent(peptide(), {
    #   if(peptide() != ""){
    #     output$abundance <- renderPlot({
    #       peptide() %>%
    #         centralDogma::plot_abundance() +
    #         ggplot2::theme(legend.position = "none")
    #   })
    #   } else{
    #     output$abundance <- NULL
    #   }
    # })




  })
}

## To be copied in the UI
# mod_abundance_ui("abundance_1")

## To be copied in the server
# mod_abundance_server("abundance_1")
