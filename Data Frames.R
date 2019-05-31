#Method 1: Select the file manually
stats <- read.csv(file.choose())
stats


#Method 2: Set working directory and read data

getwd()
setwd("/home/sonia/Desktop/R")
rm(stats)
stats <- read.csv("P2-Demographic-Data.csv")


#-----------------Eploring data

stats
nrow(stats)
ncol(stats)
head(stats, n=5)
tail(stats)
str(stats)  #structure of your data
summary(stats)


#-----------------Usinng the $ sign

stats
head(stats)
stats[3,3]
stats[3, "Birth.rate"]
stats$Internet.users
stats$Internet.users[2]
#the above line gives the same result as the line below
stats[2 ,"Internet.users"]

levels(stats$Income.Group)


#-----------------Basic operations with a data frame
stats[1:10, ]
stats[3:9,]
stats[c(4,100),]
#Remember how the [] work:
is.data.frame(stats[1,]) #no need for drop=F if you're selecting rows
is.data.frame(stats[,1])  #If you're selecting a column, R will transform it into a vector => you need to add drop=F if you want it to be a data frame
is.data.frame(stats[,1,drop=F])
#multiply columns
head(stats)
stats$Birth.rate * stats$Internet.users
stats$Internet.users + stats$Birth.rate

#add a column
head(stats)
stats$MyCalc <- stats$Birth.rate * stats$Internet.users

#test of knowledge
stats$xyz <- 1:5 #will recycle the vector in the column until it reaches 195 values
stats$xyzz <- 1:4 #will give an error because it cannot recycle a vector of 4 values into 195 values (195/4 is not an integer)
stats

#remove a column
head(stats)
stats$MyCalc <- NULL
stats$xyz <- NULL


#---------------Filtering data frames
head(stats)
filter <- stats$Internet.users < 2
stats[filter,]

stats[stats$Birth.rate > 40,]
stats[stats$Birth.rate > 40 & stats$Internet.users > 2,]
stats[stats$Income.Group == "High income",]
levels(stats$Income.Group)
stats[stats$Country.Name == "Malta",]

#--------------Introduction to Qplot()

library(ggplot2)
?qplot()
qplot(data=stats, x=Internet.users)
qplot(data=stats, x=Income.Group, y=Birth.rate)
qplot(data=stats, x=Income.Group, y=Birth.rate, size=I(3),
      colour=I("blue"))
qplot(data=stats, x=Income.Group, y=Birth.rate, geom="boxplot")

#--------------Visualizing what we need
qplot(data=stats, x=Internet.users, y=Birth.rate)
qplot(data=stats, x=Internet.users, y=Birth.rate,
      size=I(4))
qplot(data=stats, x=Internet.users, y=Birth.rate,
      size=I(4), colour=I("red"))
qplot(data=stats, x=Internet.users, y=Birth.rate,
      colour=Income.Group, size=I(5))

#--------------Creating data frames
mydf <- data.frame(Countries_2012_Dataset, Codes_2012_Dataset, Regions_2012_Dataset)
head(mydf)
Countries_2012_Dataset
Codes_2012_Dataset
Regions_2012_Dataset
mydf
#colnames(mydf) <- c("Country", "Code", "Region")
rm(mydf)
mydf <- data.frame(Country=Countries_2012_Dataset, Code= Codes_2012_Dataset, Regions=Regions_2012_Dataset)
head(mydf)
tail(mydf)
summary(mydf)

#--------------Merging data frames
head(mydf)
tail(mydf)
head(stats)

merged <- merge(stats, mydf, by.x = "Country.Code", by.y = "Code")
head(merged)
merged$Country <- NULL
head(merged)
str(merged)
tail(merged)

#--------------Visualizing with new split
qplot(data = merged, x = Internet.users, y = Birth.rate,
      colour = Regions, size = I(5))

#1. Shapes
qplot(data = merged, x = Internet.users, y = Birth.rate,
      colour = Regions, size = I(5), shape = I(23))

#2. Transparency  
qplot(data = merged, x = Internet.users, y = Birth.rate,
      colour = Regions, size = I(5), shape = I(19),
      alpha = I(0.6))

#3. Title

qplot(data = merged, x = Internet.users, y = Birth.rate,
      colour = Regions, size = I(5), shape = I(19),
      alpha = I(0.6), main = "Birth rate vs. Internet users")
