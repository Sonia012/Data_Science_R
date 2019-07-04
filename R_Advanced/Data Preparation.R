# check and set working directory
getwd()
setwd("/home/sonia/Desktop/R/R_Advanced")  
getwd()

#omport the data (csv file) and check the data
#Basic: fin <- read.csv("P3-Future-500-The-Dataset.csv")
# na.strings function will replace all the values in the vector (c()) with <NA>'s
fin <- read.csv("P3-Future-500-The-Dataset.csv", na.strings = c(""))
fin
head(fin, 20)
tail(fin, 10)
str(fin)
summary(fin)

#Changing from non-)factor to factor:
fin$ID <- factor(fin$ID)
summary(fin)
str(fin)

fin$Inception <- factor(fin$Inception)
summary(fin)
str(fin)


#Converting into Numerics: for characters:
a <- c("12", "13", "14", "12", "12")
a
typeof(a)
b <- as.numeric(a)
b
typeof(b)

#Converting into Numerics: for factors:
#Factor Variable Trap (FVT) if you convert a factor into a non-factor variable

z <- factor(c("12", "13", "14", "12", "12"))
z
typeof(z) #it's not the values inside z that are viewed as integers but it's the factorization that's viewed as integer! 
    #R assigns numerical values to each category => when we look at vector z, WE see 12, 13, 14, 12, 12, when R looks at it, 
    #it sees 1 2 3 1 1
y <- as.numeric(z)
y
typeof(y)
    #although y is a type "double", the values (1 2 3 1 1) are not the values we expected => Factor Variable Trap!
    #How should we convert a factor variable, then??
    
    #Correct way = first convert z into a character and then convert into a number
x <- as.numeric(as.character(z))
x
typeof(x)

# to convert factors to numbers, the format needs to be right. If there are commas, dollar signs, words, percentage signs,... they need to be replaced first!
# sub() and gsub()
fin$Expenses <- gsub(" Dollars", "", fin$Expenses)
fin$Expenses <- gsub(",", "", fin$Expenses)
head(fin)
str(fin)

fin$Revenue <- gsub("\\$", "", fin$Revenue)
fin$Revenue <- gsub(",", "", fin$Revenue)
str(fin)

fin$Growth <- gsub("%","",fin$Growth)
head(fin)

fin$Expenses <- as.numeric(fin$Expenses)
fin$Revenue <- as.numeric(fin$Revenue)
fin$Growth <- as.numeric(fin$Growth)

str(fin)
summary(fin)

# What is an NA?
?NA


#Locating missing data
head(fin,24)

  #pull out the rows with missing data
fin[!complete.cases(fin),]

#Filtering: using which() for non-missing data
head(fin)
    #let's say we want to single out the row(s) with a revenue of 9746272
fin[fin$Revenue == 9746272,]
    #If there are NA's in the Revenue column, R will replace the whole row with NA and show it in your filter, as R doesn't know what to do with it
    #How to solve this?
    #Use which()
which(fin$Revenue == 9746272)
    #which() goes through the vector (fin$Revenue == 9746272) and takes only the "TRUE" rows => not the False and not the NA
    #it returns the number (ID) of the row that you need = row number 3
fin[which(fin$Revenue == 9746272),]

head(fin)
which(fin$Employees == 45)
fin[which(fin$Employees == 45),]

#Filtering: using is.na() for missing data
head(fin, 24)

is.na(fin$Expenses)
fin[is.na(fin$Expenses),]

is.na(fin$State)
fin[is.na(fin$State),]

#Removing records with missing data

fin_backup <- fin  #create a backup of your data 
#fin <- fin_backup   #to restore the data, uncomment this code

fin[!complete.cases(fin),] #will give you all the rows with missing values
fin[is.na(fin$Industry),] #will give you the rows with NA's in the Industry column
fin[!is.na(fin$Industry),] #will give you all the rows that don't have NA's in the Industry column

fin <- fin[!is.na(fin$Industry),] #will replace the data (fin) with the data without the rows that have NA in the Industry column => there are no more NA's in the Industry column
fin[!complete.cases(fin),] #there are no more NA's in the Industry column

#Resetting the data frame index (when you delete rows, the row numbers/indices don't change. If you want the row numbers to change, you need to reset the index)

#1 of thhe solutions = rownames(fin) <- 1:nrow(fin)
tail(fin)
#better solution:
rownames(fin) <- NULL #=tell R to remove the rownmaes and by default it will reset the rownames by giving the rows sequential numbers
tail(fin)

fin[is.na(fin$State),]
fin[is.na(fin$State) & fin$City == "New York",]
fin[is.na(fin$State) & fin$City == "New York", "State"] <- "NY"  #replace NA by "NY" in the column "State" for all the NA's that have city name "New York"

fin[is.na(fin$State) & fin$City == "San Francisco",]
fin[is.na(fin$State) & fin$City == "San Francisco", "State"] <- "CA"


    #check
fin[c(11, 377, 82, 265),]

fin[!complete.cases(fin),]


#Replacing missing data: Median imputation method
fin[fin$Industry == "Retail",]

med_empl_retail <- median(fin[fin$Industry == "Retail","Employees"], na.rm = TRUE) #remove the NA so they don't screw up your median
med_empl_retail

fin[is.na(fin$Employees) & fin$Industry == "Retail",]
fin[is.na(fin$Employees) & fin$Industry == "Retail", "Employees"] <- med_empl_retail


med_empl_FinServ <- median(fin[fin$Industry == "Financial Services", "Employees"], na.rm = TRUE)
med_empl_FinServ

fin[is.na(fin$Employees) & fin$Industry == "Financial Services",]
fin[is.na(fin$Employees) & fin$Industry == "Financial Services", "Employees"] <- med_empl_FinServ

#check
fin[c(3, 330),]

fin[!complete.cases(fin),]

med_growth_construction <- median(fin[fin$Industry == "Construction", "Growth"], na.rm = TRUE)
med_growth_construction

fin[is.na(fin$Growth) & fin$Industry == "Construction",]
fin[is.na(fin$Growth) & fin$Industry == "Construction", "Growth"] <- med_growth_construction
fin[8,]


fin[!complete.cases(fin),]

med_rev_construction <- median(fin[fin$Industry == "Construction", "Revenue"], na.rm = TRUE)
med_rev_construction

fin[is.na(fin$Revenue) & fin$Industry == "Construction",]
fin[is.na(fin$Revenue) & fin$Industry == "Construction", "Revenue"] <- med_rev_construction
fin[c(8, 42),]

fin[!complete.cases(fin),]

med_exp_construction <- median(fin[fin$Industry == "Construction", "Expenses"], na.rm = TRUE)
med_exp_construction
fin[is.na(fin$Expenses) & fin$Industry == "Construction",]
fin[is.na(fin$Expenses) & fin$Industry == "Construction", "Expenses"] <- med_exp_construction
fin[c(8,42),]

fin[!complete.cases(fin),]

#Replacing missing data: deriving values
#Revenue - Expenses = Profit
#Expenses = Revenue - Profit

fin[is.na(fin$Profit),]
fin[is.na(fin$Profit), "Profit"] <- fin[is.na(fin$Profit), "Revenue"] - fin[is.na(fin$Profit), "Expenses"]
fin[c(8, 42),]

fin[is.na(fin$Expenses),]
fin[is.na(fin$Expenses), "Expenses"] <- fin[is.na(fin$Expenses), "Revenue"] - fin[is.na(fin$Expenses), "Profit"]
fin[15,]

fin[!complete.cases(fin),]


#Visualization:
library(ggplot2)

#A scatterplot classified by industry showing revenue, expenses, profit

p <- ggplot(data=fin)
p
p + geom_point(aes(x=Revenue, y=Expenses, colour=Industry, size=Profit))
 
#A scatterplot that includes industry trends for the expenses-revenue relationship
d <- ggplot(data=fin, aes(x=Revenue, y=Expenses, colour=Industry))
d + geom_point() + geom_smooth(fill=NA, size=1.2)


#Boxplots showing growth by industry
f <- ggplot(data=fin, aes(x=Industry, y=Growth, colour=Industry))
f + geom_jitter() + geom_boxplot(size=1, alpha=0.5,outlier.colour=NA)

