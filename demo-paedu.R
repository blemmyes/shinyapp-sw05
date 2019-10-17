#!/usr/bin/env Rscript
library('rjson')

dataFrame <- data.frame()
jsonData <- fromJSON(file='small.json')
for (recordSet in jsonData) {
    category <- recordSet$measurement
    unit <- recordSet$unit
    for (pair in recordSet$data) {
        record <- data.frame(category, unit, pair$time, pair$value)
        dataFrame <- rbind(record, dataFrame)
    }
}
names(dataFrame) <- c('category', 'unit', 'time', 'value')
print(dataFrame)
