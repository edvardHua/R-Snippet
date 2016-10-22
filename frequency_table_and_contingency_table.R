# 
# 频数表和列联表
#

library(vcd)
head(Arthritis)

tmp <- Arthritis
str(tmp)

# 一维列联表
# 根据 Improved 列生成简单的频数统计表
mytable <- with(Arthritis, table(Improved))
attributes(mytable)

# 将频数转化为比例值
prop.table(mytable)
# 转换为百分比
prop.table(mytable)*100

# 二维列联表 表示不同的医疗方式下不同改善的人员的频数
# Treatment 表示交叉分类  频数向量
mytable <- xtabs(~Treatment+Improved, data=Arthritis)

# 边际频数 和 比例
# 边际频数，接受 Placebo 和接受 Treated 两种治疗的总人数
margin.table(mytable, 1)
# 边际频数，所有接受治疗的人中，效果为分别为none,some,marked的人数统计
margin.table(mytable, 2)
# 与上面两条语句不同的是，这里是占比，也即比例
prop.table(mytable, 1)
prop.table(mytable, 2)

# 每个人群占所有人数的比例
prop.table(mytable)

# 添加边际的和，也即添加多一列，计算接受不同治疗方法的总人数
addmargins(mytable)
addmargins(prop.table(mytable))
addmargins(prop.table(mytable, 1), 2)
addmargins(prop.table(mytable, 2), 1)

# 在table()函数默认忽略缺失值（NA）。要在频数统计中将 NA 视为一个有效的类别，请设置参数useNA="ifany"


# 使用 CrossTable 生成二维列联表
install.packages(gmodels)
library(gmodels)
CrossTable(Arthritis$Treatment, Arthritis$Improved)

# 多维列联表
mytable <- xtabs(~Treatment+Sex+Improved, data=Arthritis)
# 上条语句显示效果不够直观，可以使用 ftable 来得到直观的多维列联表
ftable(mytable)
# 不同边际的频数
margin.table(mytable, 1)
margin.table(mytable, 2)
margin.table(mytable, 3)
# 治疗情况 x 改善情况
margin.table(mytable, c(1, 2))
# 治疗情况 x 性别
margin.table(mytable, c(1, 3))


























