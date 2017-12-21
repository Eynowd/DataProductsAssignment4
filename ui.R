library(shiny)

shinyUI(fluidPage(
    titlePanel("Predict MPG from Vehicle Weight and Engine Displacement"),
    sidebarLayout(
        sidebarPanel(
            h3("Select the number of cylinders to show in the plot:"),
            checkboxInput("fourCyl",  "4 cylinders", value = TRUE),
            checkboxInput("sixCyl",   "6 cylinders", value = TRUE),
            checkboxInput("eightCyl", "8 cylinders", value = TRUE),
            h4("Notes:"),
            p("Use the checkboxes above to select the number of cylinders to display in the plot."),
            p("If the plot does not appear, move the mouse over the plot area."),
            p("Click and drag on the image to rotate the plot."),
            p("Hover the mouse cursor over a plot point to see details on the vehicle.")
        ),
        mainPanel(
            plotlyOutput("mpgPlot")
        )
    )
))