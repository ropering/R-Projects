#### 일반 휘발유와 고급 휘발유의 도시 연비 t 검정 ####

ls()
rm(list = ls()) # 전체 OB 삭제
ls()
gc() # 메모리 사용량

library(ggplot2)
mpg
class(mpg)

mpg <- as.data.frame(ggplot2::mpg) # data frame으로 변환
class(mpg)

str(mpg)
library(dplyr)
mpg %>% select(fl, cty) %>% 
  filter(fl %in% c("r", "p"))

mpg_diff2 <- mpg %>% select(fl, cty) %>% 
  filter(fl %in% c("r", "p"))

table(mpg_diff2)

t.test(
  data = mpg_diff2, cty ~fl, var.equl = T
)

# 상관분석 - 두 변수의 관계성 분석
#### 실업자 수와 개인 소비 지출의 상관관계 ####
# unemploy : 실업자 수
# pce : 개인 소비 지출
library(ggplot2)

economics <- as.data.frame(ggplot2::economics)
cor.test(economics$unemploy, economics$pce)

#### 상관행렬 히트맵 만들기 ####
install.packages("corrplot")
library(corrplot)

head(mtcars)
 
cor(mtcars) # 데이터프레임을 상관행렬로 변환
car_cor <- cor(mtcars) 
car_cor # 소수점 문제
car_cor <- round(car_cor, 2) # 소수점 처리

corrplot(car_cor)

corrplot(car_cor, method = "number")

col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(car_cor,
         method = "color",
         type = "lower",
         order = "hclust",
         addCoef.col = "black",
         tl.col = "black",
         tl.srt = 45,
         diag = F
         )





