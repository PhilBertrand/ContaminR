### A shiny app for monitoring contaminants in seabird community of St-Lawrence region
### version 1.0.1

library(shiny)
library(plotly)
library(leaflet)
library(tidyverse)
library(htmltools)
library(shinyjs)
library(shinyjqui)
library(formattable)
library(DT)


# Load data
setwd("C:/Scripts/")
df <- read.delim("Dataset.csv",sep=";")

# Defining colors
colorsmap = colors()[1:length(unique(df$Tissue))]
groupColors = colorFactor(palette = "viridis", domain = df$Tissue)
mypalette <- groupColors(unique(df$Tissue))
mypalette <- setNames(mypalette, unique(df$Tissue))

## CSS snippet for Acknolewdgments page
backgroundImageCSS <- "background-size: cover;
                       height: 100vh;
                       width: 100vw;
                       background-repeat: no-repeat;
                       background-attachment: fixed;
                       background-position: left;
                       background-image: url('%s');"