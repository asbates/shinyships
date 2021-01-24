#' vessel_selector UI Function
#'
#' @description A shiny Module to generate the vessel selector UI.
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
#' @param vessel_type The vessel type (reactive value from vessel type server).
#'
#' @importFrom shiny reactive observe
#' @noRd
mod_vessel_selector_server <- function(input, output, session, vessel_type){
  ns <- session$ns

  ships <- shinyships::ships
  #vessel_choices <- ships[ships$ship_type == vessel_type(), "ship_name"]
  vessel_choices <- reactive({
    unique(
      ships[ships$ship_type == vessel_type(), "ship_name", drop = TRUE]
    )
  })

  observe({
    updateSelectInput(
      session,
      "selected_vessel",
      choices = vessel_choices()
    )
  })

  reactive({
    input$selected_vessel
  })

}

## To be copied in the UI
# mod_vessel_selector_ui("vessel_selector_ui_1")

## To be copied in the server
# callModule(mod_vessel_selector_server, "vessel_selector_ui_1")

