#!/usr/bin/env Rscript
library('rjson')
library('tibble')
library('dplyr')

# read in the whole data frame
jsonData <- fromJSON(file='small.json')
dataFrame <- data.frame()
for (recordSet in jsonData) {
    measurement <- recordSet$measurement
    unit <- recordSet$unit
    raw <- unlist(recordSet$data)
    df <- as.data.frame(t(matrix(raw, nrow=2)))
    df <- cbind(df, measurement)
    df <- cbind(df, unit)
    dataFrame <- rbind(dataFrame, df)
}
names(dataFrame) <- c('time', 'value', 'measurement', 'unit')
tibble <- as_tibble(dataFrame)

# Example: select all temperature and humidity entries
tempHumid <- filter(tibble, measurement == 'temperature' | measurement == 'humidity')
print(tempHumid)
