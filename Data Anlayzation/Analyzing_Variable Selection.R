# 변수선택법으로 다중공선성을 해결해보자
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