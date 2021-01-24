#' map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList uiOutput renderUI
#' @import leaflet
#' @importFrom scales comma
mod_map_ui <- function(id){
  ns <- NS(id)
  tagList(
    segment(
      style = "padding-top: 45px;",
      uiOutput(ns("label")),
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

  output$label <- renderUI({
    distance <- scales::comma(ships_to_map()$max_distance[1], accuracy = 0.1)
    label(
      paste("Longest Distance Sailed:", distance, "m"),
      class = "top attached label"
    )
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

