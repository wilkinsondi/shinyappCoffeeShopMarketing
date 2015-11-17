
#Require packages
require(shiny)
require(leaflet)

shinyUI(pageWithSidebar(
  headerPanel('Soho Coffee Shops: Cluster Analysis'),
  sidebarPanel(
    h6('This application is for grouping coffee shops in Soho, London. 
        Choose the number of clusters, and the pairwise clustering terms based on distance from Oxford St., popularity, the number of ratings, distance rank and popularity rank.'),
    h6('The map below shows the locations of the coffee shops.'),
    selectInput('xcol', 'X Variable', names(df2),selected=names(df2)[[5]]),
    selectInput('ycol', 'Y Variable', names(df2),
                selected=names(df2)[[4]]),
    numericInput('clusters', 'Number of clusters', 3,
                 min = 1, max = 6),
    h6('Rank 1 = nearest (distance) and most popular (popularity).'),
    h6('Notes: distances are from Oxford Circus and calculated as the bird flies minimizing latitude and longitude co-ordinates.'),
    h6('distfactor = coffes shop (lat,lon) - Oxford Circus (lat,lon).'),
    h6('Reviews are the number of reviews as at 16Nov15 on Yelp.com.'),
    h6('Popularity is average weighting divided by the square root of number of reviews.'),
       h6('Cluster selector does not work on Microsoft Edge, please use another browser such as Firefox or Chrome.')
                ),
  mainPanel(
    plotOutput('plot1'),
    leafletOutput("mymap")
            )
                        )
        )




palette(c("#4DAF4A", "#984EA3","#FF7F00", "#FFFF33", "#A65628", "#F781BF"))
points <- cbind(placelon,placelat)

server <- function(input, output){
  
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











