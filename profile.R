#!/usr/bin/env Rscript

library('tibble')
library('dplyr')

source('read-data.R')

Rprof(tmp <- tempfile()) # start profiling
measurements <- read_measurement_data('./dataset.json')
Rprof() # stop profiling
summaryRprof(tmp)
