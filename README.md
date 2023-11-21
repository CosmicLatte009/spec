<div align="center">

# IT 커뮤니티 어플 **SFACE** 🫡💻

</div>

**[개발일정]**

#### 2023.10.23(월) ~ 11월 17(금)

<!-- 이미지 -->

<!-- ![금방내방 메인](https://user-images.githubusercontent.com/87015026/182022661-9cc66df3-3f9a-4358-a12b-a887723e47ee.png) -->

## 1. 소개 

sface 앱은 IT 공부를 하는 사람들이 사용할 수 있는 소셜 미디어 플랫폼입니다. 사용자 친화적인 인터페이스와 커뮤니케이션 기능을 통해, 사용자가 쉽고 재미있게 소통할 수 있도록 설계되었습니다.

## 🙋‍♀️ 팀원 소개 🙋‍♂️
|  **팀장 손세은**  |  **팀원 고은서** |  **팀원 황혜명**  |
|:----------:|:----------:|:----------:|
|  아바타 이미지 |  ''  |  '' |
|  GitHub: [seeunson](https://github.com/seeunson) <br> Blog: |   GitHub: [Ko-Eunseo](https://github.com/Ko-Eunseo) <br> Blog: | GitHub: [CosmicLatte009](https://github.com/CosmicLatte009) <br> Blog: |


## 2. 개발 환경 및 커밋 컨벤션 

**[개발 환경]**

- Front-End: Flutter, GetX, Dio, Flutter Secure Storage
- Back-End: 제공된 API 사용
- 버전 관리 및 이슈:  [GitHub-Issues](https://github.com/9weeks-flutter-sface/SPEC/issues?q=is%3Aissue+is%3Aclosed)
- GitHub-Flow

```yaml
dependencies:
  bubble: 1.2.1
  cupertino_icons: 1.0.2
  dio: 5.3.3
  flutter:
    sdk: flutter
  flutter_secure_storage: 5.1.2
  flutter_svg: 2.0.7
  flutter_switch: 0.3.2
  get: 4.6.6
  intl: 0.18.1
  screenshot: ^2.1.0
  shimmer: 3.0.0
  smooth_page_indicator: 1.0.0
  url_launcher: 6.2.1
  path_provider: 2.1.1
```
**[커밋 컨벤션]**

```
    Feat: 새로운 기능을 추가할 경우
    Fix: 버그를 고친 경우
    Design: CSS등 사용자 UI 디자인 변경
    !BREAKING CHANGE: 커다란 API 변경의 경우
    !HOTFIX: 급하게 치명적인 버그를 고쳐야하는 경우
    Style: 코드 포맷 변경, 세미 콜론 누락, 코드 수정이 없는 경우
    Refactor: 프로덕션 코드 리팩토링
    Comment: 필요한 주석 추가 및 변경
    Docs: 문서를 수정한 경우
    Test: 테스트 추가, 테스트 리팩토링
    Chore: 빌드 태스트 업데이트, 패키지 매니저를 설정하는 경우
    Rename: 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우
    Remove: 파일을 삭제하는 작업만 수행한 경우
    참고: https://overcome-the-limits.tistory.com/entry/%ED
```

## 3. 프로젝트 구조 🗂 

```
📦lib
 ┣ 📂controller
 ┃ ┣ 📂auth
 ┃ ┣ 📂catchup
 ┃ ┣ 📂etc
 ┃ ┣ 📂me
 ┃ ┣ 📂mogak
 ┃ ┃ ┣ 📂me
 ┃ ┣ 📂talk
 ┃ ┃ ┣ 📂me
 ┣ 📂model
 ┃ ┣ 📂catchup
 ┃ ┣ 📂home
 ┃ ┣ 📂me
 ┃ ┣ 📂mogak
 ┃ ┣ 📂talk
 ┃ ┗ 📂user
 ┣ 📂util
 ┃ ┣ 📜api_routes.dart
 ┃ ┣ 📜app_pages.dart
 ┃ ┣ 📜app_page_routes.dart
 ┣ 📂view
 ┃ ┣ 📂page
 ┃ ┃ ┣ 📂auth
 ┃ ┃ ┣ 📂best_spacer
 ┃ ┃ ┣ 📂catchup
 ┃ ┃ ┣ 📂me
 ┃ ┃ ┣ 📂mogak
 ┃ ┃ ┃ ┣ 📂me
 ┃ ┃ ┣ 📂talk
 ┃ ┃ ┃ ┣ 📂me
 ┃ ┗ 📂widget
 ┃ ┃ ┣ 📂alert
 ┃ ┃ ┣ 📂avatar
 ┃ ┃ ┣ 📂bestSpacer
 ┃ ┃ ┣ 📂button
 ┃ ┃ ┣ 📂card
 ┃ ┃ ┣ 📂navigation
 ┃ ┃ ┣ 📂popup
 ┃ ┃ ┣ 📂select
 ┃ ┃ ┣ 📂tab
 ┃ ┃ ┣ 📂tag
 ┃ ┃ ┣ 📂talk
 ┃ ┃ ┣ 📂textEditor
 ┃ ┃ ┗ 📂upAndComent
 ┗ 📜main.dart
```

## 4. 역할 분담 👨‍👩‍👧‍👧

### [👩🏻‍💻손세은](https://github.com/seeunson)

- 
- 

### [👩🏻‍💻고은서](https://github.com/Ko-Eunseo)

- 회원가입 페이지, 프로필 설정 및 수정 페이지
- 모각코 페이지 및 관련 위젯
- 텍스트필드 위젯, 팝업 위젯, 탭 위젯, 아바타 관련 위젯
- 좋아요, 검색, 필터링(날짜순), 업로드 기능 구현

### [👩🏻‍💻황혜명](https://github.com/CosmicLatte009)

- 비밀번호 찾기 페이지, 비밀번호 변경 페이지, 톡 관련 페이지
- 버튼 위젯, 유저아바타 위젯, 네비게이션 메뉴 위젯, 라디오 버튼 위젯, 톡 관련 위젯

## 6. 구현 기능 🛠

### 1) 스플래쉬 및 Auth 페이지

| Splash | 로그인 | 비밀번호 찾기 | 비밀번호 변경 |
|:----------:|:----------:|:----------:|:----------:|
| gif 이미지 |  ''  |  '' | '' |
|서비스 접속시 <br>처음에 보이는 화면입니다.| 이메일과 비밀번호로 <br> 로그인 할 수 있습니다.  | 이메일을 입력하면 <br> 해당 이메일로 임시 비밀번호를 받을 수 있습니다. | 토큰이 있을 시 <br> 비밀번호 변경이 가능합니다. |                                                                              |

### 2) 회원가입 페이지 

| 회원가입 | 프로필 작성 | 아바타 설정 상세 | 홈 |
|:----------:|:----------:|:----------:|:----------:|
| gif 이미지 |  ''  | '' | '' |
|이름, 이메일, 휴대전화, 비밀번호를 입력하여 <br>  회원가입할 수 있습니다. | 닉네임, 활동유형과 아바타를 설정하여 프로필 설정할 수 있습니다. | 여러 에셋을 조합하여 아바타를 설정할 수 있습니다. | 로그인 혹은 회원가입 완료시 홈으로 이동합니다. <br> 홈에선 핫한 게시물들과 유저를 볼 수 있습니다. | 

### 3) 톡 페이지  

| 메인 톡 페이지 | 핫한 톡 페이지 | 톡톡톡 페이지 | 상세 톡 페이지 |
|:----------:|:----------:|:----------:|:----------:|
| gif 이미지 |  ''  |  '' | '' |
|핫한 톡과 톡톡톡이 일부 보이며 톡 생성 및 수정, 삭제를 할 수 있습니다. | 핫한 톡 Top5를 보여줍니다. | 전체 톡을 볼 수 있습니다. | 톡의 전체 내용을 볼 수 있으며 댓글을 이어달 수 있습니다. | 

### 5) 캐치업 페이지  

| 페이지명 | '' | '' | '' |
|:----------:|:----------:|:----------:|:----------:|
| gif 이미지 |  ''  |  '' | '' |
| 상세설명 | '' | '' | '' |

### 6) 모각코 페이지  

| 페이지명 | '' | '' | '' |
|:----------:|:----------:|:----------:|:----------:|
| gif 이미지 |  ''  |  '' | '' |
| 상세설명 | '' | '' | '' |

## 7. 핵심 코드

### 1) auth 관련 핵심 코드 

-

```dart

```


### 2) 톡 관련 핵심 코드 

-

```dart

```

### 3) 캐치업 관련 핵심 코드 

-

```dart

```

### 4) 모각코 관련 핵심 코드 

-

```dart

```

## 8. 레슨런 및 회고

### 기술적으로 배운 점 ✅

- Flutter 사용법
- GetX를 이용한 API통신
- GitHub flow 브랜치 전략
- 깃 커밋 메시지 컨벤션


### 팀원들의 회고 ✅

#### [👩🏻‍💻손세은](https://github.com/seeunson)

#### [👩🏻‍💻고은서](https://github.com/Ko-Eunseo)

#### [👩🏻‍💻황혜명](https://github.com/CosmicLatte009) 
