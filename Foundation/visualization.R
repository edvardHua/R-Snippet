# 数据可视化
# 数值变量的特征和可视化
# 中位数，四分位差 属于稳健的统计量（受极端值影响小）
# 均值，标准差，值域 不是稳健的统计量（受极端值影响大）

x <- c(1,9,2,8,3,9,4,5,7,6)
# 平均值
mean(x)
# 中位数
median(x)
# 方差
var(x)
# 标准差
sd(x)
summary(x)

# Lattice 绘图系统
# 不同风速出现的频率(柱状图)
hist(airquality$Wind,xlab="wind")

# 箱图
boxplot(airquality$Wind,xlab="wind",ylab="Speed(mph)")

# 箱图考察 数值变量（Wind）和分类变量（Month）间的关系
boxplot(Wind~Month,airquality,xlab="Month",ylab="Speed(mph)")

# 散点图
plot(airquality$Wind,airquality$Temp)
with(airquality,plot(Wind,Temp,main="Wind and Temp in NYC"))

# 先画出散点图的 x 轴和 y 轴
with(airquality,plot(
  Wind,
  Temp,
  main="Wind and Temp in NYC",
  type="n"
))
# 筛选月份的值再画到该坐标上
with(
  subset(airquality,Month==9),
  points(Wind,Temp,col="red")
)
with(
  subset(airquality,Month==5),
  points(Wind,Temp,col="blue")
)

with(
  subset(airquality,Month %in% c(6,7,8)),
  points(Wind,Temp,col="black")
)

# 拟合 温度和风速（因变量和自变量）
fit <- lm(Temp~Wind,airquality)
abline(fit,lwd=2)

# 给不同颜色的散点加上注释
legend("topright",pch=1,
       col=c("red","blue","black"),
       legend=c("Sep","May","Other")
)


# ggplot2 绘图系统 需要在 Tools 中安装该包
# 层
# Data       感兴趣的变量（data frame）
# Aesthetics  x-axis/y-axis/color/fill/size/labels/alpha/shape/linear width/linear type
# Geometries  point/line/histogram/bar/boxplot
# Facets      columns/rows
# Statistics  binning/smoothing/descriptive/inferential
# Coordinates cartesian/fixed/polar/limits
# Themes      non-data ink

# 绘图函数

# qplot
library(ggplot2)

# 默认会根据渐变颜色来绘制散点图
qplot(Wind,Temp,data=airquality,color=Month)
# 将月份设置成分类变量
airquality$Month <- factor(airquality$Month)
# 再次绘图，则三点则是使用不同的颜色
qplot(Wind,Temp,data=airquality,color=Month)

qplot(Wind,Temp,data=airquality,color=Month,
      xlab="Wind (mph)", ylab="Temperature", main="Winds Temp")
# 也可以指定散点的颜色
qplot(Wind,Temp,data=airquality,color=I("red"))

# 拟合点
qplot(Wind,Temp,data=airquality,geom=c("point","smooth"))
# 分类拟合并显示曲线，灰色部分代表置信区间
qplot(Wind,Temp,data=airquality,geom=c("point","smooth"),color=Month)

# 一行五列
qplot(Wind, Temp, data = airquality, facets = .~Month)
# 五行一列
qplot(Wind, Temp, data = airquality, facets = Month~.)

qplot(Wind,data = airquality)
# 按月份分别画出风速对应柱状图
qplot(Wind,data = airquality, facets = Month~.)
# 累加柱状图
qplot(Wind,data = airquality, fill = Month)
# 频率分布线
qplot(Wind,data = airquality, geom = "density")
# 按月份画出分频率线
qplot(Wind,data = airquality, geom = "density", color=Month)


# 调色板
# 三类调色板：sequential/diverging/qualitative
# 调色板信息可与colorRamp/colorRampPalette结合使用

# 返回RGB数据，并且由0~1表示逐渐表示渐变色
pal <- colorRamp(c("red","blue"))
pal(0)
pal(1)
pal(0.5)
pal(seq(0,1,len=10))

# 返回的是16进制的颜色
pal <- colorRampPalette(c("red","yellow"))
pal(1)
pal(2)
pal(10)

# 加载配色插件RColorBrewer（需安装）
library(RColorBrewer)
brewer.pal.info

# 在绿色里面取3个颜色
cols <- brewer.pal(3,"Greens")
pal <- colorRampPalette(cols)
image(volcano,col = pal(20))

# 查看调色板中都有什么颜色
display.brewer.pal(3,"Greens");
# 譬如说查看RColorBrewer插件里，BrBG调色板的所包含的11种颜色
display.brewer.pal(11,"BrBG");


# R图像设备
# 简单来说就是将图形输出到屏幕或者PDF或者图像文件中

# 设置工作空间
setwd("C:/workspace/RProject")
# 新建一个pdf文件
pdf(file = "myFig.pdf")
# 画一个简单的图，由于上一句话指定了pdf，右下角则不生成图像
with(airquality,plot(Wind,Temp,main = "Wind and Temp in NYC"))
# 不要忘记下面这句话,会在当前工作路径下生成pdf
dev.off()

# 会在右下角生成散点图
with(airquality,plot(Wind,Temp,main = "Wind and Temp in NYC"))
# 使用该函数就将右下角生成的图输出到png图像中
dev.copy(png,file="myCopy.png")
# 不要忘记调用，否则会一直输出图像到png文件中
dev.off()