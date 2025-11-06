install.packages('cluster')
install.packages('factoextra')

library(tidyverse)
library(cluster)
library(factoextra)

setwd('C:/MDA/2025/Term_2/Marketing Analytics (DAMO 520-21)/Week_4')
data <- read.csv('Mall_Customers.csv')

head(data)
str(data)
glimpse(data)
summary(data)
colSums(is.na(data))   #To identify if there are any missing values
colnames(data)

#K-means doesn't use categorical values, only numerical values.

data_new <- data[,3:5]   #[] are for sub-setting, data[row,column]. You can relocate the columns before.
data_new <- data[,c(1,3:5)]   #Another way to sub-set data.

#Scale the data to ensure that all variables contribute equally to distance calculations
#Preventing features with larger ranges from dominating analysis.
data_scaled <- scale(data_new)

#Find a balance between:Model simplicity (fewer clusters) & Clustering quality
fviz_nbclust(data_scaled, kmeans, method = 'wss')   #Elbow method - cluster compactness

#Tell R to use the same random starting point every time for reproducibility
set.seed(123)

#Apply k-means clustering
kmeans(data_scaled, centers = 4, nstart = 25)
kmeans_result <- kmeans(data_scaled, centers = 4, nstart = 25)

#Add cluster assignments to original data
data_clustered <- data %>% 
  mutate(Cluster = as.factor(kmeans_result$cluster))

write.csv(data_clustered, 'data_clustered.csv', row.names = T)

#Visualize the clusters method 1
fviz_cluster(kmeans_result, data = data_scaled, geom = 'point', ellipse.type = 'convex')
?fviz_cluster

#Visualize the clusters method 2
ggplot(data_clustered, aes(x = Annual.Income..k.., y = Spending.Score..1.100., color = Cluster)) +
  geom_point(size=3) +
  labs(title = 'Mall Customers Segmentation',
       x = 'Annual Income (k$)',
       y = 'Spending Score (1-100)') + 
  theme_minimal()

#Visualize the plot in 2D by creating new axes
pca_result <- prcomp(data_scaled)
data_pca <- as.data.frame(pca_result$x[,1:2])
data_pca$Cluster <- data_clustered$Cluster

#Plot the 2D data set
ggplot(data_pca, aes(PC1, PC2, color = Cluster)) + 
  geom_point(size = 3) +
  labs(title = 'K-means Clusters Visualized with PCA') +
  theme_minimal()

colnames(data)

#Getting insights from Clustering
cluster_summary <- data_clustered %>% 
  group_by(Cluster) %>% 
  summarise(
    avg_age = mean(Age),
    avg_income = mean(Annual.Income..k..),
    avg_spending = mean(Spending.Score..1.100.),
    customer_count = n()
  )

