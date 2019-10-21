library('rjson')

read_measurement_data <- function(json_file_path) {
    jsonData <- fromJSON(file=json_file_path)
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
    dataFrame$value <- as.double(as.character(dataFrame$value))
    return(dataFrame)
}

