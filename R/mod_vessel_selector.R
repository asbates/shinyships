#' vessel_selector UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_vessel_selector_ui <- function(id){
  ns <- NS(id)
  tagList(
    segment(
      shiny.semantic::selectInput(
        ns("selected_vessel"),
        label = "Select a vessel",
        choices = c("Nautilis", "Beagle", "SS Anne")
      )
    )
  )
}

#' vessel_selector Server Function
#'
#' @noRd
mod_vessel_selector_server <- function(input, output, session){
  ns <- session$ns

}

## To be copied in the UI
# mod_vessel_selector_ui("vessel_selector_ui_1")

## To be copied in the server
# callModule(mod_vessel_selector_server, "vessel_selector_ui_1")

