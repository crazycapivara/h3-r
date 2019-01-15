
<!-- README.md is generated from README.Rmd. Please edit that file -->
H3-R
====

[![Travis build status](https://travis-ci.org/crazycapivara/h3-r.svg?branch=master)](https://travis-ci.org/crazycapivara/h3-r) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

Provides R bindungs to [H3](https://uber.github.io/h3/), a hexagonal hierarchical spatial indexing system.

Installation
------------

First of all you need to build the [H3 C library](https://github.com/uber/h3) from source. Therefore, you need a *C compiler*, *CMake* and *Make*. For building on Linux and OSX take a look at the commands in the `before_install` section in [.travis.yml](.travis.yml).

Then you can install h3 from github with:

``` r
# install.packages("devtools")
devtools::install_github("crazycapivara/h3-r")
```
