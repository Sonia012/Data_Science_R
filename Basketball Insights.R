
#Salary
myplot(Salary)
myplot(Salary / Games)

#In-game metrics
myplot(MinutesPlayed)
myplot(Points)

#In-game metrics normalized (exclude effect of injuries)
myplot(FieldGoals/Games)
myplot(FieldGoals/FieldGoalAttempts)
myplot(FieldGoalAttempts / Games)


#interesting observations
myplot(MinutesPlayed / Games)
myplot(Games)

#Rime is valuable, since they are less minutes per gam on field
myplot(FieldGoals/MinutesPlayed)

#Player Style
myplot(Points/FieldGoals)
