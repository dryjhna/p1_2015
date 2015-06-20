

shinyUI(
  fluidPage(theme=shinytheme("flatly"),
  pageWithSidebar(
  headerPanel("Data View & Exploratory Analysis"),

##UI CODE FOR SIDEBAR  
  sidebarPanel(
    
    helpText("This app allows users to upload & analyze a csv file from their own hard drive for instant analysis.
              IRIS dataset is used as a default case, if no new dataset has been uploaded
             "),
    ##GET FILE INPUT FROM USER
    fileInput('file1', 'Choose CSV File from local drive, adjusting parameters if necessary',
              accept=c('text/csv', 'text/comma-separated-values,text/plain',".csv",".txt")),
    
    ##SELECT IF THE USER WANTS HEADERS TO BE INCLUDED OR NOT
    helpText("Select if you need to read headers"),
    checkboxInput('header', 'Header', TRUE),
    
    ##OPTION TO SELECT DELIMITER
    helpText("Select the delimiter"),
    radioButtons('sep', 'Separator',
                 c(Comma=',',
                   Semicolon=';',
                   Tab='\t'),
                 ','),
    ##OPTION TO SELECT TEXT QUALIFIER
    radioButtons('quote', 'Quote',
                 c(None='',
                   'Double Quote'='"',
                   'Single Quote'="'"),
                 '"')
    
    ),

##MAIN PANEL UI

  mainPanel(
    ##DEFINE TABS IN MAIN PANEL
    tabsetPanel(
      tabPanel("Documentation",               
               h3("Instructions to use the APP"),
               h4("Sidebarpanel"),
               tags$ul(tags$li("Sidepar Panel allows you to upload a csv file from your local machine"),
                       tags$li("Select 'Header' checkbox if you would like to read the headers from the uploaded text file"),
                       tags$li("Select the delimiter of the uploaded text file"),
                       tags$li("Select any text qualifier if used")),
               h4("Data View"),
               tags$ul(tags$li("Data View tab panel shows a table view of the uploaded data"),
                       tags$li("You can select the number of records to be displayed at a time, page through the records or sort the table by any column by clicking on column headers")),
               h4("Exploration View"),
               tags$ul(tags$li("Exploration View allows to do a simple analysis on the uploaded data"),
                       tags$li("Select X axis, Y axis and Color variables from dropdown"),
                       tags$li("The graph shows regression line for Y~X"),
                h4("Note: 'IRIS dataest  -from Fisher, 1936' is used as the default dataset"),  
               
               h4("Upload dataset of smaller size, the app would become irresponsive for very large datasets")),               value = 1),
      
      ##FIRST TAB TO SHOW PAGEABLE DATA VIEW
      tabPanel("Data View",               
               dataTableOutput("tableView"),
               value = 2),
      
      ##SECOND TAB TO SELECT AND ANALYZE VARIABLES
      tabPanel("Exploration View",
               flowLayout( uiOutput("xAxis"),
                           uiOutput("yAxis"), 
                           uiOutput("colour")),
               
               plotOutput("sPlot"),
               value = 3),
    id="tabs1")
    
  )
  )))