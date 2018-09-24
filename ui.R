library(shinydashboard)
library(leaflet)

header <- dashboardHeader(
  title = "Washington Placement Rates by ZCTA", titleWidth = 400
)

body <- dashboardBody(
  fluidRow(
    column(width = 3,      
            actionButton("zoomButton", "Zoom to fit")
            ,tags$br()
            ,downloadLink("download_placements", "Download Placement Data")
            ,tags$br()
            ,downloadLink("download_zcta", "Download ZCTA Data") 
            ,tags$br()
            ,downloadLink("download_aggr", "Download Map Data")
    ) 
    ,column(width = 9,
           box(width = NULL, solidHeader = TRUE,
               leafletOutput("removal_map", height = 500)
           )
    )))  
    

dashboardPage(
  header,
  dashboardSidebar(disable = TRUE),
  body
)
