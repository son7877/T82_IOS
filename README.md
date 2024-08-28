# IOS_T82

### A. 프로젝트 목표
- 모바일 어플리케이션 고유의 기능을 최대한 이끌어내기
- MVVM 아키텍처를 활용하여 뷰 로직과 비즈니스 로직을 분리해서 테스트 중 유지 보수가 원활하게 진행하도록 노력하기
- SwiftUI 프레임워크를 사용하여 UIKit 프레임워크와의 장단점 차이 파악하기

### B. 프로젝트 구성

#### b-1 Project File Tree
https://github.com/T82-encore/IOS_T82/wiki/Project-File-Tree

#### b-2 폴더 구조 선정

- App
  - 어플 구동에 관한 기본 설정 및 런치 스크린으로 구성
- Core
  - 어플의 REST api 호출 로직 및 비즈니스 로직으로 구성
- Component
  - 어플에서 자주 사용하는 UI 컴포넌트(ex. 커스텀 네비게이션 바 및 탭뷰..)로 구성
- Feature
  - 어플에서 각 기능 별 모듈을 관리 -> 주로 UI와 직접적으로 상호작용하는 View와 통신 및 UI로직을 처리하는 ViewModel로 구성
- Model
  - 어플 내의 데이터 구조를 정의하는 모델들로 구성

### C. User Flow

![T82 뷰 구성도 drawio](https://github.com/user-attachments/assets/007b5394-e05c-43d7-a4fb-ed62d24d4f7e)

### D. 개발 내용
- 로그인 및 회원 가입

  <img src="https://github.com/user-attachments/assets/8377f666-3bf7-4c2a-92da-37b36274d89c" alt="로그인" style="width: 180px; height: auto;"> <img src="https://github.com/user-attachments/assets/923d82ab-e0dc-42fe-8391-8976d7cdd6ba" alt="버전 확인" style="width: 180px; height: auto;"> <img src="https://github.com/user-attachments/assets/0532e222-09bd-4a3b-a75e-bc2be7f11698" alt="회원 가입" style="width: 180px; height: auto;"> 


- 메인 탭 뷰
  - 공연 정보 뷰

   <img src="https://github.com/user-attachments/assets/25963b9a-e115-40e7-9fea-31269fe4b3f6" alt="알림 권한" style="width: 180px; height: auto;"> <img src="https://github.com/user-attachments/assets/3bce9e83-2aae-4f86-89e7-349d6031b4bf" alt="상위 카테고리" style="width: 180px; height: auto;"> <img src="https://github.com/user-attachments/assets/fa5334fa-8ec3-45c8-b1dc-4e1b9dbdad8e" alt="하위 카테고리" style="width: 180px; height: auto;">
  
  - 쿠폰 이벤트 뷰
    
    <img src="https://github.com/user-attachments/assets/5677d968-6f31-476f-a0f5-608a88b46c0e" alt="쿠폰 이벤트1" style="width: 200px; height: auto;"> <img src="https://github.com/user-attachments/assets/ce8a22ee-6009-4f52-9ad5-9df57720d446" alt="쿠폰 이벤트2" style="width: 192px; height: auto;"> 
    
- 공연 시간 선택 뷰
- 공연 별 댓글 뷰
- 대기열 뷰
- 결제 및 결제 완료 뷰
- 마이 페이지 탭 뷰
  - 내 예매 내역 뷰
  - 내 찜 목록 뷰
- 공연 임박 Push Notification

### E. Trouble Shooting
https://github.com/T82-encore/IOS_T82/wiki/%08Trouble-Shooting

### F. 느낀 점 회고
