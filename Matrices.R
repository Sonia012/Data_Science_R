

#matrix
?matrix()

my.data <- 1:20
my.data

A <- matrix(my.data, 4, 5)
A
A[4,]
A[2,3]


B <- matrix(my.data, 4, 5, byrow = T)
B
B[2,5]

v1 <- seq(6, 13)
v1
v2 <- rep(v1, 2)
v2

E <- matrix(v1, 2, 4)
E

G <- matrix(v2, 4, 4, byrow=T)
G

#rbind
r1 <- c("I", "am", "happy")
r2 <- c("What", "a", "day")
r3 <- c(1, 2, 3)
C <- rbind(r1, r2, r3)
C

v3 <- rep( 5, 3)
v3
v4 <- rep(v3, 5)
v4
v5 <- 11:25
v5

H <- rbind(v5, v4)
H


#cbind
c1 <- 1:5
c2 <- -1:-5
D <- cbind(c1, c2)
D
c3 <- c(31, 32, 33, 34, 35)
c4 <- c(41, 42, 43, 44, 45)
I <- cbind(c3, c4)
I[1,c4]
I[1,2]
I[,2]
I[4,]
I[2,"c3"]
