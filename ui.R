
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

#checking that the dependencies exist
req.packages=c("shiny","jpeg","tesseract","wordcloud","tm","RColorBrewer","quanteda","DT")
if(any(! req.packages  %in% installed.packages()))
  stop(
    paste0("Not all dependent packages are installed on your computer.\n Please install: ",
           paste(req.packages[!req.packages %in% installed.packages()],collapse=","),
           ". See '?install.packages' for more information on how to install R packages.")
  )

library(shiny)

library(jpeg)
library(tesseract)
library(wordcloud)
library(tm)
library(RColorBrewer)
library(quanteda)
library(DT)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("OCR an image with the tesseract R package"),
  
  sidebarLayout(
    sidebarPanel(width = 3,
      
      fileInput('file1', 'Choose an image (max 5MB)'),
      tags$hr(),
      numericInput("maxwords", "Max number words in cloud",value=100),
      numericInput("minfreq", "Minimum word frequency in cloud", value=2),
      checkboxInput("stopwords", "Remove (English) stopwords", value = FALSE)
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel(
          "Introduction",
          htmlOutput("intro")
        ),
        tabPanel(
          "Image & extracted text",
          fluidRow(
            column(
              width=7,
              imageOutput("plaatje")
            ),
            column(
              width=5,
              verbatimTextOutput("OCRtext")
            )
          )
        ),
        tabPanel(
          "Extracted text as sentences",
          DT::dataTableOutput("sentences")
        ),
        tabPanel(
          "Wordcloud",
          plotOutput("cloud", height = "800px")
        )
      )
    )
  )
))
