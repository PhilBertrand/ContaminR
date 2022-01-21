
server <- function(input, output, session) {
  
  filter_df <- reactive({
    req(input$Species, input$TissueType)
    filter(df, Species %in% input$Species, Tissue %in% input$TissueType)
  })
  
  output$map <- renderLeaflet({
    leaflet(data = filter_df()) %>% 
      addTiles() %>% 
      setView(-73.00, 45.54, zoom = 9) %>% 
      addCircleMarkers(lat = ~ Latitude, lng = ~ Longitude, stroke = FALSE,
                       fillOpacity = 0.95, radius = 5, color = ~ groupColors(Species)) %>%
      addLegend(pal = groupColors, values = ~ Species)
    
  })
  
  output$plot <- renderPlot({
    
    print(ggplot(data = filter_df(), aes(Year, as.numeric(H20), col = Species, fill = Species)) +
            geom_smooth(method = loess, formula = y ~ x, alpha = 0.15) +
            geom_point(shape = 21, col = "black") +
            theme_bw(base_size=12) +
            labs(x = "Year", y = "Contaminant concentration") +
            theme(legend.position = "bottom"))
  })
  
  output$table <- DT::renderDT({
    
    return(as.datatable(formattable(df, list(H20 = color_tile("transparent", "pink"), 
                                             Dieldrine = color_tile("transparent", "pink"), 
                                             Aroclor = color_tile("transparent", "pink"))),
                        filter="top", options = list(scrollY = TRUE, scrollX = TRUE,
                                                     autoWidth = TRUE, buttons = c('csv', 'excel'),
                                                     pageLength = 10, lengthMenu = list(c(10, 25, 50, -1), c('10', '25', '50', 'All')),
                                                     dom = c('Blfrtip'),
                                                     server = FALSE),
                        extensions = 'Buttons'
    ))
    
  })
  
}