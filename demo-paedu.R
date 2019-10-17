#!/usr/bin/env Rscript
library('rjson')

jsonData <- fromJSON(file='dataset.json')
print(jsonData[[1]]$measurement)
print(jsonData[[2]]$measurement)
print(jsonData[[3]]$measurement)
print(jsonData[[4]]$measurement)
