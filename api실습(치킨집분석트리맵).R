
search() # 패키지 출력

install.packages("readxl")
install.packages("dplyr")
library(readxl)
dir()

ck <- read_xlsx("치킨집_가공.xlsx")
head(ck)
View(ck)

#substr() 함수를 이용하여 소재지전체주소에 있는 11~15번째 문자 가져오기
ck$소재지전체주소
# 주소의 '동' 부분 가져오기
substr(ck$소재지전체주소, 12, 16)

# substr() 하면 자료형이 character로 바뀐다
addr <- substr(ck$소재지전체주소, 12, 16)
class(addr)
head(addr)

#gsub 내장함수 이용, 특정문자 제거
gsub("[0-9]", "", addr) # 간단 사용법
addr_num <- gsub("[0-9]", "", addr) # 숫자 제거
addr_trim <-  gsub(" ", "", addr_num) # 공백 
head(addr_trim)

library(dplyr)

#table() 함수를 이용해서 숫자 세기, 변수가 한개일때 도수분표표를 만들어줌
addr_count <- addr_trim %>% table() %>% data.frame()
head(addr_count)

install.packages("treemap")
library(treemap)

#treemap(데이터, index=인덱스 표시 열 제목, vSize=크기를 이용할 열 제목, vColor=컬러, title=제목)
treemap(addr_count, 
        index = ".", 
        vSize = "Freq", 
        title = "서대문구 동별 치킨집 분표")
arrange(addr_count, desc(Freq)) %>% head()
