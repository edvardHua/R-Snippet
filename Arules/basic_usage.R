#
# 关联规则 arules 包的使用
#

setwd("C:/workspace/RProject/PeriodicPattern")
install.packages("arules")
install.packages("arulesViz")

library(arules)
# 加载杂货店数据
data("Groceries")
summary(Groceries)

# 计算每个购物记录购买物品的数量
basketSize <- size(Groceries)
summary(basketSize)
# 相当于计算每个物品的支持度
itemFre <- itemFrequency(Groceries)
itemFre[1:5]

# 计算每个项目出现的次数
itemCount <- (itemFre/sum(itemFre))*sum(basketSize)

# 出现次数降序
orderedItem <- sort(itemCount, decreasing = T)

# 出现频率降序
orderedFreq <- sort(itemFre, decreasing = T)

# 通过图形查看
itemFrequencyPlot(Groceries, support=0.1)

# 点表示该条对应购买记录是否购买该物品
# 这个矩阵图虽然看上去没有包含很多信息，但是它对于直观地发现异常数据或者比较特殊的Pattern很有效。
# 比如，某些item几乎每个transaction都会买。比如，圣诞节都会买糖果礼物。那么在这幅图上会显示一根竖线，在糖果这一列上。
image(Groceries[1:100])

library(arulesViz)
library(RColorBrewer)

# 设置相关参数来挖掘关联规则
groceryRule <- apriori(Groceries,parameter = list(support = 0.006, confidence = 0.25, minlen = 2))

summary(groceryRule)

# 查看前5条规则
inspect(groceryRule[1:5])

# 根据条件筛选规则
orderedGroceryrules <- sort(groceryRule, by='lift')
inspect(orderedGroceryrules[1:5])

# 搜索与酸奶有关的规则
# %in%是精确匹配
# %pin%是部分匹配，也就是说只要item like '%A%' or item like '%B%'
# %ain%是完全匹配，也就是说itemset has ’A' and itemset has ‘B'
yogurtRule <- subset(groceryRule, items %in% c('yogurt'))
inspect(yogurtRule[1:5])

# 同时可以通过 条件运算符(&, |, !) 添加 support, confidence, lift的过滤条件
fruitRule <- subset(groceryRule, items %pin% c('fruit') & lift > 2)
inspect(fruitRule[1:5])

# 查看其它的quality measure
qualityMeasures <- interestMeasure(
  groceryRule, 
  method=c("coverage","fishersExactTest","conviction", "chiSquared"), 
  transactions=groceries
  )  
summary(qualityMeasures)

# 限定左边规则内容
berriesInLHS <- apriori(Groceries, parameter = list( support = 0.001, confidence = 0.1 ), appearance = list(lhs = c("berries"), default="rhs"))
inspect(berriesInLHS[1:20])

# 进行进一步过滤
berrySub <- subset(berriesInLHS, subset = !(rhs %in% c("root vegetables", "whole milk")))
inspect(berrySub[1:20])

# 进阶部分
# 带有Hierarchy的item，如在Groceries中，商品是有分类的
# includes extended item information 可以看到有level1和level2这两个字段
summary(Groceries)
print(levels(itemInfo(Groceries)[['level1']]))
itemInfo(Groceries)

# 可以将level2的item用level1来表示，使用aggregate这个函数可以做到
highLevelGrocery <- aggregate(Groceries,itemInfo(Groceries)[["level2"]])

inspect(highLevelGrocery[1:5])

# 分别查看在不同的类别情况下的直方分布图
itemFrequencyPlot(Groceries, support = 0.025, cex.names=0.8, xlim = c(0,0.3),  
                  type = "relative", horiz = TRUE, col = "dark red", las = 1,  
                  xlab = paste("Proportion of Market Baskets Containing Item",  
                               "\n(Item Relative Frequency or Support)"))  


itemFrequencyPlot(highLevelGrocery, support = 0.025, cex.names=0.8, xlim = c(0,0.3),  
                  type = "relative", horiz = TRUE, col = "dark red", las = 1,  
                  xlab = paste("Proportion of Market Baskets Containing Item",  
                               "\n(Item Relative Frequency or Support)"))  

# 另外的挖掘到的规则，提高了预定义的support和confidence，为了能够较好的显示下面的图
highLevelGroceryRule <- apriori(highLevelGrocery,parameter = list(support = 0.05, confidence = 0.35, minlen = 2))

# 查看规则在support，confidence和lift上的散点图
plot(highLevelGroceryRule,   
     control=list(jitter=2, col = rev(brewer.pal(9, "Greens")[4:9])),  
     shading = "lift")    
# 查看规则在support，confidence和lift上的分组矩阵
plot(highLevelGroceryRule, method="grouped",     
     control=list(col = rev(brewer.pal(9, "Greens")[4:9])))  


# 以图的方式表示规则
plot(highLevelGroceryRule, measure="confidence", method="graph",   
     control=list(type="items"),   
     shading = "lift")


