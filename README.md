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
  <br>
  <img src="https://github.com/user-attachments/assets/8377f666-3bf7-4c2a-92da-37b36274d89c" alt="로그인" style="width: 180px; height: auto;"> 


- 메인 탭
  - 공연 정보 뷰
  - 쿠폰 이벤트 뷰
  - 공연 검색 뷰
  - 마이페이지 탭 뷰
- 공연 시간 선택 뷰
- 공연 별 댓글 뷰
- 대기열 뷰
- 좌석 선택 뷰
- 결제 정보 뷰
- 결제 및 결제 완료 뷰
- 공연 임박 Push Notification

### E. Trouble Shooting
https://github.com/T82-encore/IOS_T82/wiki/%08Trouble-Shooting

### F. 느낀 점 회고

