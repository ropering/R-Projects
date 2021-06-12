#r 실행 버젼유의
#64비트에서 실행해야 에러가 적게남
# 첨부된 ojdbc6.jar 파일을 다운로드 받아서 C:\ 아래에 두세요.
install.packages("rJava")
install.packages("RJDBC")  

library(rJava)
library(RJDBC)  
library(dplyr)

#데이터베이스 연결 설정
jdbcDriver <- JDBC(driverClass="oracle.jdbc.OracleDriver"
                   , classPath="C://Database/oracle_db/ojdbc6.jar")

conn <- dbConnect(jdbcDriver, 
                  "jdbc:oracle:thin:@localhost:1521/xe", "system", "oracle")

#sql을 사용해서 r로 데이터 가져오기
happiness <- dbGetQuery(conn, "SELECT * FROM system.happiness")
class(happiness)
str(happiness)
View(happiness)

group <- happiness %>% 
  group_by(COUNTRY_NAME) %>% 
  summarise(mean_year = mean(YEAR),
            mean_life_ladder = mean(LIFE_LADDER),
            mean_gdp = mean(LOG_GDP_PER_CAPITA),
            mean_social_support = mean(SOCIAL_SUPPORT),
            mean_healthy_life_expectancy = mean(HEALTHY_LIFE_EXPECTANCY),
            mean_freedom = mean(FREEDOM_TO_MAKE_LIFE_CHOICES),
            mean_generosity = mean(GENEROSITY),
            mean_perceptions_of_corruption = mean(PERCEPTIONS_OF_CORRUPTION),
            mean_positive_affect = mean(POSITIVE_AFFECT),
            mean_negative_affect = mean(NEGATIVE_AFFECT),
            )
View(group)
str(happiness)
#### 나라별 행복도 group_by 변수 ####
g1 <- happiness %>% 
  group_by(COUNTRY_NAME) %>% 
  summarise(mean_happiness = mean(LIFE_LADDER))

g1
str(g1) 


#### 구글 차트 연동 ####
library(googleVis)
#### 나라별 행복도 막대 그래프 ####
barplot <- gvisColumnChart(g1,options=list(title="happiness",
                                           height=400,weight=500))
plot(barplot)

#### 나라별 행복도 지도 시각화 ####
geochart <- gvisGeoChart(g1, locationvar="COUNTRY_NAME", 
                 colorvar="mean_happiness", 
                 options=list(projection="kavrayskiy-vii")) 
plot(geochart)

#### 1인당 GDP - 행복도 (나라별) 산점도 그래프 ####
library(ggplot2)
g2 <- happiness %>% 
  group_by(COUNTRY_NAME) %>% 
  summarise(mean_happiness = mean(LIFE_LADDER),
            mean_gdp = mean(LOG_GDP_PER_CAPITA)
            )

par(mfrow=c(2,3))

ggplot(data = g2, aes(x = mean_gdp, y = mean_happiness )) + geom_point()


#### 사회적 지원 - 행복도 (나라별) ####
ggplot(data = group, aes(x = mean_social_support, y = mean_life_ladder)) + geom_point(
)

#### 1인당 GDP - 기대 수명 ####
ggplot(data = group, aes(x = mean_gdp, y = mean_healthy_life_expectancy)) + geom_point()

#### 인생 선택의 자유 - 행복도 ####
ggplot(data = group, aes(x = mean_freedom, y = mean_life_ladder)) + geom_point()

#### 관대(기부) - 행복도 ####
ggplot(data = group, aes(x = mean_generosity, y = mean_life_ladder)) + geom_point()

#### 부패에 대한 인식 - 행복도 #### 
ggplot(data = group, aes(x = mean_perceptions_of_corruption, y = mean_life_ladder)) + geom_point()
# 많은 사람들이 자신의 나라가 부패했다고 여긴다

par(mfrow=c(1,1))















#### 1인당 GDP - 행복도 (나라별) 상관행렬 히트맵 ####
library(corrplot)
View(happiness)
g3 <- happiness[,c(9,10,11)]
str(g3)
g3_cor <- cor(g3)
corrplot(g3_cor)

View(happiness[,c(2,3,4,5,6,7,8,9,10,11)])

#### 행복도 wordcloud2 표현 ####
library(wordcloud2)
wordcloud2(g1)





































########################################################
#거의 모든 sql문이 가능
sql <- "select Afghanistan, count(*) as cnt   
       from scott.lifeladder   group by year
        order by year   "
r <- dbGetQuery(conn, sql)
r
########################################################
#job_id별 salary의 합계는?

sql <- "select job, sum(sal) as sum_sal   
       from emp   group by job   
       order by job desc   "
r <- dbGetQuery(conn, sql)   
r 
#########################################################
df_happiness <- rename(df_happiness,
                       c(country="Country",
                         year="year",
                         happiness="Life.Ladder",
                         GDP="Log.GDP.per.capita",
                         support="Social.support",
                         Healthy="Healthy.life.expectancy.at.birth",
                         Freedom="Freedom.to.make.life.choices",
                         donation="Generosity",
                         corruption="Perceptions.of.corruption",
                         Positive="Positive.affect",
                         Negative="Negative.affect"))

head(df_happiness)