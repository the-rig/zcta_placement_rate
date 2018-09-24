library(leaflet)
library(feather)
library(dplyr)

placement_counts <- read_feather("placement_counts.feather")
zcta_counts <- read_feather("zcta_counts.feather") %>%
  rename(zcta = GEOID)
weighted_and_raw <- read_feather("weighted_and_raw.feather")
m <- readRDS("map.rds")

function(input, output, session) {
  
  output$download_placements <- downloadHandler(
    filename = function() {
      "placement_counts.csv"
    },
    content = function(file) {
      write.csv(placement_counts, file)
    }
  )
  
  output$download_zcta <- downloadHandler(
    filename = function() {
      "zcta_counts.csv"
    },
    content = function(file) {
      write.csv(zcta_counts, file)
    }
  )
  
  output$download_aggr <- downloadHandler(
    filename = function() {
      "weighted_and_raw.csv"
    },
    content = function(file) {
      write.csv(weighted_and_raw, file)
    }
  )
  
  # Store last zoom button value so we can detect when it's clicked
  lastZoomButtonValue <- NULL
  
  output$removal_map <- renderLeaflet({

    map <- m
    
    rezoom <- "first"
    # If zoom button was clicked this time, and store the value, and rezoom
    if (!identical(lastZoomButtonValue, input$zoomButton)) {
      lastZoomButtonValue <<- input$zoomButton
      rezoom <- "always"
    }
    
    map <- map %>% mapOptions(zoomToLimits = rezoom)
    
    map
  })
}