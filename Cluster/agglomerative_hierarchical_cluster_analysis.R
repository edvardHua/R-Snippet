#
# 凝聚层级聚类分析（Agglomerative Hierarchical Cluster Analysis）
#

# 加载数据，得到聚类后的系统树图（dendrogram）
data(nutrient, package = 'flexclust')  # 加载数据
row.names(nutrient) <- tolower(row.names(nutrient))  # 将食物名称转换成小写
nutrient.scaled <- scale(nutrient)  # 归一化数据
d <- dist(nutrient.scaled)  # 计算属性间距离
fit.average <- hclust(d, method="average")  # 合并 clusters 采用 average-linkage 方法
plot(fit.average, hang=-1, cex=.8, main="Average Linkage Clustering")  # 得到系统树图

# 根据一些标准来决定多少个聚类数目为最佳
library(NbClust)
devAskNewPage(ask = T)  # 得到新图形时需要确认

nc <- NbClust(nutrient.scaled, distance="euclidean",
              min.nc=2, max.nc=15, method="average")

table(nc$Best.n[1,])
barplot(table(nc$Best.n[1,]),
        xlab="Numer of Clusters", ylab="Number of Criteria",
        main="Number of Clusters Chosen by 26 Criteria")  # 画出条形图，选择适合的聚类数目，这里看到我们可以尝试2，3，5，15

# 得到最终的聚类结果
clusters <- cutree(fit.average, k=5)  # 将原来的系统树图缩减为5组
table(clusters)  # 每个聚类下食品的数量

aggregate(nutrient, by=list(cluster=clusters), median)  # 计算每个聚类下食物指标的中位数
plot(fit.average, hang=1, cex=.8,
     main="Average Linkage Clustering\n5 Cluster Solution")  # 系统树图
rect.hclust(fit.average, 5)  # 用红色的矩阵圈出聚类的部分


