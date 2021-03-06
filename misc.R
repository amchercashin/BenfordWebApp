ns = 10000

normals <- rnorm(n = ns, mean = 0, sd = 1)
poissons <- rpois(n = ns, lambda = 2)
uniforms <- runif(n = ns, min = 0, max = 1)
exponentials <- rexp(ns, rate = 10)

f.sum <- function(x, y){x + y}
f.min <- function(x, y){x - y}
f.mul <- function(x, y){x * y}
f.div <- function(x, y){ifelse(y != 0, x/y, x)}

x<-0
f.ran <- function(a, b, c, d){
        x <<- sample(1:4, 3, replace = FALSE)
        r <- c(f.sum, f.min, f.mul, f.div)[x]
        real <- r[[1]](a, b)
        real <- r[[2]](real, c)
        real <- r[[3]](real, d)
}

real <- f.ran(normals, poissons, uniforms, exponentials)
math_df <- data.frame(n = 1:4, l = c("+", "-", "*", "/"))

math_str <- paste("normals", math_df[math_df==x[1], 2],
                  "poissons", math_df[math_df==x[2], 2],
                  "uniforms", math_df[math_df==x[3], 2], "exponentials")
real <- real[real != 0 & !is.na(real)]
real <- real[sample(x = 1:ns, size = 10000, replace = TRUE)]

real <- as.integer(substr(as.character(format(abs(real), scientific = TRUE)), start = 1, stop = 1))

par(mfrow=c(1,1))
bp <- barplot(table(real), 
              main = "First digit appearance counts", 
              xlab = "first digit from generated number sequence",
              ylab = "count"
              )
lines(x = bp, y = log10(1 + 1/1:9) * ns, col = "red", lty = 3, lwd = 5)
legend("topright", "Benford's law first digit distribution", col = "red",
              text.col = "black", lty = 3, lwd = 4,
              merge = TRUE, bg = "white")


par(mfrow=c(2,2))
hist(normals)
hist(poissons)
hist(uniforms)
hist(exponentials)
#t <- benford(real, number.of.digits = 1, sign = "both", discrete=TRUE, round=3)
#plot(t)