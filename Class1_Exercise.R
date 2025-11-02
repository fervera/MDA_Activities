# BASIC CONCEPTS TO KNOW FROM THE START ----

# Assigment: use <- to assign values
x <- 10
y <- c(2,3)
a <- c(2,3)
c <- 10; d <-6 #You can do this as well in the console

#Different types of vectors
typeof(x)
typeof(a)

y <- 3 #Double (numeric)
typeof(y)
y <- as.integer(y)
typeof(y)

#Remove the variable or data frame from the Global environment
rm(x)       #We can do this in the console

#Lets create a larger vector
ages <- c(25,35,24,25,34,33,34,26,27,20,20,23,22,28)
typeof(ages)
#Built in functions for descriptive statistics
length(ages)
mean(ages)
sum(ages)
min(ages)
max(ages)
sort(ages)
summary(ages)
table(ages)
table(ages>21)
ages[5]
ages[5:8]

#To save these values we need to create vectors to the global environment
ages_sorted <- sort(ages)
minimun_ages <- min(ages)

names <- c('jose','juan','pedro','pepe','daniel','oscar','raul','ernesto','carlos','victor','henry','abdul','aldo','javier')

#More information on the function itsefl
?mean

#Install and load packages: Collections of R functions and data sets
install.packages("tidyverse")   #Once
library(tidyverse)              #Every session

#CALCULATIONS WITH R ----
2+2
2*3
2/2
5-3
2^2
log(10)
log(10,2)
mean(c(1,2,3,4))
sd(c(1,2,3,4))

#Calculations with vectors
z <-3
w <- 4

total <- z+w

#CREATING AND SAVING A DATA FRAME WITH R ----
scores <- c(85,90,78,92,88,76,81,95,89,84,79,91,87,93)
typeof(names)

table(scores)
table(scores >= 85)
max(scores)
min(scores)
mean(scores)

#Before we create a data frame we need to check the variables length
length(names) == length(ages)
length(ages) == length(scores)

#Create a data frame with these two variables
data.frame(names, ages, scores)
student_scores <- data.frame(names, ages, scores)


#If I want to crate my data frame with different variables names
student_scores <- data.frame(Name=names, Age=ages, Score=scores)

#READ AND WRITE A DATASET ----
#First step set the working directory to the right path
getwd()           #Check the current working directory

#1. Manually 
setwd("C:/MDA/2025/Term_2/Marketing Analytics (DAMO 520-21)/Week_2")

#Or using the 'Session' tab in toolbar
#Go to the session menu -> Set working directory -> Choose directory

#Or using files tab in the bottom left corner
#Click on the folder icon in the files pane and select 'Set as working directory'

#Now to save a data frame to your computer
write.csv(student_scores, file='student_scores.csv', row.names = F)
?write_csv
?row.names

#To read the data set use 'read.csv' function
read.csv('student_scores.csv')
student_data <- read.csv('student_scores.csv')
head(student_data)

#Explore the dataset
str(student_data)
dim(student_data)
glimpse(student_data)
colnames(student_data)
summary(student_data)

#Descriptive statistics
sd(student_data$Age)
var(student_data$Age)
sapply(student_data,sd)
sapply(student_data,var)
sapply(mtcars, sd)

mtcars <- mtcars

#PERFORMING ANALYSIS AND VISUALIZATION USING THE DATASET ----
head(student_data)

plot(ages, scores) #Plotting two variables

#Create histogram of frequency
library(ggplot)
ggplot(student_scores, aes(x= scores))+
  geom_histogram(binwidth = 5, fill = 'skyblue', color = 'black') +
  labs(title = 'Histogram of student scores',
       x = 'Scores',
       y = 'Count of students') +
  theme_minimal()

#Notes:
#binwidth = 5 makes each bar represents 5 pts of grade.
#fill controls the bar color, and color is the border.
#theme_minimal gives a clean background.

colors()
