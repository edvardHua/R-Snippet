#
# 划分聚类分析
#

# k-means 聚类
# 理想步骤
# 随机的取 k 个点作为 k 个初始质心；
# 计算其他点到这个 k 个质心的距离；
# 如果某个点 p 离第 n 个质心的距离更近，则该点属于 cluster n，并对其打标签，标注 point p.label=n，其中 n<=k；
# 计算同一 cluster 中，也就是相同 label 的点向量的平均值，作为新的质心；
# 迭代至所有质心都不变化为止，即算法结束。

install.packages("rattle")
library(rattle)
data(wine, package="rattle")
head(wine)
df <- scale(wine[-1])

plot(df)
library(NbClust)
set.seed(1234)
devAskNewPage(ask = T)
nc <- NbClust(df, min.nc = 2, max.nc = 15, method = "kmeans") # 确定 K 数目是整个流程的核心
table(nc$Best.n[1, ])

barplot(table(nc$Best.n[1,]),
        xlab = "Number of Clusters", ylab = "Number of Criteria",
        main = "Number of Clusters chosen by 26 Criteria"
        )

fit.km <- kmeans(df, 3, nstart = 25) # 这个是啥？
fit.km$size

# Partitioning Around medoids 围绕中心点的划分
library(cluster)
set.seed(1234)
data(wine, package="rattle")
fit.pam <- pam(wine[-1], k = 3, stand = T)  # stand 表示变量是否在计算前被标准化
fit.pam$medoids  # 输出中心点
clusplot(fit.pam, main = "Bivariate Cluster Plot")  # 画出聚类的方案


