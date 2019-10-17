library(shiny)
library(ggplot2)

ui <- fluidPage(
  
    sliderInput(
      inputId = "num",
      label = "Choose a number",
      value = 500,
      min = 1,
      max = 1000
    ),
    sliderInput(
      inputId = "mean",
      label = "Choose mean value",
      value = 0,
      min = -500,
      max = 500
    ),
    sliderInput(
      inputId = "sd",
      label = "Choose standard deviation",
      value = 5,
      min = 0,
      max = 100
    ),
    sliderInput(
      inputId = "bw",
      label = "Choose binwidth",
      value = 1,
      min = 0.1,
      max = 10
    ),
  
  plotOutput("hist"),
  verbatimTextOutput("stats"),
  downloadButton("downloadData", "Download Data as .csv")
)

server <- function(input, output) {
  data <- reactive({
    as.data.frame(rnorm(input$num, input$mean, input$sd))
  })
  
  output$hist <- renderPlot({
    ggplot(
      data(),
      aes(
        x = data()[, 1],
        mean = input$mean,
        sd = input$sd,
        binwidth = input$bw,
        n = input$n
      )
    ) +
      geom_histogram(
        binwidth = input$bw,
        colour = "white",
        fill = "cornflowerblue",
        size = 0.1
      ) +
      geom_freqpoly(size = 1.5, color = "white") +
      labs(x = "x",
           y = "numbers",
           caption = "(showing a histogram plot of random numbers)")
  })
  
  output$stats <- renderPrint({
    summary(data())
  })
  
  # Downloadable csv of selected dataset ----
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$data, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(data(), file, row.names = FALSE)
    }
  )
}

shinyApp(ui = ui, server = server)
