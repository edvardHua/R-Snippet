library(stringr)

#
# 合并字符串 str_c
# sep 表示连接符
#
A <- "hello"
B <- "world"
combine <- str_c(A, B, sep = "-")

#
# 计算字符串长度
# 可操作单个字符串，也可以操作向量
#
str_length(c("i","like","programming R",123))

#
# 截取字符串
#
str_sub("banana", 1, 3)


#
# 检测字符串是否包含某种模式
# 两个字符串都包含 ban，返回 true
#
str_detect("banana","ban")
# 返回false
str_detect("wtf","hello")

strings<-c("i","like","programming R")
# 检查这三个字符串是否都包含 i
str_detect(strings,"i")

# 根据正则表达式检验是否匹配
str_detect("fruit","[aeiou]")
str_detect("2012-01-02","[0-9]{4}")

#
# 找出匹配的字符串位置
# 无匹配返回 NA
#
strings <- c("i","like","programming R","abc")
str_locate(strings, "i")

#
# 提取匹配的部分与替换匹配的部分
#
strings<-c("i","like","programming R","abc")
str_extract(strings,"[aoeiu]")
str_match(strings,"[aoeiu]")
# 只会替换第一个被匹配的字段
str_replace(strings,"[aoeiu]","+")


#
# 去除重复字符串
#

str_dup("fruit", 2)

fruit <- c("apple", "pear", "banana")
str_dup(fruit, 2)
str_dup(fruit, 1:3)
str_c("ba", str_dup("na", 0:5))

#
# 分割字符串
#
test <- "余华 / 南海出版公司 / 1998-5 / 12.00元"
str_split(test, " / ")

#
# 加空白和去除空白
#
str_pad("fruit", 10, "both")
str_pad("fruit", 10, "right")
str_trim("  fruit ")













