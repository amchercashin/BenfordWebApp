
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
        p("In this section you can play with parameters of 4 different distributions 
          (you can see their histograms at the right)."),
        tags$p("Every time you change something:"),
        tags$ol(
                tags$li("A new sample of 10 000 numbers for that distribution is generated."), 
                tags$li("3 random arithmetic operations between this new and 3 other samples are performed 
                       elementwise with the result of some 10 000 numbers sequence."), 
                tags$li("Histogram of only first digits of these numbers generated. And you can see how it 
                        conforms to", tags$a(href="https://en.wikipedia.org/wiki/Benford%27s_law", 
                                             "Benford's law"))
        ),
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
                  "Uniforms maximum:",
                  min = 10,
                  max = 20,
                  value = 10),
      sliderInput("e_rate",
                  "Exponentials rate:",
                  min = 1,
                  max = 10,
                  value = 3)#,
       #submitButton()
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
