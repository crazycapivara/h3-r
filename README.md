
<!-- README.md is generated from README.Rmd. Please edit that file -->
H3-R
====

[![Travis build status](https://travis-ci.org/crazycapivara/h3-r.svg?branch=master)](https://travis-ci.org/crazycapivara/h3-r) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) [![H3 Version](https://img.shields.io/badge/h3-v3.3.0-blue.svg)](https://github.com/uber/h3/releases/tag/v3.3.0)

Provides R bindungs to [H3](https://uber.github.io/h3/), a hexagonal hierarchical spatial indexing system.

Installation
------------

First of all you need to build the [H3 C library](https://github.com/uber/h3) from source. Therefore, you need a C compiler, `cmake` and `make`. For building on Linux and OSX take a look at the commands in the `before_install` section in [.travis.yml](.travis.yml).

Then you can install h3 from github with:

``` r
# install.packages("devtools")
devtools::install_github("crazycapivara/h3-r")
```

Usage
-----

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
#> Simple feature collection with 1 feature and 0 fields
#> geometry type:  POINT
#> dimension:      XY
#> bbox:           xmin: -122.0503 ymin: 37.35172 xmax: -122.0503 ymax: 37.35172
#> epsg (SRID):    4326
#> proj4string:    +proj=longlat +datum=WGS84 +no_defs
#>                     geometry
#> 1 POINT (-122.0503 37.35172)

# Get the vertices of the hexagon
h3_to_geo_boundary(h3_index)
#> [[1]]
#>          [,1]      [,2]
#> [1,] 37.34110 -122.0416
#> [2,] 37.35290 -122.0340
#> [3,] 37.36352 -122.0428
#> [4,] 37.36234 -122.0591
#> [5,] 37.35054 -122.0666
#> [6,] 37.33992 -122.0579

# Get the polygon of the hexagon
h3_to_geo_boundary_sf(h3_index)
#> Simple feature collection with 1 feature and 0 fields
#> geometry type:  POLYGON
#> dimension:      XY
#> bbox:           xmin: -122.0666 ymin: 37.33992 xmax: -122.034 ymax: 37.36352
#> epsg (SRID):    4326
#> proj4string:    +proj=longlat +datum=WGS84 +no_defs
#>                         geometry
#> 1 POLYGON ((-122.0416 37.3411...
```

Useful algorithms:

``` r
# Get all neighbors within 1 step of the hexagon
radius <- 1
(neighbors <- k_ring(h3_index, radius))
#> [1] "87283472bffffff" "87283472affffff" "87283470cffffff" "87283470dffffff"
#> [5] "872834776ffffff" "872834729ffffff" "872834728ffffff"

h3_to_geo_boundary_sf(neighbors) %>%
  sf::st_geometry() %>% plot()
```

<img src="man/figures/README-h3-algorithms-1.png" width="100%" />
