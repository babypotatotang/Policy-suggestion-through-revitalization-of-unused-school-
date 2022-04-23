# 데이터 불러오기
lib<- read.csv("도서관기준_test8.csv",header=TRUE, encoding='euc-kr')
options(max.print=1000000
# 데이터 전처리
boxplot(lib$ele)$stats # 초등학교 이상치 없음

boxplot(lib$mid)$stats 
lib$mid=ifelse(lib$mid>13,NA,lib$mid) # 중학교 이상치 3개 결측치로 변환

boxplot(lib$high)$stats 
lib$high=ifelse(lib$high>12,NA,lib$high) # 고등학교 이상치 3개 결측치로 변환환

boxplot(lib$uni)$stats
lib$uni=ifelse(lib$uni>2,NA,lib$uni) # 대학교 이상치 3개 결측치로 변환

boxplot(lib$aca)$stats 
lib$aca=ifelse(lib$aca>770,NA,lib$aca) # 학원 이상치 2개 결측치로 변환

boxplot(lib$public)$stats # 공공도서관 이상치 없음

boxplot(lib$little)$stats # 작은도서관 이상치 없음

boxplot(lib$senior)$stats
lib$senior=ifelse(lib$senior>125,NA,lib$senior) # 경로당 이상치 1개 결측치로 변환

boxplot(lib$ele_num)$stats # 초등학생 수 이상치 없음

boxplot(lib$mid_num)$stats # 중학생 수 이상치 없음

boxplot(lib$high_num)$stats 
lib$high_num=ifelse(lib$high_num>10030,NA,lib$high_num) # 고등학생 수 이상치 1개 결측치로 변환

boxplot(lib$parking)$stats 
lib$parking=ifelse(lib$parking>19,NA,lib$parking) # 주차장 이상치 1개 결측치로 변환

boxplot(lib$bus)$stats 
lib$bus=ifelse(lib$bus>21,NA,lib$bus) # 정류장 이상치 1개 결측치로 변환
