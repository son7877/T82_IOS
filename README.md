# IOS_T82

### A. 프로젝트 목표
- 모바일 어플리케이션 고유의 기능을 최대한 이끌어내기
- MVVM 아키텍처를 활용하여 뷰 로직과 비즈니스 로직을 분리해서 테스트 중 유지 보수가 원활하게 진행하도록 노력하기
- SwiftUI 프레임워크를 사용하여 UIKit 프레임워크와의 장단점 차이 파악하기

### B. 프로젝트 구성

#### b-1 Project File Tree
프로젝트 구조 트리 링크 : https://github.com/T82-encore/IOS_T82/wiki/Project-File-Tree

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
 
#### b-3 사용한 프레임워크 및 라이브러리

- 프로그래밍 언어 및 프레임워크
  
  ![Swift 5.1](https://img.shields.io/badge/Swift-5.1-FA7343?logo=swift&logoColor=white)
  ![SwiftUI](https://img.shields.io/badge/SwiftUI-007AFF?logo=swift&logoColor=white)
  ![CoreMotion](https://img.shields.io/badge/CoreMotion-gray?logo=apple&logoColor=white)

- 개발 도구 및 CI/CD
  
  ![Xcode IDE](https://img.shields.io/badge/Xcode%20IDE-1575F9?logo=xcode&logoColor=white)
  ![Xcode Cloud](https://img.shields.io/badge/Xcode%20Cloud-147EFB?logo=xcode&logoColor=white)
  ![TestFlight](https://img.shields.io/badge/TestFlight-007AFF?logo=apple&logoColor=white)

- 라이브러리 및 SDK
  
  ![Alamofire 5.8.1](https://img.shields.io/badge/Alamofire-5.8.1-FF4500?logo=swift&logoColor=white)
  ![PopupView](https://img.shields.io/badge/PopupView-3.0.4-FF4500?logo=swift&logoColor=white)
  ![Firebase](https://img.shields.io/badge/Firebase-10.29.0-FFCA28?logo=firebase&logoColor=white)

- OAuth 및 결제 서비스
  
  [![Kakao Oauth](https://img.shields.io/badge/Kakao%20Oauth-2.21.1-FFCD00?logo=kakaotalk&logoColor=white)](https://developers.kakao.com/)
  [![Google Oauth](https://img.shields.io/badge/Google%20Oauth-7.1.0-4285F4?logo=google&logoColor=white)](https://developers.google.com/identity/protocols/oauth2)
  [![Toss Payments](https://img.shields.io/badge/Toss%20Payments-0.1.32-0070f2?logo=toss&logoColor=white)](https://toss.im/mediakit)



### C. User Flow

![T82 뷰 구성도 drawio](https://github.com/user-attachments/assets/007b5394-e05c-43d7-a4fb-ed62d24d4f7e)

### D. 개발 내용
- 로그인 및 회원 가입
  - 어플 실행 시 TestFlight에 등록되어있는 어플 버전(빌드번호)과 현재 기기에 설치되어있는 어플 버전(빌드번호)를 비교하여 업데이트 알림 유무 결정
  - 일반 회원 로그인 외에도 카카오, 구글 로그인이 가능하도록 구현
  - 로그인 시 사용자 아이디를 Key로 설정해서 유저별로 필요한 정보(공연 찜 목록)를 UserDefaults에 저장하도록 설정
    
  <img src="https://github.com/user-attachments/assets/8377f666-3bf7-4c2a-92da-37b36274d89c" alt="로그인" style="width: 180px; height: auto;"> <img src="https://github.com/user-attachments/assets/923d82ab-e0dc-42fe-8391-8976d7cdd6ba" alt="버전 확인" style="width: 180px; height: auto;"> <img src="https://github.com/user-attachments/assets/0532e222-09bd-4a3b-a75e-bc2be7f11698" alt="회원 가입" style="width: 180px; height: auto;"> 


- 메인 탭 뷰
  - 공연 정보 뷰
    - 보다 다양한 카테고리 별 공연과 티켓팅 오픈일이 다가오는 공연들로 메인 뷰 구성

   <img src="https://github.com/user-attachments/assets/25963b9a-e115-40e7-9fea-31269fe4b3f6" alt="알림 권한" style="width: 180px; height: auto;"> <img src="https://github.com/user-attachments/assets/3bce9e83-2aae-4f86-89e7-349d6031b4bf" alt="상위 카테고리" style="width: 180px; height: auto;"> <img src="https://github.com/user-attachments/assets/fa5334fa-8ec3-45c8-b1dc-4e1b9dbdad8e" alt="하위 카테고리" style="width: 180px; height: auto;">
  
  - 쿠폰 이벤트 뷰
    - 한정 수량 선착순 쿠폰 이벤트 및 만보기 쿠폰 이벤트 구현
    - CoreMotion 프레임워크에서 CMPedoMeter클래스를 사용해서 실시간으로 걸음 수 측정이 가능
    - UserDefaults 저장소를 사용해서 걸음 수를 저장하고 매일 걸음 수가 초기화되도록 로직 구현
    
    <img src="https://github.com/user-attachments/assets/5677d968-6f31-476f-a0f5-608a88b46c0e" alt="쿠폰 이벤트1" style="width: 200px; height: auto;"> <img src="https://github.com/user-attachments/assets/ce8a22ee-6009-4f52-9ad5-9df57720d446" alt="쿠폰 이벤트2" style="width: 192px; height: auto;"> 
    
- 공연 시간 선택, 대기열 및 좌석 선택 뷰
  - 공연 시간 선택 뷰에서 공연 별 잔여 좌석 확인
  - 공연 시간 선택 우측 상단의 하트 마크를 이용해서 찜 여부를 설정
  - 좌석 선택 뷰로 넘어가기 전에 대기열 웹뷰로 이동
  
  <img src="https://github.com/user-attachments/assets/61d86fa1-440b-424d-a373-28c1a9714c1e" alt="공연 시간 선택" style="width: 200px; height: auto;"> <img src="https://github.com/user-attachments/assets/7f2b772d-d9e5-4c39-afac-1858415ec1d7" alt="대기열" style="width: 200px; height: auto;"> <img src="https://github.com/user-attachments/assets/c7743d15-753d-4f98-9499-1a16028da0d5" alt="좌석 선택" style="width: 200px; height: auto;">

- 결제 및 결제 완료 뷰
  - 토스 페이먼트로 티켓 결제 기능 구현
  - 결제 완료시 티켓 확인을 위해 마이페이지의 내 티켓 뷰로 이동


  
- 공연 별 댓글 뷰
  - 공연 별로 공연을 관람한 관객들의 별점 및 후기를 확인 가능하도록 구현
  - 인플루언서가 답글을 달았을때 닉네임 옆에 별도의 구분표시를 해두어 인플루언서와 소통이 가능함을 인지하도록 구현

  <img src="https://github.com/user-attachments/assets/45dc7e43-efbe-4752-9942-aa57cd29f399" alt="공연 댓글" style="width: 200px; height: auto;"> <img src="https://github.com/user-attachments/assets/d1b1c6f6-45ef-455a-a661-005be07cc004" alt="공연 대댓글" style="width: 200px; height: auto;">  


- 마이 페이지 탭 뷰
  - 내 티켓 뷰
    - 각 티켓을 터치하면 티켓 QR코드와 리뷰 등록 및 환불 신청을 할 수 있는 뷰를 Modal로 구현 
    - 리뷰 등록 시 별점 및 이미지 등록도 가능하도록 구현
    - 환불 신청 시 기기의 FaceID 인증을 통한 본인 확인 기능 구현
   
    <img src="https://github.com/user-attachments/assets/851b1c0e-fb96-4498-984b-87d978b5f6f8" alt="내 예매 내역" style="width: 200px; height: auto;"> <img src="https://github.com/user-attachments/assets/50c021e4-9e7d-4d35-8e19-854d5743a21e" alt="예매 내역 상세" style="width: 200px; height: auto;"> <img src="https://github.com/user-attachments/assets/6b996ee5-6d7d-4f77-8cce-8c45c95f9757" alt="리뷰 작성" style="width: 200px; height: auto;"> <img src="https://github.com/user-attachments/assets/a103f803-e55d-4d98-9d09-2518755f4b89" alt="환불 신청" style="width: 200px; height: auto;">
    
  - 내 찜 목록 뷰
    - 공연 시간 선택 뷰에서 찜한 공연 목록을 볼 수 있도록 구현
      
      <img src="https://github.com/user-attachments/assets/9afb6e47-9719-4826-9fa4-b35826811ca3" alt="내 찜 목록" style="width: 200px; height: auto;">
  
- 공연 임박 Push Notification
  - 예매한 티켓 정보 중 공연 시작 시간을 토대로 공연 15분전 공연 임박알림 기능 구현(FCM)

  <img src="https://github.com/user-attachments/assets/f9c97270-ed8f-45ce-97ef-69f9c7cefc17" alt="알림1" style="width: 200px; height: auto;"> <img src="https://github.com/user-attachments/assets/b06531af-ff12-4251-8b8a-e2c5281812de" alt="알림2" style="width: 200px; height: auto;">

### E. Trouble Shooting
https://github.com/T82-encore/IOS_T82/wiki/%08Trouble-Shooting
