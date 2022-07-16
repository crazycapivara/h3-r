
<!-- README.md is generated from README.Rmd. Please edit that file -->

# H3-R

<!-- badges: start -->

[![R build
status](https://github.com/crazycapivara/h3-r/workflows/R-CMD-check/badge.svg)](https://github.com/crazycapivara/h3-r/actions)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![H3
Version](https://img.shields.io/badge/h3-v3.7.1-blue.svg)](https://github.com/uber/h3/releases/tag/v3.7.1)
[![CRAN
status](https://www.r-pkg.org/badges/version/h3)](https://CRAN.R-project.org/package=h3)
<!-- badges: end -->

Provides R bindings for [H3](https://h3geo.org/), a hexagonal
hierarchical spatial indexing system.

## Documentation

-   [H3-R](https://crazycapivara.github.io/h3-r/)
-   [H3](https://h3geo.org/docs/)

## Notes

Succesfully built on

-   Linux
-   macOS
-   Windows

Since v3.7.1 {h3} comes with a bundled version of the H3 C library, so
that you no longer have to build it yourself before installing the R
package.

## Installation

Once on [CRAN](https://cran.r-project.org/) you can install {h3} with:

``` r
install.packages("h3")
```

You can install the latest of {h3} from github with:

``` r
# install.packages("remotes")
remotes::install_github("crazycapivara/h3-r")
```

## Usage

Core functions:

``` r
library(h3)

coords <- c(37.3615593, -122.0553238)
resolution <- 7

# Convert a lat/lng point to a hexagon index at resolution 7
(h3_index <- geo_to_h3(coords, resolution)) 
#> [1] "87283472bffffff"

# Get the center of the hexagon
h3_to_geo_sf(h3_index)
#> Simple feature collection with 1 feature and 1 field
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: -122.0503 ymin: 37.35172 xmax: -122.0503 ymax: 37.35172
#> Geodetic CRS:  WGS 84
#>          h3_index                   geometry
#> 1 87283472bffffff POINT (-122.0503 37.35172)

# Get the vertices of the hexagon
h3_to_geo_boundary(h3_index)
#> [[1]]
#>           lat       lng
#> [1,] 37.34110 -122.0416
#> [2,] 37.35290 -122.0340
#> [3,] 37.36352 -122.0428
#> [4,] 37.36234 -122.0591
#> [5,] 37.35054 -122.0666
#> [6,] 37.33992 -122.0579

# Get the polygon of the hexagon
h3_to_geo_boundary_sf(h3_index)
#> Simple feature collection with 1 feature and 1 field
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -122.0666 ymin: 37.33992 xmax: -122.034 ymax: 37.36352
#> Geodetic CRS:  WGS 84
#>          h3_index                       geometry
#> 1 87283472bffffff POLYGON ((-122.0416 37.3411...
```

Useful algorithms:

``` r
# Get all neighbors within 1 step of the hexagon
radius <- 1
(neighbors <- k_ring(h3_index, radius))
#> [1] "87283472bffffff" "87283472affffff" "87283470cffffff" "87283470dffffff"
#> [5] "872834776ffffff" "872834729ffffff" "872834728ffffff"

h3_to_geo_boundary_sf(neighbors) %>%
  sf::st_geometry() %>% plot(col = "blue")
```

<img src="man/figures/README-h3-algorithms-1.png" width="400px" />

``` r
h3_set_to_multi_polygon(neighbors) %>%
  sf::st_geometry() %>% plot(col = "green")
```

<img src="man/figures/README-h3-algorithms-2.png" width="400px" />

## Run tests

``` r
devtools::test(reporter = "minimal")
#> ℹ Loading h3
#> ℹ Testing h3
#> ...................................................
```
