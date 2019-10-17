#!/usr/bin/env Rscript
library('rjson')

dataFrame <- data.frame()
jsonData <- fromJSON(file='dataset.json')
for (recordSet in jsonData) {
    category <- recordSet$measurement
    unit <- recordSet$unit
    l <- length(recordSet$data)
    tmp <- data.frame(recordSet$data)
    df <- data.frame(rep(category, l), rep(unit, l), tmp$time, tmp$value)
    dataFrame <- rbind(dataFrame, df)
}
print(dataFrame)
