#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @importFrom shiny callModule
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here

  callModule(mod_map_server, "map_ui_1")
}
