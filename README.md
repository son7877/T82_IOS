# IOS_T82

### A. 프로젝트 목표
- 모바일 어플리케이션 고유의 기능을 최대한 이끌어내기
- MVVM 아키텍처를 활용하여 뷰 로직과 비즈니스 로직을 분리해서 테스트 중 유지 보수가 원활하게 진행하도록 노력하기
- SwiftUI 프레임워크를 사용하여 UIKit 프레임워크와의 장단점 차이 파악하기

### B. 프로젝트 폴더 구조

#### b-1 Project File Tree
```swift
.
├── App
│   ├── AppDelegate.swift
│   ├── ContentView.swift
│   ├── T82App.swift
│   ├── LaunchScreen.storyboard
│   └── ViewRouter.swift
├── Component
│   ├── Button
│   │   └── TicketingProcessBtn.swift
│   ├── NavigationBar
│   │   ├── CustomNavigationBar.swift
│   │   └── NavigationBtnType.swift
│   ├── TabView
│   │   ├── CustomTabBarBtn.swift
│   │   └── CustomTabBarView.swift
│   └── WebView
│       └── WebView.swift
├── Core
│   ├── Extension
│   │   ├── Color+extensions.swift
│   │   ├── Date+Extensions.swift
│   │   └── Format+Extensions.swift
│   ├── Network
│   │   ├── Api
│   │   │   ├── ContentsApi.swift
│   │   │   ├── ContentsDetailApi.swift
│   │   │   ├── PaymentApi.swift
│   │   │   ├── ReviewApi.swift
│   │   │   ├── SeatApi.swift
│   │   │   ├── TicketApi.swift
│   │   │   ├── UserApi.swift
│   │   │   └── VersionCheckApi.swift
│   │   ├── Config.swift
│   │   └── Dto
│   │       ├── LoginResponse.swift
│   │       ├── SignUpResponse.swift
│   │       ├── VersionResponse.swift
│   │       └── WaitingStatusResponse.swift
│   └── Service
│       ├── FaceIDAuthenticator.swift
│       ├── PasswordValidation.swift
│       └── SocialLogin.swift
├── Feature
│   ├── Event
│   │   ├── EventTabInfo.swift
│   │   ├── EventTabView.swift
│   │   ├── EventView.swift
│   │   ├── FirstComesEvent
│   │   │   ├── FirstEventCouponView.swift
│   │   │   └── FirstEventCouponViewModel.swift
│   │   └── PedometerEvent
│   │       ├── PedometerEventView.swift
│   │       └── PedometerEventViewModel.swift
│   ├── Login
│   │   ├── LoginBtn.swift
│   │   ├── LoginView.swift
│   │   ├── LoginViewModel.swift
│   │   ├── SignUpBtn.swift
│   │   └── VersionCheckViewModel.swift
│   ├── Main
│   │   ├── Genre.swift
│   │   ├── GenreRankingSectionView.swift
│   │   ├── MainView.swift
│   │   ├── MainViewModel.swift
│   │   └── SectionView.swift
│   ├── MyPage
│   │   ├── MyFavorite
│   │   │   ├── MyFavoriteView.swift
│   │   │   └── MyFavoriteViewModel.swift
│   │   ├── MyInfoEdit
│   │   │   ├── MyInfoEditingView.swift
│   │   │   └── MyInfoEditingViewModel.swift
│   │   ├── MyPageTabInfo.swift
│   │   ├── MyPageTabView.swift
│   │   ├── MyPageView.swift
│   │   ├── MyReview
│   │   │   ├── MyReviewView.swift
│   │   │   └── MyReviewViewModel.swift
│   │   └── MyTicket
│   │       ├── MyRefundFloatingView.swift
│   │       ├── MyReviewFloatingView.swift
│   │       ├── MyTicketDetailView.swift
│   │       ├── MyTicketView.swift
│   │       └── MyTicketViewModel.swift
│   ├── Payment
│   │   ├── BeforePayment
│   │   │   ├── CouponList
│   │   │   │   ├── CouponListView.swift
│   │   │   │   └── CouponListViewModel.swift
│   │   │   ├── PaymentInProgressView.swift
│   │   │   ├── PaymentPerTicket.swift
│   │   │   ├── PaymentPrice.swift
│   │   │   ├── PaymentSelection.swift
│   │   │   └── PaymentView.swift
│   │   ├── CompletePayment
│   │   │   ├── CompletePrice.swift
│   │   │   ├── PaymentCompleteView.swift
│   │   │   └── PaymentFailureView.swift
│   │   └── PaymentViewModel.swift
│   ├── Reservation
│   │   ├── EventComments
│   │   │   ├── EventCommentReplyView.swift
│   │   │   ├── EventCommentView.swift
│   │   │   └── EventCommentViewModel.swift
│   │   ├── ReservationView.swift
│   │   └── ReservationViewModel.swift
│   ├── Search
│   │   ├── SearchResultsView.swift
│   │   └── SearchViewModel.swift
│   ├── SeatSelect
│   │   ├── SeatsInfo.swift
│   │   ├── SeatsPrice.swift
│   │   ├── SeatsViewModel.swift
│   │   ├── SelectSeatView.swift
│   │   └── WaitingQueueView.swift
│   ├── SignUp
│   │   ├── ImagePicker.swift
│   │   ├── SignUpView.swift
│   │   └── SignUpViewModel.swift
│   └── SubCategory
│       ├── SubCategoryView.swift
│       └── SubCategoryViewModel.swift
├── Model
│   ├── Auth
│   │   └── User.swift
│   ├── Contents
│   │   ├── ContentsDetail.swift
│   │   ├── DiscountedContents.swift
│   │   ├── EventsByDate.swift
│   │   └── MainContents.swift
│   ├── Event
│   │   ├── CouponEvent.swift
│   │   └── Pedometer.swift
│   ├── MyPage
│   │   ├── MyFavorites.swift
│   │   ├── MyInfo.swift
│   │   └── MyTicket.swift
│   ├── Payment
│   │   ├── Coupons.swift
│   │   ├── Payments.swift
│   │   └── Refund.swift
│   ├── Reviews
│   │   ├── EventInfoReviews.swift
│   │   └── MyReview.swift
│   └── Seats
│       ├── Seat.swift
│       └── Sections.swift
└── Preview Content
    └── Preview Assets.xcassets
```

#### b-2 폴더 구조 선정 이유

- App
  - abc
- Core
  - abc
- Component
  - abc
- Feature
  - abc
- Model
  - abc



### C. User Flow

![T82 뷰 구성도 drawio](https://github.com/user-attachments/assets/007b5394-e05c-43d7-a4fb-ed62d24d4f7e)
