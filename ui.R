### ui.R
library(shiny)

shinyUI(fluidPage(
  
  div(
    h1("Finite Population Central Limit Theorem"),
    style = "text-align: center; margin-top: 20px; margin-bottom: 30px;"
  ),
  
  fluidRow(
    column(4,
           sliderInput("N", "Population size 'N'", min = 1, max = 20000, value = 1000),
           sliderInput("n", "Sample Size 'n'", min = 1, max = 1000, value = 30)
    ),
    column(8, style = "font-size:100%",
           tags$div(
             style = "padding: 18px; background-color: #f9f9f9; border-radius: 8px;",
             tags$p("This is a variant of CLT which is widely used in sampling theory."),
               tags$p("1. Give a fixed population with finite size 'N'."),
               tags$p("2. Draw a sample of size 'n' with replacement and calculate the mean."),
               tags$p("3. Replicate 2. for 1,000 times."),
               tags$p("4. Draw histogram of the 1,000 sample means.")
            
           )
    )
  ),
  
  fluidRow(
   column(3,selectInput( "select", "Population", 
                        choices = c("select one","Exponential", "Normal", "Mixture Normal") 
                       ),
   conditionalPanel(
    condition = "input.select == 'Exponential'",
    numericInput("rate", "Rate", value = 1,min = 0.0001, step = 0.1)),
   conditionalPanel(
    condition = "input.select == 'Normal'",
    numericInput("mean", "Mean", value = 0),
    numericInput("sd", "Stand Deviation", value = 1)),
   conditionalPanel(
     condition = "input.select == 'Mixture Normal'",
     column(6,numericInput("mean1", "Mu1", value = -2),
            numericInput("mean2", "Mu2", value = 2),
            numericInput("weight", "p", value = 0.5, min = 0, max = 1)),
     column(6,numericInput("sd1", "SD1", value = 1),
            numericInput("sd2", "SD2", value = 1)))),
   column(1,actionButton("go", "GO")),
    column(4,plotOutput("bar1")),
    column(4,plotOutput("bar2"))
    
    
        )
  
  ))
