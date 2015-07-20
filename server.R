library(shiny)

math_df <- data.frame(n = 1:4, l = c("+", "-", "*", "/"))
ns = 10000
f.sum <- function(x, y){x + y}
f.min <- function(x, y){x - y}
f.mul <- function(x, y){x * y}
f.div <- function(x, y){ifelse(y != 0, x/y, x)}

shinyServer(function(input, output) {

        normals <- reactive({rnorm(n = ns, mean = 0, sd = input$n_sd)})
        poissons <- reactive({rpois(n = ns, lambda = input$p_lambda)})
        uniforms <- reactive({runif(n = ns, min = input$u_min, max = input$u_max)})
        exponentials <- reactive({rexp(ns, rate = input$e_rate)})
        
        x <- reactive({
                # input$n_mean
                input$n_sd; input$p_lambda; input$u_min; input$u_max; input$e_rate
                sample(1:4, 3, replace = FALSE)
        })
        
  output$distributions <- renderPlot({
          par(mfrow=c(2,2))
          hist(normals())
          hist(poissons())
          hist(uniforms())
          hist(exponentials())
  })
  
  output$math_transforms <- renderText({ paste("New sequence = (((normals", math_df[math_df==x()[1], 2],
                                               "poissons)", math_df[math_df==x()[2], 2],
                                               "uniforms)", math_df[math_df==x()[3], 2], "exponentials)")
  })
  
  output$Benford <- renderPlot({
          
          f.ran <- function(a, b, c, d){
                  
                  r <- c(f.sum, f.min, f.mul, f.div)[x()]
                  real <- r[[1]](a, b)
                  real <- r[[2]](real, c)
                  real <- r[[3]](real, d)
          }
          
          real <- f.ran(normals(), poissons(), uniforms(), exponentials())
          real <- real[real != 0 & !is.na(real)]
          real <- real[sample(x = 1:ns, size = 10000, replace = TRUE)]
          
          real <- as.integer(substr(as.character(format(abs(real), scientific = TRUE)), start = 1, stop = 1))
          
          bp <- barplot(table(real), 
                        main = "First digit appearance counts", 
                        xlab = "first digit from generated number sequence",
                        ylab = "count"
          )
          lines(x = bp, y = log10(1 + 1/1:9) * ns, col = "red", lty = 3, lwd = 5)
          legend("topright", "Benford's law first digit distribution", col = "red",
                 text.col = "black", lty = 3, lwd = 4,
                 merge = TRUE, bg = "white")
  })

})
                        