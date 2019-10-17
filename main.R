#!/usr/bin/env Rscript

library('tibble')
library('dplyr')

source('read-data.R')

measurements <- read_measurement_data('./dataset.json')
tibble <- as_tibble(measurements)

# Example: select all temperature and humidity entries
tempHumid <- filter(tibble, measurement == 'temperature' | measurement == 'humidity')
print(tempHumid)
