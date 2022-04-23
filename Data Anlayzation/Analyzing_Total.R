library(dplyr)
library(car)
library(lmtest)

# Data Preprocessing (데이터 전처리)
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

#상관계수 확인 
lib2= lib %>% filter(!is.na(mid) & !is.na(high) & !is.na(uni) & !is.na(aca) & !is.na(senior) & 
!is.na(high_num) &!is.na(parking) & !is.na(bus)) # 결측치가 없는 행 추출
lib2
# 변수들의 상관계수 확인
pairs(lib2[,2:15])
heatmap(cor(lib2[,2:15]))
round(cor(lib2[,2:15]),3) 

# 다중공선성 확인
model=lm(client~ele+mid+high+uni+aca+public+little+senior+parking+bus+ele_num+mid_num+high_num,data=lib2) 
vif(model)
# 다중공선성이 확인되었으니 주성분 분석으로 다중공선성을 해결해보자

#Principal Components (주성분분석)
lib2=transform(lib2,ele1=scale(ele),mid1=scale(mid),high1=scale(high),uni1=scale(uni),aca1=scale(aca),
            public1=scale(public),little1=scale(little),senior1=scale(senior),ele_num1=scale(ele_num),
            mid_num1=scale(mid_num),high_num1=scale(high_num),parking1=scale(parking),bus1=scale(bus),client1=scale(client))

colnames(lib2) # 각 변수들을 표준화한 새변수들을 확인

lib3=lib2[,c('name','ele1','mid1','high1','aca1','public1','little1','ele_num1','mid_num1','high_num
1','uni1','senior1','parking1','bus1','client1')]
lib3

lib_princomp=princomp(lib3[,2:10],cor=TRUE)

summary(lib_princomp) # 누적 분산도가 85% 넘도록 변수를 선택하면 2개까지 선택해야함.
loadings(lib_princomp)
screeplot(lib_princomp, type='lines', main='scree plot') 
write.csv(lib3,'C:/Users/user/Desktop/도서관 압축/lib3.csv')

lib4<- read.csv("lib4.csv",header=TRUE, encoding='euc-kr') 

# 다중공선성 재확인
model=lm(client1~X1+X2+uni1+senior1+parking1+bus1,data=lib4)
vif(model) # 모든 변수의 다중공선성이 10 미만

# 회귀분석
model=lm(client1~X1+X2+uni1+senior1+parking1+bus1,data=lib4)
summary(model)
new_model=step(model,direction='both')
summary(new_model)

dwtest(model)
dwtest(new_model)
model_res=residuals(model)
durbinWatsonTest(model_res) # DW=1.263이다. 2에 가깝지 않으므로 독립이라 볼 수 있다. durbinWatsonTest(new_model) # 독립성 만족 못함
# 잔차의 등분산성 검정
ncvTest(model) # 유의수준 0.05에서 기각이 가능하므로 등분산성은 성립못함. ncvTest(new_model) # 등분산성 만족 못함
# 잔차의 정규성 검정
shapiro.test(model_res) # 유의수준 0.05에서 기각 못하므로 정규성 만족
shapiro.test(new_model$residuals) # 정규성 만족못함
plot(model) 
plot(new_model) # 선형성 만족

# Variable Selection(변수선택법)
model2=lm(client~ele+mid+high+uni+aca+public+little+senior+parking+bus+ele_num+mid_num+high_num,data=lib2) 
vif(model2) 
summary(model2) 
new_model2=step(model2,direction='both') # 위 2개의 이유로 단계적선택법을 통하여 변수를 선택하자. 
summary(new_model2) 

# 잔차의 독립성 검정
dwtest(new_model2) # DW=2.08 이므로 2에 상당히 가까우므로 독립이라 할 수 있다. # 잔차의 등분산성 검정
ncvTest(new_model2) # 등분산성 만족

# 잔차의 정규성 검정
shapiro.test(new_model2$residuals) # 등분산성 만족
plot(new_model2) # residuals vs fitted 일정 구간에서 기울기가 0에 가까우므로 선형성을 만족한다고 볼 수 있다

# 회귀분석
model=lm(client1~X1+X2+uni1+senior1+parking1+bus1,data=lib4)
summary(model)
new_model=step(model,direction='both')
summary(new_model)