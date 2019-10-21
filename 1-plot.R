#!/usr/bin/env Rscript

library('shiny')
library('tibble')
library('tibbletime')
library('dplyr')
library('ggplot2')

source('read-data.R')

ui <- fluidPage(
    titlePanel('DASB: Explorative Data Analysis'),
    fluidRow(
        column(12,
            sliderInput(inputId='valuesPerGroup', label='Window Size (Rolling Mean):', min=1, max=1000, value=50)
        ),
        column(6, plotOutput(outputId='temperature')),
        column(6, plotOutput(outputId='light')),
        column(6, plotOutput(outputId='humidity')),
        column(6, plotOutput(outputId='pressure'))
    )
)

data <- read_measurement_data('dataset.json')
tibble <- as_tibble(data)

temperature <- filter(tibble, measurement == 'temperature')
light <- filter(tibble, measurement == 'light')
humidity <- filter(tibble, measurement == 'humidity')
pressure <- filter(tibble, measurement == 'pressure')

server <- function(input, output) {
    observeEvent(input$valuesPerGroup, {
        valuesPerGroup <- input$valuesPerGroup
        rolling_mean <- rollify(mean, window=valuesPerGroup)

        temperature <- mutate(temperature, value=rolling_mean(value))
        output$temperature <- renderPlot(ggplot(temperature, aes(x=time, y=value)) +
                                         geom_point() +
                                         ggtitle('Temperature') +
                                         xlab('Time') +
                                         ylab('°C') +
                                         theme(axis.ticks.x=element_blank()))

        light <- mutate(light, value=rolling_mean(value))
        output$light <- renderPlot(ggplot(light, aes(x=time, y=value)) +
                                      geom_point() +
                                      ggtitle('Light') +
                                      xlab('Time') +
                                      ylab('lux') +
                                      theme(axis.ticks.x=element_blank()))

        humidity <- mutate(humidity, value=rolling_mean(value))
        output$humidity <- renderPlot(ggplot(humidity, aes(x=time, y=value)) +
                                      geom_point() +
                                      ggtitle('Humidity') +
                                      xlab('Time') +
                                      ylab('%') +
                                      theme(axis.ticks.x=element_blank()))

        pressure <- mutate(pressure, value=rolling_mean(value))
        output$pressure <- renderPlot(ggplot(pressure, aes(x=time, y=value)) +
                                      geom_point() +
                                      ggtitle('Pressure') +
                                      xlab('Time') +
                                      ylab('hPa') +
                                      theme(axis.ticks.x=element_blank()))
    })
}

shinyApp(ui=ui, server=server, options=list(port=1337))
