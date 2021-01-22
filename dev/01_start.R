# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application
golem::fill_desc(
  pkg_name = "shinyships",
  pkg_title = "A Shiny app to plot longest ship path",
  pkg_description = "A Shiny app to plot the path of the longest distance between AIS pings.",
  author_first_name = "Andrew",
  author_last_name = "Bates",
  author_email = "andrewbates73@gmail.com",
  repo_url = "https://github.com/asbates/shinyships"
)

## Set {golem} options ----
golem::set_golem_options()

## Create Common Files ----
## See ?usethis for more information
usethis::use_mit_license(copyright_holder = "Andrew Bates")
usethis::use_readme_md()


## Init Testing Infrastructure ----
## Create a template for tests
golem::use_recommended_tests()


## Favicon ----
# If you want to change the favicon (default is golem's one)
golem::remove_favicon()


# You're now set! ----

# go to dev/02_dev.R
rstudioapi::navigateToFile( "dev/02_dev.R" )
