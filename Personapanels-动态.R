### Shiny Dashborad ###
library(shiny)
library(shinydashboard)
library(quanteda)
library(dplyr)
library(quanteda.corpora)
library(tidytext)
library(knitr)
library(ggplot2)
library(readtext)
library(stopwords)
ui <- dashboardPage(skin = "red",
                    dashboardHeader(title = "数据处理"),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("文章上传",tabName = "file",icon=icon("file-text-o")),
                        menuItem("文章显示",tabName = "text",icon = icon("file-text-o")),
                        menuItem("词云",tabName = "wordcloud",icon = icon("cloud"))
                        )
                    ),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "file",
                                fileInput("selection","上传文件",multiple = TRUE),
                                helpText(paste("注：请使用txt格式文件。"),
                                         br(),
                                         br())),
                        tabItem(tabName = "text",
                                helpText(paste("此按钮显示文本")),
                                actionButton("display","呈现"),
                                br(),
                                br(),
                                box(title = "文本整体",textOutput("text",inline = FALSE),width = 450)),
                        tabItem(tabName = "wordcloud",
                                fluidRow(
                                  box(actionButton(inputId = "update", label = "创建词云"),
                                      sliderInput("freq","至少词语数量:",min = 1,  max = 100, value = 10),
                                      sliderInput("max","至多词语数量:",min = 1,  max = 500,  value = 25),
                                      selectInput(inputId = "pal",label = "词云颜色",choices = c("Dark"="Dark2","Pastel One"="Pastel1","Pastel Two"="Pastel2","Set One"="Set1",
                                                                                                    "Set Two"="Set2","Set Three"="Set3"),selected = "Dark2"),
                                      downloadButton("download1","下载词云"),
                                      selectInput(inputId = "download3",label = "保存格式:",choices = list("png","pdf","bmp","jpeg"))),
                                  box(plotOutput("plot"))))

  )
))



server <- function(input,output){
  ford <- reactive({ 
    req(input$selection) 
    inFile <- input$selection 
    df <- readLines(inFile$datapath)
    return(df)})

  GTM <-function(f){
    Text <- readLines(f$datapath,encoding = "UTF-8")
    ch_corpus <- corpus(Text)
    ch_stop <- stopwords("zh",source = "misc")
    ch_corpus<- ch_corpus[-grep("\\b\\d+\\b",ch_corpus$metadata),]
    ch_corpus<- gsub("\\s+","",ch_corpus)
    ch_corpus <- ch_corpus %>% tokens(remove_punct = TRUE) %>% tokens_remove(pattern=ch_stop)
    m <- dfm(ch_corpus)
  }
  terms <- reactive({
    GTM(input$selection)
  })
  
    
  observeEvent(input$update,{output$plot <- renderPlot({
    inFile <- input$selection
    if (is.null(inFile))
      return("Please Upload File")
    withProgress(message = 'Creating WordCloud',
                 value = 0, {
                   for (i in 1:3) {
                     incProgress(1/3)
                     Sys.sleep(0.75)
                   }
                 },env = parent.frame(n=1))
    set.seed(50)
    v <- terms()
    textplot_wordcloud(v, min_count = 40, random_order = FALSE,rotation = .25, max_words = 80,min_size = 1.0, max_size = 3.8,font = if (Sys.info()['sysname'] == "Darwin") "SimHei" else NULL,color = RColorBrewer::brewer.pal(8, "Dark2"))
  })})
  
  
  
  
  
  observeEvent(input$display,{output$text<-renderText({
    inFile <- input$selection
    if (is.null(inFile))
      return("Please Upload File")
    ford()})})
  
  
}

shinyApp(ui,server)

