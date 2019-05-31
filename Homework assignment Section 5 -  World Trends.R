#import data
data <- read.csv(file.choose())

#check/data validation
head(data)
tail(data)
str(data)
summary(data)

#create a data frame with the vectors we have received
mydf <- data.frame(Code = Country_Code, Life_Exp_1960 = Life_Expectancy_At_Birth_1960, Life_Exp_2013 = Life_Expectancy_At_Birth_2013)
head(mydf)
head(data)
summary(mydf)

#split the imported data into 1960 data and 2013 data, 1 data frame per year
data1960 <- data[data$Year == 1960,]
head(data1960)
tail(data1960)
nrow(data1960)
data2013 <- data[data$Year == 2013,]
head(data2013)
tail(data2013)
nrow(data2013)

#merge the data frame of vectors with the imported data frames per year
merged1960 <- merge(data1960, mydf, by.x = "Country.Code", by.y = "Code")
merged1960
    #delete the column related to the year 2013
merged1960$Life_Exp_2013 <- NULL
merged1960$Year <- NULL
merged1960

merged2013 <- merge(data2013, mydf, by.x = "Country.Code", by.y = "Code")
merged2013
    #delete the column related to the year 1960
merged2013$Life_Exp_1960 <- NULL
merged2013$Year <- NULL
merged2013

#check structure
str(merged1960)
str(merged2013)

#visualization 1960
colnames(merged1960)
qplot(data = merged1960, x = Fertility.Rate, y = Life_Exp_1960,
      colour = Region, size = I(3), alpha = I(0.6),
      main = "1960 Life Expectancy vs. Fertility Rate per Region")

#visualization 2013
qplot(data = merged2013, x = Fertility.Rate, y = Life_Exp_2013,
      colour = Region, size = I(3), alpha = I(0.6),
      main = "2013 Life Expectancy vs. Fertility Rate per Region")
