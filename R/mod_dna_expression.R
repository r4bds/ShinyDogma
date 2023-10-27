#' dna_expression UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_dna_expression_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(8, shiny::uiOutput(ns("DNA"))),
      column(4, shiny::numericInput(
        inputId = ns("dna_length"),
        value = 6000,
        min = 3,
        max = 100000,
        step = 3,
        label = "Random DNA length"
      ),
      shiny::actionButton(
        inputId = ns("generate_dna"),
        label = "Generate random DNA", style = "margin-top: 18px;"
      ))
    ),
    shiny::verbatimTextOutput(outputId = ns("peptide")) %>%
      shiny::tagAppendAttributes(style = "white-space: pre-wrap;")

  )
}

#' dna_expression Server Functions
#'
#' @noRd
mod_dna_expression_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    dna <- reactiveVal()

    output$DNA <- renderUI({
      shiny::textAreaInput(
        inputId = ns("DNA"),
        label = "DNA sequence",
        placeholder = "Insert DNA sequence",
        value = dna(),
        height = 100,
        width = 600
        )
    })
    observeEvent(input$generate_dna, {
      dna(
        centralDogma::random_dna(input$dna_length)
      )
    })

    # Test
    # output$peptide <- renderText({
    #   dna(
    #     input$DNA
    #   )
    #   if(nchar(dna()) > 2){
    #     dna() %>%
    #       centralDogma::translate() %>%
    #       centralDogma::codon_split() %>%
    #       centralDogma::transcribe()
    #   } else{
    #       NULL
    #     }
    # })

    # /Test
    output$peptide <- renderText({
      # Ensure input is not NULL
      if(is.null(input$DNA)){
        NULL
      } else if(nchar(input$DNA) < 3){
        NULL
      } else{
        input$DNA %>%
          toupper() %>%
          centralDogma::transcribe() %>%
          centralDogma::codon_split() %>%
          centralDogma::translate()
      }
    })

    # observeEvent(input$express, {
    #   dna(
    #     input$DNA
    #   )
    #
    #   if(nchar(dna()) > 2){
    #     output$peptide <- renderText({
    #       dna() %>%
    #         centralDogma::transcribe() %>%
    #         centralDogma::codon_split() %>%
    #         centralDogma::translate()
    #     })
    #   } else{
    #     output$peptide <- NULL
    #   }
    #
    # })

  })
}

## To be copied in the UI
# mod_dna_expression_ui("dna_expression_1")

## To be copied in the server
# mod_dna_expression_server("dna_expression_1")
