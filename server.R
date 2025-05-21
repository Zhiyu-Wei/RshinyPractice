### server.R
library(shiny)

### server.R

# server function
shinyServer(function(input, output) {
  # define event-reactive function
  popexp <- eventReactive(input$go,{
    req(input$select == "Exponential")
    rexp(input$N,rate=input$rate)
  })
  
  popnor <- eventReactive(input$go,{
    req(input$select == "Normal")
    rnorm(input$N,input$mean,input$sd)
  })
  
  popmixnor <- eventReactive(input$go,{
    req(input$select == "Mixture Normal")
    c(rnorm(input$N*input$weight,input$mean1,input$sd1),
      rnorm(input$N*(1-input$weight),input$mean2,input$sd2))
    
  })
  
  
  
  genexp <- eventReactive( input$go, { 
    req(input$select == "Exponential") 
    rowMeans(matrix(sample(popexp(),input$n*1000,replace = T),1000,input$n))
  })
  
  gennor <- eventReactive( input$go, { 
    req(input$select == "Normal") 
    rowMeans(matrix(sample(popnor(),input$n*1000,replace = T),1000,input$n))
  })
  
  genmixnor <- eventReactive( input$go, { 
    req(input$select == "Mixture Normal") 
    rowMeans(matrix(sample(popmixnor(),input$n*1000,replace = T),1000,input$n))
  })
  
  
  # display results obtained from 'gen'
  output$bar1 <- renderPlot({
    validate(
      need(input$select != "select one", "選擇一個分配")
    )
    if (input$select == "Exponential") {
      validate(
        need(input$rate > 0, "⚠️ Rate 必須大於 0")
      )
      hist(popexp(), main = "Population",freq=F,xlab="")
    }else if (input$select == "Normal"){
      hist(popnor(), main = "Population",freq=F,xlab="")
    }else{
      hist(popmixnor(), main = "Population",freq=F,xlab="")
    }
    
  })
  output$bar2 <- renderPlot({
    validate(
      need(input$select != "select one", "選擇一個分配")
    )
    if (input$select == "Exponential") {
      validate(
        need(input$rate > 0, "⚠️ Rate 必須大於 0")
      )
      hist(genexp(), main = "Histogram of Sample Mean",freq=F,xlab="Sample Mean")
    }else if(input$select == "Normal"){
      hist(gennor(), main = "Histogram of Sample Mean",freq=F,xlab="Sample Mean")
      
    }else{
      hist(genmixnor(), main = "Histogram of Sample Mean",freq=F,xlab="Sample Mean")
    }
    
  })
  
  
})