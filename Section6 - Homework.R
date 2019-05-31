getwd()
movies <- read.csv("Section6-Homework-Data.csv")

summary(movies)
str(movies)
colnames(movies)
head(movies)

studioFilter <- (movies$Studio == "Buena Vista Studios")| (movies$Studio == "Fox") | (movies$Studio == "Paramount Pictures") |
  (movies$Studio == "Sony") | (movies$Studio == "Universal")| (movies$Studio == "WB")

genreFilter <- movies$Genre == "action" | movies$Genre == "adventure" |
  movies$Genre == "animation" | movies$Genre == "comedy" | movies$Genre == "drama"

filteredMovies <- movies[studioFilter & genreFilter, ]

summary(filteredMovies)

#install ggplot2
#install.packages("ggplot2)
library(ggplot2)
install.packages("extrafont")
library(extrafont)

a <- ggplot(data = filteredMovies, aes(x = Genre, y = Gross...US))

a
q <- a + geom_jitter(aes(colour = Studio, size = Budget...mill.)) + geom_boxplot(alpha = 0.6, outlier.color = NA) +
      ylab("Gross % US") +
      ggtitle("Domestic Gross % by Genre") +
      theme(axis.title.x = element_text(size = 30, colour = "DarkBlue"),
            axis.title.y = element_text(size = 30, colour = "DarkBlue"),
            axis.text = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 40),
            legend.title = element_text(size = 20),
            legend.text = element_text(size = 20),
            text = element_text(family="Comic Sans MS"))

q

#change the title of the legend
q$label$size <- "Budget $M"
q

