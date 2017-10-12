# ui

library(shiny)
library(ggplot2)
library(dplyr)

fluidPage(
        titlePanel("Deceased after 50 in Barcelona by District (2015-2016)"),
        sidebarLayout(
                sidebarPanel(
                        radioButtons("yearInput", "Year",
                                     choices = c("2015","2016"),
                                     selected = "2016"),
                        selectInput("district", "District",
                                    choices = colnames(bd[2:11])),
                        hr(),
                        helpText("Data from Open Data BCN")
                ),
                mainPanel(
                        plotOutput("bdplot")
                )
        )
)