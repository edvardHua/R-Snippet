# 重要函数
# 循环 | 排序 | 总结信息

# lapply
# 可以循环处理列表中的每一个元素
# lapply(列表, 函数, 其他参数) 返回列表

x <- list(a = 1:10, b = c(11, 21, 31, 41, 51))
# 对x列表求均值
lapply(x, mean)

x <- 1:4
# 会强制转换成列表来处理，正太分布，随机从0，1抽取
lapply(x, runif)
lapply(x, runif,  min = 0,  max = 100)

x <- list(a = matrix(1:6, 2, 3), b = matrix(4:7, 2, 2))
# 遍历每一个矩阵的第一行
lapply(x, function(m) m[1, ])

# sapply
# 与lapply所不同的是，他能简化返回结果
x <- list(a = 1:10, b = c(11, 21, 31, 41, 51))
# 对x列表求均值
lapply(x,  mean)
sapply(x,  mean)

# apply
# 沿着数组某一维度处理数据
# apply(数组，维度，函数名)

x <- matrix(1:16, 4, 4)

# 对第二维度（列）求平均和求和
apply(x, 2, mean)
apply(x, 2, sum)
# 另一种方法, 对行或者列求和
rowSums(x)
rowMeans(x)
colSums(x)
colMeans(x)

x <- matrix(rnorm(100), 10, 10)
apply(x, 1, quantie, probs = c(0.25, 0.75))

# 创建3个2行3列的数组
x <- array(rnorm(2*3*4), c(2, 3, 4))
# 按照第三维度来求平均
apply(x, c(1, 2), mean)
# 按第二维度（列）求平均
apply(x, c(1, 3), mean)
# 按第二维度（行）求平均
apply(x, c(2, 3), mean)

# mapply
# lapply 多元版本
# mapply(函数/函数名, 数据, 函数相关参数)

# 四个1, 3个2, 2个3，1个4
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
# 和上面语句效果一样, 对比两个数据效果
mapply(rep, 1:4, 4:1)

# 从标准为mean，标准差为std的数据抽取n个数据
s <- function(n, mean, std){
  rnorm(n, mean, std)
}
s(4, 0, 1)

mapply(s, 1:5, 5:1, 2)


# tabbly
# 对向量的子集
# tapply(向量，因子，函数)

# 5个正态分布，5个均匀分布，5均值为1标准差为0的正态分布
x <- c(rnorm(5), runif(5), rnorm(5, 1))

# 因子包含3个水平，每个水平有5个元素
f <- gl(3, 5)

# 对x向量进行因子f水平进行分组，对每组进行求值
tapply(x,  f,  mean)
tapply(x,  f,  mean,  simplify  =  FALSE)

# split
# 根据因子或者因子列表将向量或者其他对象分组
# 通常和lapply一起使用
# split(向量/列表/数据框, 因子/因子列表)

# 5个正态分布，5个均匀分布，5均值为1标准差为0的正态分布
x <- c(rnorm(5), runif(5), rnorm(5, 1))
# 因子包含3个水平，每个水平有5个元素
f <- gl(3, 5)

# 按照因子f对数组x分组
split(x, f)

# 求三个水平的平均值
lapply(split(x, f), mean)

# 返回这个数据集的第一部分
head(airquality)

# 按照月份来分组 airquality
s <- split(airquality, airquality$Month)

# 包含了多少个月份，每个月份下有多少个数据
table(airquality$Month)

# 计算列的平均值
lapply(s, function(x) colMeans(x[, c("Ozone", "Wind", "Temp")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Wind", "Temp")]))
# 去掉除缺失值
sapply(s, function(x) colMeans(x[, c("Ozone", "Wind", "Temp")], na.rm  =  FALSE))



# 排序
# sort:对向量进行排序，返回排好序的内容
# order:返回排好序的内容的下标/多个排序标准

x <- data.frame(v1 = 1:5, v2 = c(10, 7, 9, 6, 8), v3 = 11:15, v4 = c(1, 1, 2, 2, 1))
sort(x$v2)
sort(x$v2, decreasing  =  TRUE)

# 返回排好的数的行数
order(x$v2)

# 按照行数重组x
x[order(x$v2), ]

# 按照v4列进行排序，如果遇到相同，则按照v2列来排序
x[order(x$v4, x$v2), ]
x[order(x$v4, x$v2, decreasing  =  TRUE), ]



# 总结数据信息

# 返回前10行数据
head(airquality,10)
# 返回最后的6行数据
tail(airquality)
# 总结该数据库，每列均值，中值，75%的值等
summary(airquality)
# 对month列进行总结
table(airquality$Month)
# 如果有NA,计算NA记录数
table(airquality$Ozone,useNA = "ifany")
table(airquality$Month,airquality$Day)
# 该列是否存在缺失值，返回boolean
any(is.na(airquality$Ozone))
# 计算NA的数量
sum(is.na(airquality$Ozone))
# 月份值是否都小于12
all(airquality$Month < 12)

titanic <- as.data.frame(Titanic)
head(titanic)
# 查看维度
dim(titanic)
summary(titanic)
# 交叉表,仓位和年龄的交叉表
x <- xtabs(Freq ~ Class + Age, data=titanic)
# 用扁平化显示
ftable(x,exclude = exclude)

# 计算数据大小
object.size(airquality)
# 换算大小输出，注意"K"是大写
print(object.size(airquality),units="Kb")