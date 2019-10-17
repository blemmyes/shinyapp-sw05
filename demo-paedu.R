#!/usr/bin/env Rscript
library('rjson')

dataFrame <- data.frame()
jsonData <- fromJSON(file='dataset.json')
for (recordSet in jsonData) {
    category <- recordSet$measurement
    unit <- recordSet$unit
    data <- recordSet$data
    for (record in data) {
        entry <- data.frame(category, unit, record$time, record$value)
        dataFrame <- rbind(dataFrame, entry)
    }
}
print(dataFrame)
