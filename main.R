#!/usr/bin/env Rscript

library('tidyverse')
source('read-data.R')

#### Loading Data ####

measurements <- read_measurement_data('Library/Mobile Documents/com~apple~CloudDocs/HSLU/07 HS19/DASB/05/shinyapp-sw05/dataset.json')
tibble <- as_tibble(measurements)

# Example: select all temperature and humidity entries
tempHumid <- filter(tibble, measurement == 'temperature' | measurement == 'humidity')
print(tempHumid)

#### Plotting Data ####

temp <- filter(tibble, measurement == 'temperature')
humid <- filter(tibble, measurement == 'humidity')
ggplot(data = temp) + geom_point(mapping = aes(x = time, y = value))
ggplot(data = humid) + geom_point(mapping = aes(x = time, y = value))
