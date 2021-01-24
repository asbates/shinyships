#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @importFrom shiny callModule
#' @importFrom magrittr %>%
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here

  vessel_type <- callModule(
    mod_vessel_type_selector_server,
    "vessel_type_selector_ui"
  )

  vessel <- callModule(
    mod_vessel_selector_server,
    "vessel_selector_ui",
    vessel_type
  )

  callModule(mod_map_server, "map_ui_1", vessel_type, vessel)
}
