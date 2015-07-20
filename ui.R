
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Benford's law check on simulated random data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
#       sliderInput("n_mean",
#                   "Normals mean:",
#                   min = -1000,
#                   max = 1000,
#                   value = 0),
      sliderInput("n_sd",
                  "Normals standart deviation:",
                  min = 1,
                  max = 100,
                  value = 50),
      sliderInput("p_lambda",
                  "Poissons lambda:",
                  min = 1,
                  max = 10,
                  value = 5),
      sliderInput("u_min",
                  "Uniforms minimum:",
                  min = 0,
                  max = 9,
                  value = 0),
      sliderInput("u_max",
                  "Uniforms minimum:",
                  min = 10,
                  max = 20,
                  value = 10),
      sliderInput("e_rate",
                  "Exponentials rate:",
                  min = 1,
                  max = 10,
                  value = 3),
       submitButton()
    ),    
    

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distributions"),
      p("Making numbers sequence using 4 different indicated above distributions with these random chosen arithmetic operations:"),
      verbatimTextOutput("math_transforms"),
      plotOutput("Benford")
    )
  )
))
