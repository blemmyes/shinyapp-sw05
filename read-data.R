#!/usr/bin/env Rscript
library('rjson')

dataFrame <- data.frame()
jsonData <- fromJSON(file='big.json')
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
print(dataFrame)
