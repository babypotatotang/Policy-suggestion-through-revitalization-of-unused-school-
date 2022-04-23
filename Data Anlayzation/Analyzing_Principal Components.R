#주성분분석
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

# 이제 회귀분석 실시
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