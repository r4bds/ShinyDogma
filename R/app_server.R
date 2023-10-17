#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom magrittr %>%
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  mod_abundance_server("abundance_1")
  mod_dna_expression_server("dna_expression_1")
  mod_example_server("example_1")
}
