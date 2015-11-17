
palette(c("#4DAF4A", "#984EA3","#FF7F00", "#FFFF33", "#A65628", "#F781BF"))

shinyServer(function(input, output, session){

  # Selected variables into a new data frame
  selectedData <- reactive({
    df2[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  output$plot1 <- renderPlot({
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 3, cex = 4, lwd = 3)
  })
  
  # Map rendering
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(data = points) %>%
      clearShapes()
  })
  
}
)










