#r 실행 버젼유의
#64비트에서 실행해야 에러가 적게남
# 첨부된 mysql-connector-java-5.1.38-bin.jar 파일을 다운로드 받아서 C:\ 아래에 두세요.

install.packages("rJava")
install.packages("RJDBC")  

library(rJava)
library(RJDBC)  


#데이터베이스 연결 설정
jdbcDriver <- JDBC(driverClass="com.mysql.jdbc.Driver"
                   , classPath="C://Database/mySQL/mysql-connector-java-5.1.46.jar")

conn <- dbConnect(jdbcDriver, 
                  "jdbc:mysql://localhost:3306/worldcup", "root", "1234")

#sql을 사용해서 r로 데이터 가져오기
r <- dbGetQuery(conn, "SELECT * FROM member")
class(r)
str(r)
r

#############################################
