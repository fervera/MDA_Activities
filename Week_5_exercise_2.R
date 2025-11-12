library(dplyr)
library(tidyr)

#Set working directory
getwd()
setwd('C:/MDA/2025/Term_2/Marketing Analytics (DAMO 520-21)/Week_5')

#Load CSV
read.csv('Regression_Analysis.csv')
data <- read.csv('Regression_Analysis.csv')

colnames(data)

#Attaching data to avoid using $
attach(data)

#Plotting data to visualize it
plot(Sales..in..1000s., TV.Ads.Spend..in..1000s.)
plot(Sales..in..1000s., Social.Media.Ads.Spend..in..1000s.)
plot(Sales..in..1000s., Email.Campaign.Spend..in..1000s.)
plot(Sales..in..1000s., Influencer.Marketing.Spend..in..1000s.)

#Check for outliers
boxplot(Sales..in..1000s., main = "Sales (in 1000s)")
boxplot(Social.Media.Ads.Spend..in..1000s., main = "Social Media Ads Spend (in 1000s)")
boxplot(Email.Campaign.Spend..in..1000s., main = "Email Campaign Spend (in 1000s)")
boxplot(Influencer.Marketing.Spend..in..1000s., main = "Influencer Marketing Spend (in 1000s)")

#Use IQR to identify outliers
Q1 <- quantile(Sales..in..1000s., 0.25)
Q3 <- quantile(Sales..in..1000s., 0.75)
IQR_value <- Q3 - Q1

#Define outlier thresholds
lower_bound <- Q1 - 1.5 * IQR_value
upper_bound <- Q3 + 1.5 * IQR_value

#Find row numbers of outliers
outlier <- which(Sales..in..1000s. < lower_bound | Sales..in..1000s. > upper_bound)
outlier

#Remove outliers
data_no_outliers <- data[Sales..in..1000s. >= lower_bound & Sales..in..1000s. <= upper_bound, ]

#Check correlation between predictors
cor_table <- cor(data_no_outliers[, c("Sales..in..1000s.", "TV.Ads.Spend..in..1000s.", 
"Social.Media.Ads.Spend..in..1000s.", "Email.Campaign.Spend..in..1000s.", 
"Influencer.Marketing.Spend..in..1000s.")])

#Fit a linear regression model
attach(data_no_outliers)
model <- lm(Sales..in..1000s. ~ TV.Ads.Spend..in..1000s. + Social.Media.Ads.Spend..in..1000s. + 
Email.Campaign.Spend..in..1000s. + Influencer.Marketing.Spend..in..1000s., data = data_no_outliers)

summary(model)

