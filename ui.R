
ui <- fluidPage(
  
  navbarPage("ContaminR", 
             
             tabPanel("Introduction", 
                      
                      # tag css landing page
                      tags$head(tags$link(href="StyleLanding.css", rel="stylesheet", type="text/css")),
                      
                      # parent
                      tags$div(class="landing-wrapper",
                               
                               # child1
                               tags$div(class="landing-block background-content",
                                        tags$img(src="BobBrewer.jpg", alt="Northern Gannet"),
                                        tags$img(src="KMitchHodge.jpg", alt="Black guillemot"),
                                        tags$img(src="SimonBerger.jpg", alt="Great cormorant"),
                                        tags$img(src="NicholasKampouris.jpg", alt="Atlantic puffin")),
                               
                               # child2
                               tags$div(class="landing-block foreground-content",
                                        
                                        tags$div(class="foreground-text",
                                                 
                                                 tags$h1(code("ContaminR"), "is a Shiny app to import, filter and 
                                                                            visualize contaminant concentration data from birds and wildlife 
                                                                            in Québec"),
                                                 
                                                 tags$p(strong("Background: "), "Contaminants data have been generated 
                                                                                over many decades across Québec as part of several monitoring or 
                                                                                research programs. Monitoring programs are maintained by Environment
                                                                                and Climate Change Canada. For details on the various programs, 
                                                                                contact Raphaël Lavoie, raphael.lavoie@ec.gc.ca"),
                                                 
                                                 tags$p(strong("Instructions: "), "To start, select a species, a tissue,
                                                                                  and a contaminant of interest in the ", em("Time series and mapping"),
                                                                                  " page. Data can be vizualized in a scatter plot and a map. Selected 
                                                                                  data are available for visualization and download in the ", 
                                                        em("Data tables")," page"),
                                                 
                                                 tags$p(strong("Authors: "), "Raphaël Lavoie, Science and Technology, 
                                                                              raphael.lavoie@ec.gc.ca"),
                                                 
                                                 br(),
                                                 
                                                 img(src= "logoEC.png", height="80%", width="80%", align = "center")),
                                        
                               ))
             ),
             
             tabPanel("Times series and mapping",
                      
                      useShinyjs(),
                      
                      tags$div(class="outer",
                               
                               tags$link(href="style_map.css", rel="stylesheet", type="text/css"),
                               
                               leafletOutput("map", height = "100vh"),
                               
                               jqui_resizable(absolutePanel(id = "controls", class = 
                                                              "panel panel-default", fixed = TRUE,
                                                            draggable = TRUE, top = 60, left = "auto", right = 20, 
                                                            bottom = "auto", width = 400, height = "auto",
                                                            
                                                            h2("Contaminants"),
                                                            
                                                            selectInput(inputId = "Species",
                                                                        label = "Choose a species to display",
                                                                        choices = unique(df$Species),
                                                                        selected = "Ardea herodias",
                                                                        multiple = TRUE),
                                                            
                                                            selectInput(inputId = "TissueType",
                                                                        label = "Choose a tissue to display",
                                                                        choices = unique(df$Tissue),
                                                                        selected = "Oeuf",
                                                                        multiple=TRUE),
                                                            
                                                            plotOutput(outputId = "plot")))
                               
                      )
             ),
             
             tabPanel("Data tables", dataTableOutput(outputId="table")),
             
             tabPanel("Acknowledgments", 
                      
                      style = sprintf(backgroundImageCSS, 'RayHennessy.jpg'),
                      
                      sidebarLayout(
                        
                        sidebarPanel(
                          
                          tags$p(strong('Acknowledgments'), style = 'font-size: 2.5vw;'),
                          
                          p(code("ContaminR"),"wants to thanks:",
                            tags$ul(
                              tags$li("Bob Brewer - Northern gannet picture"), 
                              tags$li("K. Mitch Hodge - Black guillemot picture"), 
                              tags$li("Simon Berger - Great cormorant"),
                              tags$li("Nicholas Kampouris - Atlantic puffin"),
                              tags$li("Simon Berger - Great cormorant"),
                              tags$li("Ray Hennessy - Razorbill")), style = 'font-size: 1vw;'),
                          
                          strong("All pictures are available via https://unsplash.com/"),
                          
                          br(),
                          
                          p('Warm thanks to Dr. Louise Champoulx', em('et al'),'. for prior works on the contaminant
                         database in Québec'),
                          
                          br(),
                          
                          img(src= "logoEC.png", height="80%", width="80%", align = "center")),
                        
                        mainPanel()))
             
  ))

