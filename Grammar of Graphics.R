#----------1. Data (layer)
getwd()
setwd("/home/sonia/Desktop/R")
movies <- read.csv("P2-Movie-Ratings.csv")
str(movies)
summary(movies)
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating",
                      "AudienceRating", "BudgetMillions",
                      "Year")
head(movies)
tail(movies)
str(movies)
summary(movies)

factor(movies$Year)
movies$Year <- factor(movies$Year)
summary(movies)
str(movies)

#----------------2. Aesthetics
library(ggplot2)

ggplot(data = movies, aes(x=CriticRating, y=AudienceRating))

#the above ggplot doesn't show any data, so we need to add geometry (3rd layer)
ggplot(data = movies, aes(x=CriticRating, y=AudienceRating)) + 
  geom_point()

#add colour
ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, colour=Genre)) + 
  geom_point()

#add size
ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, colour=Genre,
                          size=BudgetMillions)) + 
  geom_point()


#------------Plotting with layers
p <- ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, colour=Genre,
                          size=BudgetMillions))


#point
p + geom_point()

#lines
p + geom_line()

#multiple layers
p + geom_point() + geom_line()
p + geom_line() + geom_point()
p + geom_boxplot() 


#---------------Overriding Aesthetics

q <- ggplot(data = movies, aes(x=CriticRating, y=AudienceRating,
                               colour=Genre, size=BudgetMillions))

#add geom layer
q + geom_point()

#overriding aes
#ex1
q +geom_point(aes(size = CriticRating))
#ex2
q + geom_point(aes(colour = BudgetMillions))
#ex3
q + geom_point(aes(x = BudgetMillions)) + xlab("BudgetMillions $$$")
#ex4
q + geom_line() + geom_point()
    #reduce line sizes
q + geom_line(size=1) + geom_point()



#--------------------------Mapping vs Setting

r <- ggplot(data = movies, aes(x=CriticRating, y = AudienceRating))
r + geom_point()
  #1. add colour by mapping
r + geom_point(aes(colour=Genre))
  #2. add colour by setting
r + geom_point(colour="DarkGreen")


r + geom_point(aes(size=BudgetMillions))
r + geom_point(size = 10)
#€rror: you should not use aes when setting!!!
r + geom_point(aes(size=10))

#------------------Histograms and density charts

s <- ggplot(data = movies, aes(x=BudgetMillions))
s + geom_histogram(binwidth=10)

  #add colour
s + geom_histogram(binwidth=10, aes(fill=Genre))
  #add a border
s + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black")

  #density charts
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position="stack")

#------------Starting layer tips

t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth=10, fill="White", colour="Blue")

    #Another way to achieve the same thing
t <- ggplot(data=movies)
t + geom_histogram(binwidth=10,
                   aes(x=AudienceRating),
                   fill="White", colour="Blue")


t + geom_histogram(binwidth=10,
                   aes(x=CriticRating),
                   fill="White", colour="Blue")

    #sometimes you might want to create a ggplot variable without specifying the dataset
    #because you have different datasets that you want to plot, for example
u <- ggplot()  #and set the dataset in the layers you add later



#-----------------------Statistical Transformation

v <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             colour=Genre))
v + geom_smooth(fill=NA)

#boxplots
w <- ggplot(data=movies, aes(x=Genre, y=AudienceRating,
                             colour=Genre))

w + geom_boxplot()
w + geom_boxplot(size=1.2)
w + geom_boxplot(size=1.2) + geom_point()
  #tip/hack
w + geom_boxplot(size=1.2) + geom_jitter()
  #another way
w + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)



x <- ggplot(data=movies, aes(x=Genre, y=CriticRating, colour=Genre))

x + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)


#-------------------------Using facets

z <- ggplot(data=movies, aes(x=BudgetMillions))
z + geom_histogram(binwidth=10, aes(fill=Genre))
  #factes
z + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black") +
  facet_grid(Genre~., scales="free")
  
  #scatterplots
b <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             colour=Genre))
b + geom_point(size=3)

    #facets
b + geom_point(size=3) +
  facet_grid(Genre~.)

b + geom_point(size=3) +
  facet_grid(.~Year)

b + geom_point(size=3) +
  facet_grid(Genre~Year)

b + geom_point(size=3) + 
  geom_smooth() +
  facet_grid(Genre~Year)

b + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year)
  #>>>>>>1 => we will improve this later (see below, line 215)

#-----------------Coordinates

  #limits
  #zoom

m <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             size=BudgetMillions,
                             colour=Genre))

m + geom_point()

m + geom_point() +
  xlim(50,100) + 
  ylim(50,100)


  #won't always work well
n <- ggplot(data=movies, aes(x=BudgetMillions))
n + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")

n + geom_histogram(binwidth = 10, aes(fill= Genre), colour="Black") +
  ylim(0, 50)  #=> it cut off the data above 50, that's not what we want, we want to zoom into the data, not cut it

  #instead - zoom:
n + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black") +
  coord_cartesian(ylim=c(0,50))

  #improve n°1
b + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year) +
  coord_cartesian(ylim=c(0,100))

#--------------Theme

o <- ggplot(data = movies, aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black")

  #add axes label formatting
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour="DarkGreen", size = 30),
        axis.title.y = element_text(colour="Red", size=30))

  #add tick mark formatting
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour="DarkGreen", size = 30),
        axis.title.y = element_text(colour="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20))

?theme

  #legend formatting
h +
  xlab("Money axis") +
  ylab("Number of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(colour="DarkGreen", size = 30),
        axis.title.y = element_text(colour="Red", size = 30),
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        legend.title = element_text(size = 30),
        legend.text = element_text(size = 20),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        plot.title = element_text(colour="DarkBlue", 
                                  size = 40,
                                  family = "Courier",
                                  hjust = 0.5))


