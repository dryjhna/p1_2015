shinyServer(function(input, output) {
  
  ds <- as.data.frame(NULL)
  Data <- reactive({
    
    
    # input$file1 will be NULL initially. After the user selects and uploads a 
    # file, it will be a data frame with 'name', 'size', 'type', and 'datapath' 
    # columns. The 'datapath' column will contain the local filenames where the 
    # data can be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(iris)
    
    df.raw <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
    
    ds <- df.raw
    # create a list of data for use in rendering
    return(df.raw)
    
  })
  
  
  
  # allows pageability and number of rows setting
  

  
  output$xAxis <- renderUI({ selectInput("xAxis","X variable",names(Data()))})
  output$yAxis <- renderUI({ selectInput("yAxis","Y variable",names(Data()),selected = names(Data())[2])})
  output$colour <- renderUI({ selectInput("colour","Select colour variable",names(Data()),names(Data())[3])})
  output$shape <- renderUI({ selectInput("shape","Select shape variable",names(Data()))})
  output$selectReg <- renderUI({ selectInput("selectReg","Select Variable for regression analysis",names(Data()))})
  axis <- reactive({
    ds <- Data()[,c(as.name(input$xAxis),as.name(input$yAxis))]
    return(ds)
  })
  
  output$tableView <- renderDataTable(Data(), server= TRUE) 

  output$sPlot <- renderPlot({
        
    xp <- qplot(get(input$xAxis), get(input$yAxis), data = Data(),color = get(input$colour),geom = c("point", "smooth"), method="lm"
                ,xlab = input$xAxis, ylab = input$yAxis)
    xp
    
    
  })  
  
  
  
  
  
  
})