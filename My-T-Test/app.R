#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(mypackage)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Binsaleh T-Test Computer - DSA 5041"),
  sidebarLayout(
    sidebarPanel(
      numericInput("n", "Length of the vectors:", value = 30),
      numericInput("meanx", "Mean of x:", value = 10),
      numericInput("meany", "Mean of y:", value = 8),
      numericInput("stdx", "Standard deviation of x:", value = 15),
      numericInput("stdy", "Standard deviation of y:", value = 15),
      numericInput("alpha", "Alpha:", value = 0.05),
      checkboxInput("paired", "Paired:", value = FALSE),
      actionButton("ttest", "Perform t-test")

    ),
    # Add a panel to show t-test results
    mainPanel(
      plotOutput("boxplot"),
      verbatimTextOutput("ttest_result")
    )
  )
)

# Define server logic
server <- function(input, output) {

  # Create reactive values to store x and y vectors
  x <- reactiveVal(NULL)
  y <- reactiveVal(NULL)
  tt <- reactive(NULL)

  # Define function to create x and y vectors
  create_vectors <- function() {
    x_val <- rnorm(input$n, mean = input$meanx, sd = input$stdx)
    y_val <- rnorm(input$n, mean = input$meany, sd = input$stdy)
    x(x_val)
    y(y_val)
  }

  # Perform t-test
  t_test <- eventReactive(input$ttest, {
    create_vectors()
    t_test_res = myttest(x(), y(), alpha = input$alpha, paired = input$paired)
    output$boxplot <- renderPlot({plot(t_test_res)})
    output$ttest_result <- renderPrint({print(t_test_res)})
  })


  # Create vectors and perform t-test
  observeEvent(input$ttest, {
    t_test()
  })

}

# Run the Shiny app
shinyApp(ui = ui, server = server)
