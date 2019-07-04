#Deliverable: A list with the following components:
#   Character: Machine name
#   Vector:(min, mean, max) utilisation for the month (excluding unknown hours)
#   Logical:Has utilisation ever fallen below 90%? TRUE / FALSE
#   Vector:All hours where utilisation is unknown (NA’s)
#   Dataframe:For this machine
#   Plot:For all machines


getwd()
setwd("/home/sonia/Desktop/R/R_Advanced")
getwd()

util <- read.csv("P3-Machine-Utilization.csv")
head(util, 12)
str(util)
summary(util)

util$Utilization <- 1 - util$Percent.Idle
head(util, 12)

#Handling date-times in R
?POSIXct
util$PosixTime <- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")  #Capital Y because it's 4 digits

head(util, 12)
summary(util)

#TIP: how to rearrange columns in a data frame?
util$Timestamp <- NULL
head(util, 12)
util <- util[,c(4, 1, 2, 3)]
head(util, 12)


#What is a list? Like a vector but it can contain any type of element and a mix of different types
    #we only need machine RL1
RL1 <- util[util$Machine == "RL1",]
summary(RL1)
    #if you want to get rid of the legacy memory (other machines are still showing in the summary, 
    #even if with a zero number), you need to re-run the factor
RL1$Machine <- factor(RL1$Machine)
summary(RL1)
str(RL1)

#Construct list:
#   Character: Machine name
#   Vector:(min, mean, max) utilisation for the month (excluding unknown hours)
#   Logical:Has utilisation ever fallen below 90%? TRUE / FALSE

util_stats_rl1 <- c(min(RL1$Utilization, na.rm=TRUE),
                    mean(RL1$Utilization, na.rm=TRUE),
                    max(RL1$Utilization, na.rm=TRUE))
util_stats_rl1
    
    #check if utilisation has ever fallen below 90%
RL1$Utilization < 0.9   #vector that will give you TRUE or FALSE for each row
which(RL1$Utilization < 0.9)  #will give you the row numbers of the rows with utilisation % < 90%
length(which(RL1$Utilization < 0.9)) > 0 #we check the length of this vector to see if there is at least 1 value (we don't care about which ones)
util_under_90 <- length(which(RL1$Utilization < 0.9)) > 0
util_under_90

    #create list with the function list()
list_rl1 <- list("RL1", util_stats_rl1, util_under_90)
list_rl1  #double brackets indexation is the indexation  of the list, the single barckets are the indexations that come from the individual vectors

    #naming components of a list
names(list_rl1)
names(list_rl1) <- c("Machine", "Stats", "Low threshold")
list_rl1
        #Another way: like with data frames
rm(list_rl1)
list_rl1 <- list(Machine="RL1", Stats=util_stats_rl1, LowThreshold = util_under_90)
list_rl1


#Extracting components of a list
  # 3 ways to do that
  # [] will always return a list
  # [[]] will always return the actual object within the component
  # $ the same as the [[]] but prettier
list_rl1
list_rl1[1]
list_rl1[[1]]
list_rl1$Machine

list_rl1[2]
typeof(list_rl1[2])
list_rl1[[2]]
typeof(list_rl1[[2]])
list_rl1$Stats
typeof(list_rl1$Stats)

list_rl1
list_rl1[3]
list_rl1[[3]]
list_rl1$LowThreshold

    # How would you access the 3rd element of the vactor (=max utilisation)?
list_rl1$Stats[3]
      # or
list_rl1[[2]][3]


# Adding and deleting list components
list_rl1
list_rl1[4] <- "New Information"
list_rl1
    # Another way to add a component is via the $
    # We will add:
    #   Vector:All hours where utilisation is unknown (NA’s)
list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]
list_rl1

# Remove a component
list_rl1[4] <- NULL
list_rl1  
list_rl1[4]  # the 4th component ("New Information") was deleted and the component numbers of the components after the deleted
# component have changed (unlike data frames). So, the 5th component becomes the 4th...

# Add another component
  # Data frame for this machine
list_rl1$Data <- RL1
list_rl1
summary(list_rl1)
str(list_rl1)


# Subsetting a list
list_rl1[[4]][1]
list_rl1$UnknownHours[1]
list_rl1[1:3]
list_rl1[c(1,4)]
sublist_rl1 <- list_rl1[c("Machine", "Stats")]
sublist_rl1
sublist_rl1[[2]][2]

  # Double square barckets are not for subsetting
    # list_rl1[[1:3]] => ERROR


# Building a time series plot
library(ggplot2)

p <- ggplot(data=util)

p + geom_line(aes(x=PosixTime, y= Utilization, colour=Machine), size=1.2) +
  facet_grid(Machine~.)  +
  geom_hline(yintercept=0.9, colour="Gray", size=1.2, linetype=3)

my_plot <- p + geom_line(aes(x=PosixTime, y= Utilization, colour=Machine), size=1.2) +
  facet_grid(Machine~.)  +
  geom_hline(yintercept=0.9, colour="Gray", size=1.2, linetype=3)

list_rl1$Plot <- my_plot
list_rl1
summary(list_rl1)
str(list_rl1)
