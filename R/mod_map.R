#' map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import leaflet
mod_map_ui <- function(id){
  ns <- NS(id)
  tagList(
    segment(
      leafletOutput(ns("map"))
    )
  )
}

#' map Server Function
#'
#' @noRd
mod_map_server <- function(input, output, session, vessel_type, vessel){
  ns <- session$ns

  ships <- shinyships::ships

  ships_to_map <- reactive({
    ships[
      ships$ship_type == vessel_type() & ships$ship_name == vessel()
      ,
    ]
  })

  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(
        data = ships_to_map(),
        lng = ~lon,
        lat = ~lat
      )
  })

}

## To be copied in the UI
# mod_map_ui("map_ui_1")

## To be copied in the server
# callModule(mod_map_server, "map_ui_1")

