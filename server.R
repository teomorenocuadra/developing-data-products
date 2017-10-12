# server

function(input, output) {
        output$yearOutput <- renderUI({
                selectInput("yearInput", "Year",
                            sort(unique(bd$Year)),
                            selected = "2016")
        })  
        
        filtered <- reactive({
                if (is.null(input$yearInput)) {
                        return(NULL)
                }    
                
                bd %>%
                        filter(Year == input$yearInput)
        })
        
        output$bdplot <- renderPlot({
                if (is.null(filtered())) {
                        return()
                }
                ggplot(data = filtered(), aes(x = Group,  y = filtered()[, input$district])) +
                        geom_bar(stat = "identity", fill = "steelblue") +
                        geom_text(aes(label = filtered()[, input$district]), vjust = -0.3, size = 3.0) +
                        labs(x = "Age Group", y = "Count")
        })
}

