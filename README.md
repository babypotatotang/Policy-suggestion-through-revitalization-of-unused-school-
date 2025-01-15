# Policy for unused school
[2021] Policy for unused school: 미활용 폐교 활용을 통한 정책 제언     

_Update: 2022-04-23_   
## **Index**
+ [About this project](#about-this-project)   
+ [Overview](#overview)   
  + [Goal](#goal)   
  + [Flow](#flow)   
+ [Detail Function](#detail-function)
  + [Crawling](#crawling)
  + [Visualization](#visualization)
  + [Analyzation](#analyzation)
+ [Environment](#environment)   


## **About this project**    
<img src = "https://user-images.githubusercontent.com/68631435/164896720-2b18f5f3-66f9-4d80-b361-730ff13068d0.png" width="60%" height="40%">           

+ 프로젝트 이름: 미활용 폐교 활용을 통한 정책 제언       
+ 프로젝트 진행 목적:  2021 공공빅데이터 인턴십 실무형 프로젝트    
    + 2021 공공빅데이터 인턴십 URL: https://www.data.go.kr/bbs/ntc/selectNotice.do?originId=NOTICE_0000000002033    
+ 프로젝트 진행 기간:  2021년 8월     
+ 프로젝트 참여 인원:  7명        

## **Overview** 
> ### **Goal**   
+ (목적) 미활용 폐교에 대한 수요를 기반으로 적합한 활용도를 찾아 폐교를 선정하는 모델을 제시함.    
+ (필요성) 미활용 방치 폐교의 활용 방안을 제시함으로써 시설의 불법적인 활용을 선제 예방하며 미연의 사고를 방지함.   
> ### **Flow**
<img src = "https://user-images.githubusercontent.com/68631435/164910196-fae9271e-0657-4a43-8204-a73926278a7e.jpg" width="60%" height="40%">    



>## **Detil Function**
### **Crawling**   
파일 위치:PolicySuggestion-through-RevitalizationUnusedSchool/Data Crawling
+ python selenium 크롤러를 활용하여 홈페이지에서 필요한 데이터를 크롤링함.    
+ 네이버 블로그 게시글의 경우 네이버 API를 사용하여 크롤링 하였음.  
+ Web Crawling한 데이터 항목   
  + 경상남도 경로당 이름, 주소   
  + 경상남도 초등학교별 학생 수   
  + 경상남도 중학교별 학생 수   
  + 경상남도 고등학교별 학생 수   
  + '도서관' 키워드에 대한 네이버 블로그 글   

### **Visualization**
+ R 환경에서 워드클라우드 제작    
+ '도서관' 컨텐츠에 대한 인식 확인을 위함.   

### **Analyzation**   
+ R 환경에서 데이터를 분석함. 
+ 분석 절차는 아래와 같음. 
    + (1) 데이터 전처리  
    + (2) 데이터 정합성 검증 (다중공선성 확인)  
    + (3) 다중 공선성 해결   
      + 주성분분석  
      + 변수 선택법  
    + (4) 회귀분석   
 
**Environment** 
+ Python 3.8   
+ Anaconda 4.10.3    
+ R 4.1.0
