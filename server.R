library(shiny)
library(plotly)

#-------------------------------------------------------------------------
# Function Name:    convertCyl()
# Function Summary: Given a numeric value passed in, this function returns
#                   a string showing the number of cylinders
#-------------------------------------------------------------------------
convertCyl <- function(numCyl)
{
    paste(numCyl, "cylinders")    
}



# Define server logic required to draw a histogram
shinyServer(function(input, output)
{
    output$mpgPlot <- renderPlotly({
        # build the filter based on the number of cylinders the user wishes to plot
        cylList  <- c()
        fourCyl  <- input$fourCyl
        sixCyl   <- input$sixCyl
        eightCyl <- input$eightCyl
        
        if (fourCyl == TRUE)
        {
            cylList <- c(cylList, 4)
        }

        if (sixCyl == TRUE)
        {
            cylList <- c(cylList, 6)
        }

        if (eightCyl == TRUE)
        {
            cylList <- c(cylList, 8)
        }
        useVehicle <- mtcars$cyl %in% cylList

        # make a copy of the mtcars data frame, filtering on the number of cylinders as required
        # and then create a new column with string versions of the number of cylinders column
        carData <- mtcars[useVehicle,]
        carData$cylinders <- convertCyl(carData$cyl)
        carData$name <- rownames(carData)
        
        # set up some labels for the chart
        xAxis <- list(
            title = "Vehicle Weight (1,000lbs)"
        )
        
        yAxis <- list(
            title = "Engine Displacement (Cubic Inches)"
        )
        
        zAxis <- list(
            title = "MPG"
        )
        
        # create a 3D scatterplot of the car data, plotting the vehicle weight against
        # engine displacement against miles per gallon, using the number of cylinders
        # as a fourth dimension in colour.
        #
        # Then, pipe that through some layout to change the axes labels.
        plot_ly(carData, 
                type="scatter3d",
                x = carData$wt, 
                y = carData$disp, 
                z = carData$mpg, 
                mode = "markers", 
                hoverinfo = "text",
                text = ~paste("Vehicle: ", carData$name,
                              "<br>Weight: ", carData$wt,
                              "<br>Displacement: ", carData$disp,
                              "<br>MPG: ", carData$mpg),
                color = as.factor(carData$cylinders), 
                width = 750,
                height = 750) %>%
            
            layout(title = "Fuel Economy for Various Vehicle Weights and Engine Displacements",
                   scene = list(xaxis = xAxis,
                                yaxis = yAxis,
                                zaxis = zAxis))
    
    })
})

