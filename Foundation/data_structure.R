# R 常用的数据结构

# 字符 数值 整数 复数 逻辑
str <- "Hello World"
class(str)

numericVal <- 3.14
class(numericVal)

integerVal <- 2L
class(integerVal)

# TRUE 和 FALSE 要大小写
logicVal <- TRUE
class(logicVal)

# 数据属性
# 名称（name）
# 维度（dimensions:matrix, array）
# 类型（class）

# 因子（factor）
# 分类数据 常用于 lm() glm()

x <- factor(c("female","male","female","male"))
table(x)


# 矩阵和数组（Matrix & Array）


# 矩阵
# 创建了一个空的矩阵
tmpMatrix <- matrix(nrow = 3,ncol = 4)
# 创建了一个1~9的矩阵
tmpMatrix <- matrix(1:12, nrow = 3,ncol = 4)
# 临时矩阵
tmp <- matrix(12:23, nrow = 3,ncol = 4)
# 按行合并两个矩阵，也有按例cbind,用法类似
rbind(tmp,tmpMatrix)

# 查看维度
dim(tmpMatrix)
# 查看属性
attributes(tmpMatrix)
# 改变维度
dim(tmpMatrix) <- c(4,3)

# 数组
# 与矩阵类似，但是数据的维度可以大于2











 