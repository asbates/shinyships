#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny.semantic
#' @noRd
app_ui <- function(request) {
  semanticPage(
    title = "Shiny Ships",
    theme = "superhero",
    margin = "20px",
    # Leave this function for adding external resources
    # note: no external resources currently
    # will need to uncomment if added
    golem_add_external_resources(),
      segment(
        class = "horizontal segments",
        mod_vessel_type_selector_ui("vessel_type_selector_ui"),
        mod_vessel_selector_ui("vessel_selector_ui")
      ),
      mod_map_ui("map_ui")
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){

  add_resource_path(
    'www', app_sys('app/www')
  )

  tags$head(
    #favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'Shiny Ships'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

