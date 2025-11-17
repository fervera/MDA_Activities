install.packages("arules")
install.packages("arulesViz")

library(arules)
library(arulesViz)

data("Groceries")

summary(Groceries)
inspect(Groceries[1:5])
colnames(Groceries)
itemFrequency(Groceries)    #Baseline probability for each item
head(itemFrequency(Groceries))

itemFrequency(Groceries) ["whole milk"]
itemFrequency(Groceries) [121]

length(Groceries)

groceries_list <- as(Groceries, "list")

groceries_transactions <- data.frame(
  transactionID = seq_along(groceries_list),
  items = sapply(groceries_list, paste, collapse = ", ")
)

getwd()
setwd("c:/MDA/2025/Term_2/Marketing Analytics (DAMO 520-21)/Week_7")

write.csv(groceries_transactions, "groceries_transactions.csv", row.names = FALSE)

rules <- apriori(Groceries, parameter = list(support = 0.01, confidence = 0.5, 
                  minlen = 2, maxlen = 4))

inspect(rules) 

sort_by_lift <- sort(rules, by = "lift")
inspect(sort_by_lift)

itemFrequency(Groceries) ["other vegetables"]

itemFrequency(Groceries) ["whole milk"]

plot(rules, measure = c("support", "confidence"), shading = "lift")
plot(rules, method = "graph", engine = "htmlwidget")

is.significant(rules, transactions)

###########################################################

car_sales_data <- read.csv("car_sales_data.csv")
#Preview 5 rows
head(car_sales_data, 5)

#calculate mean, median and standard deviation for total sales and price
summary(car_sales_data$total_sales)
summary(car_sales_data$price)