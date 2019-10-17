library('rjson')

jsonData <- fromJSON(file='dataset.json')
jsonDataFrame <- as.data.frame(jsonData)
print(jsonDataFrame)
