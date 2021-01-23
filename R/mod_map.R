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
mod_map_server <- function(input, output, session){
  ns <- session$ns

  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(
        lat = c(32.715, 34.05),
        lng = c(-117.1625, -118.25)
      )
  })

}

## To be copied in the UI
# mod_map_ui("map_ui_1")

## To be copied in the server
# callModule(mod_map_server, "map_ui_1")

