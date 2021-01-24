
# shinyships

<!-- badges: start -->
<!-- badges: end -->

`shinyships` is a Shiny application that uses Automatic Identification System
 data ([AIS](https://en.wikipedia.org/wiki/Automatic_identification_system))
 to plot the location of a ship between consecutive AIS pings.
For each ship, the farthest distance traveled between AIS pings are plotted on
 a leaflet map.
You can find the application on shinyapps.io at
 [https://asbates.shinyapps.io/shinyships/](https://asbates.shinyapps.io/shinyships/).

## Installation

This application is built using the 
 [`golem`](https://thinkr-open.github.io/golem/index.html) framework so you
 can install it locally just like you would for an R package on GitHub.

``` r
remotes::install_github("asbates/shinyships")
```

You can run the application locally with

``` r
shinyships::run_app()
```
