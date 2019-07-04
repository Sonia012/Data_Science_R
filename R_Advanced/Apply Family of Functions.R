getwd()
#longer method to set working directory
#setwd("/home/sonia/Desktop/R/R_Advanced/Weather Data")
#shorter method to set wd => . (dot) means "current directory"
setwd("./Desktop/R/R_Advanced/Weather Data")
getwd()

# Read data
    #row.names = 1 => otherwise, R will see the first column with the row titles as a separate column
    #we don't want that, we want the first column as row titles ((row names) and this can be achieved by adding row.names = 1)
Chicago <- read.csv("Chicago-F.csv", row.names=1)
Chicago
Houston <- read.csv("Houston-F.csv", row.names=1)
Houston
New_York <- read.csv("NewYork-F.csv", row.names=1)
New_York
San_Francisco <- read.csv("SanFrancisco-F.csv", row.names=1)
San_Francisco

#these are data frames
is.data.frame(Chicago)

#convert the data frames to matrices
Chicago <- as.matrix(Chicago)
Houston <- as.matrix(Houston)
New_York <- as.matrix(New_York)
San_Francisco <- as.matrix(San_Francisco)

#put all these matrices into a list
Weather <- list(Chicago=Chicago, New_York=New_York, Houston=Houston, San_Francisco=San_Francisco)
Weather

Weather[3]  # returns (the ocmponent in the form of) a list
Weather[[3]]  #returns a component (not in a list)
Weather$Houston   #returns a component (not in a lost), like the [[]]

# using apply()
Chicago
apply(Chicago, 1, mean)
  #check
mean(Chicago["DaysWithPrecip",])
  # Analyse 1 city
Chicago
apply(Chicago, 1, max)
apply(Chicago, 1, min)
  # It doesn't make sense, but just for practice:
apply(Chicago, 2, max)
apply(Chicago, 2, min)
  # Compare
apply(Chicago, 1, mean)
apply(New_York, 1, mean)
apply(Houston, 1, mean)
apply(San_Francisco, 1, mean)
      # >>>>> nearly deliverable 1 but there's a faster way


# Recreating the apply function with loops

Chicago
# FInd the mean of every row
# 1. via loops
    # first create a vector to put the output in and fill it with NULL
output <- NULL  #preparing an empty vector
for (i in 1:nrow(Chicago)){
  output[i] <- mean(Chicago[i,])
}
output
names(output) <- rownames(Chicago)
output

#v 2. via apply function
apply(Chicago, 1, mean)


# Using lapply()
Chicago
t(Chicago) # t = transpose
Weather
  # we want to apply the transpose function to all the elements of the Weather list and put them back into a list
lapply(Weather, t)  # = list(t(Weather$Chicago), t(Weather$New_York), t(Weather$Houston), t(Weather$San_Francisco)) 
myNewList <- lapply(Weather, t)
myNewList
  
  # example2
Chicago
rbind(Chicago, NewRow=1:12)
lapply(Weather, rbind, NewRow=1:12)

  # example 3
rowMeans(Chicago) #identical to: apply(Chicago, 1, mean)
lapply(Weather, rowMeans)
          # >>>>> nearly deliverable 1: even better but will improve further

  # Combining lapply with the [] operator
Weather
Weather[[1]][1,1]
    # gives exactly the same result as:
Weather$Chicago[1,1]
    # if we want to extract the average high of January for all cities:
lapply(Weather, "[", 1,1)
    # if we want the 1st row of each city
lapply(Weather, "[", 1,)
    # create a list which contains all the metrics per city but only for March
lapply(Weather, "[", , 3)

# Add our own functions
lapply(Weather, rowMeans)
lapply(Weather, function(x) x[1,])
lapply(Weather, function(x) x[5,])
lapply(Weather, function(x) x[,12])
lapply(Weather, function(x) round(x["AvgPrecip_inch",]/x["DaysWithPrecip",],2))


lapply(Weather, function(z) round(((z[1,] - z[2,])/z[2,])*100))
            # = Deliverable 2: % fluctuations: will improve



# Using sapply
Weather
  # AvgHigh for July
lapply(Weather, "[", 1,7)
sapply(Weather, "[", 1,7)

  #AvgHigh for the 4th quarter
lapply(Weather, "[", 1,10:12)
sapply(Weather, "[", 1, 10:12)

  # Another example
lapply(Weather, rowMeans)
sapply(Weather, rowMeans)
round(sapply(Weather, rowMeans),2)  #<<<< Deliverable 1

  # Another example
lapply(Weather, function(x) round((x[1,] - x[2,])/x[2,]*100, 2))
sapply(Weather, function(x) round((x[1,] - x[2,])/x[2,]*100, 2))  # Deliverable 2

  # By the way: to show that spally() is a simplified version of lapply()
sapply(Weather, rowMeans, simplify=F) # gives the same result as lapply
lapply(Weather, rowMeans)

# Nesting apply functions
Weather
lapply(Weather, rowMeans)
Chicago
apply(Chicago, 1, max)
  # apply across whole list
lapply(Weather, apply, 1, max)  # Preferred approach, but the below line gives the same result
lapply(Weather, function(x) apply(x, 1, max))

  # Tidy up:
sapply(Weather, apply, 1, max)  #<<< deliverable 3
sapply(Weather, apply, 1, min)  #<<< deliverable 4


# which.max
Chicago
Chicago[1,]
which.max(Chicago[1,])
names(which.max(Chicago[1,]))
  # we need this for all rows and all cities
  # we will have apply() to iterate over rows of the matrix
  # and we will have lapply() or sapply() to iterate over the components of the list
apply(Chicago, 1, function(x) names(which.max(x)))
lapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))
sapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))
