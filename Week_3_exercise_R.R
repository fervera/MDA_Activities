#Dplyr package to manipulate and transform data sets ----

#Key functions:
#filter()
#select()
#mutate()
#summaries()
#arrange()
#group_by()
#rename()
#relocate()
#distinct()

library(dplyr)          #load the library
mtcars <- mtcars

#filter() select rows that meet certain conditions
mtcars_4 <- mtcars %>%    #pipe operator 'shift+cntrl+m'
  filter(cyl==4)          #we filtered the data set based on 4 cyl cars

mtcars_4_30 <- mtcars %>% 
  filter(mpg > 30, cyl == 4)    #We can use more than one condition

#select() Choose columns to keep
mtcars_select <- mtcars %>% 
  select(mpg, hp, wt)

#mutate() Create new variables or transform existing ones
#Create a new column for kpl
mtcars_new <- mtcars %>% 
  mutate(kpl = mpg * 0.425144)

#summaries() Generate summary statistics
mtcars %>% 
  summarise(
    avg_mpg = mean(mpg),
    max_hp = max(hp)              #Collapses data into summary statistics
  )

#arrange() Sort rows based on variable values
mtcars_arranged <- mtcars %>% 
  arrange(hp)      #sort cars by horsepower ascending by default

mtcars_arranged_desc <- mtcars %>% 
  arrange(-hp)      #sort cars by horsepower descending

#group_by()+summaries() Group data for grouped summaries
mtcars_grouped <- mtcars %>% 
  group_by(cyl) %>%                  #Split data into groups for separate analysis
  summarise(avg_mpg = mean(mpg))     #Average mpg by number of cylinders

#rename() function is used to rename certain column
mtcars %>% 
  rename(MilesPerGallon = mpg)

#distinct function it keeps only the unique values (combinations) for the columns you specified
mtcars %>% 
  distinct(cyl,gear)

#relocate function is used to change the position of columns
mtcars %>% 
  relocate(wt, .after = cyl)

mtcars_new %>% 
  relocate(kpl, .before = mpg)

#We can also add all these commands up
mtcars_A <- mtcars %>% 
  filter(mpg > 20, hp < 150) %>% 
  select(mpg, cyl, hp, wt, gear) %>% 
  mutate(weight_kg = wt * 1000 * 0.453592) %>% 
  relocate(weight_kg, .after = wt) %>% 
  arrange(-mpg)

mtcars_A       #Print the cleaned and arranged dataset

#Correlation analysis ----
attach(mtcars)

hist(mpg)
hist(wt)
shapiro.test(mpg)   #W ranges from 0 to 1
                    #A W close to 1 -> your data are approximately normal
                    #A W much lower than 1 -> your data deviate from normality

shapiro.test(wt)

cor(mpg,wt, method = 'pearson')
plot(mpg,wt)
cor.test(mpg,wt, method = 'pearson')

#The pearson correlation assumes:
 #Both variables are continuos
 #Both are approximately normally distributed
 #The relationship between them is linear
 #There are no extreme outliers

#Class activity ----
#load the dataset car_Sales_data into Rstudio, save it and preview first 7 rows
setwd("C:/MDA/2025/Term_2/Marketing Analytics (DAMO 520-21)/Week_3")

car_sales_data <- read.csv('car_sales_data.csv')
head(car_sales_data,7)

#2. Summary statistics - calculate the mean, median, variance and standad deviation of the 
#comission earned column. Assign values to vectors and save it,
#does it have high variability any potential outliers?

attach(car_sales_data)

mean_comission <- mean(car_sales_data$Commission.Earned, na.rm = TRUE)
median_comission <- median(car_sales_data$Commission.Earned, na.rm = TRUE)
variance_comission <- var(Commission.Earned, na.rm = TRUE)
sd_comission <- sd(Commission.Earned, na.rm = TRUE)

mean_comission
median_comission
variance_comission
sd_comission

cv <- sd_comission/ mean_comission

hist(car_sales_data$Commission.Earned)


#3. Filter the dataset for sales where the car make is nissan
car_sales_data_nissan <- car_sales_data %>% 
  filter(Car.Make == 'Nissan')

#4.Add a new column to the dataset called 'Earnings_Per_Unit' b y dividing Commission Earned by Sales
#Price. Display the first 5 rows of the dataset, including this new column
car_sales_data_earnings <- car_sales_data %>% 
  mutate(Earnings.Per.Unit = Commission.Earned / Sale.Price)

head(car_sales_data_earnings, 5)

#5. Correlation Analysis

hist(Sale.Price)
hist(Commission.Earned)

qqnorm(Sale.Price)
qqline(Sale.Price, col='red')


install.packages('nortest')
library('nortest')
ad.test(Sale.Price)
ad.test(Commission.Earned)


corr.test <- cor.test(Sale.Price, Commission.Earned, method='spearman')
corr.test

#6. Identify top car maker by revenue
car_sales_summary <- car_sales_data %>% 
  group_by(Car.Make) %>% 
  summarise(Total_Revenue = sum(Sale.Price, na.rm = TRUE)) %>% 
  arrange(-Total_Revenue)

head(car_sales_summary,5)  

table(car_sales_data$Car.Model)

most_sold_model <- car_sales_data %>% 
  count(Car.Model, sort = TRUE)

head(most_sold_model,1)

