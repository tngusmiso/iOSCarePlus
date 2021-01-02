# iOSCarePlus
🎮 🛍 게임 스토어 앱 만들어보기( with: [Jercy](https://github.com/JeaSungLEE/iOSCarePlus) )

### 🍎 Used APIs
* https://ec.nintendo.com/api/KR/ko/search/new?count=30&offset=0

### 🍎 Used Libraries
* [Alamofire](https://github.com/Alamofire/Alamofire) : API 통신
* [Kingfisher](https://github.com/onevcat/Kingfisher) : 이미지 캐싱

---

## 🌸 .gitignore
* `.gitignore` 파일에 명시한 파일은 **git 변경 내역 추적에서 제외**한다.
* 협업 시 충돌을 방지하거나 불필요한 파일을 올리지 않을 수 있다.
* 주로 백업 파일, 로그 파일, 로컬 설정 파일 등이 포함된다.
* **XCode Swift 프로젝트에서는?** => *DS_Store, XCode Patch 관련, Dependency Manager 관련 등*
* `.gitignore` 파일을 추가하기 전에 commit을 했다면?
    ```
    git rm -r --cached [파일명]
    ```

### references
* https://github.com/github/gitignore : github 공식 레포
* https://gitignore.io : 간단하게 gitignore 파일을 만들어주는 사이트
---

## 🌸 SwiftLint
* **Swift 스타일 및 규칙을 적용하는 도구**
* 규칙에 어긋나는 코드 줄에는 Warning 또는 Error 발생

### SwiftLint 적용하기
* XCode File Navigator에서 `프로젝트 폴더` 클릭
* 기본 App `Target` 클릭
* `Build Phases`로 이동
* `+` 버튼 클릭
* `New Run Script Phases` 클릭하여 아래의 코드 추가
    ```
    if which swiftlint >/dev/null; then
        swiftlint
    else
        echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    fi
    ```
* 방금 추가한 스텝의 위치를 `Compile Sources` 위로 이동한다.

### references
* https://github.com/realm/SwiftLint

---

## 🌸 SPM (Swift Package Manager)

### 의존성 관리 도구 Dependency Manager
라이브러리의 다운로드와 버전 및 의존성을 쉽게 관리해주는 도구
* **SPM (Swift Package Manager)**
    * **Apple 공식!** 앞으로 대부분 상용될 것이다.
    * 비교적 최근에 출시되어서 아직 지원하지 않는 라이브러리들이 있다.
* **CocoaPods**
    * 대중적이고 사용하기 편리하다. 대부분의 라이브러리를 지원하고 있다.
    * Workspace 환경에서 작업해야하며, 빌드 시간이 오래걸린다.
* **Carthage**
    * 잘 사용하지 않을 것이다...

### SPM 사용하기
* `File` > `Swift Packages` > `Add Package Dependency...`
* 원하는 라이브러리의 `repository 주소` 입력
* `version` / `branch` / `commit` 으로 선택 가능
* `package product` 선택
* XCode File Navigator에 `Swift Package Dependencies`를 보면 **라이브러리가 추가**된 것을 확인할 수 있다.

### references
* https://swift.org/package-manager/

---

## 🌸 CocoaPods
### 설치
```
sudo gem install cocoapods
````

### 사용 방법
* `pod init`  
    > Podfile이 생성된다.
    ```
    # Uncomment the next line to define a global platform for your project
    # platform :ios, '9.0'
    
    target 'test' do
        # Comment the next line if you don't want to use dynamic frameworks
        use_frameworks!

        # Pods for test

    end

    ```
    > 생성된 `Podfile`에 원하는 라이브러리 의존성을 추가한다.

    > line 2 : 플랫폼 버전 명시  
    > line 4 : 'test' -> 타겟 이름으로 설정  
    > line 5~9 : 라이브러리 의존성 추가

* `pod install`
    > 프로젝트에 `Podfile`에 적힌 라이브러리를 설치한다.

    > pod 라이브러리 설치 이후부터는 `.xcodeproj` 파일이 아닌, `.workspace` 확장자 파일에서 작업해야 한다.
* `pod update`
    > pod 라이브러리가 한 번 설치된 이후에는 `podfile.lock` 파일이 생성된다.

    > `pod update` 명령어는 이 `podfile.lock` 파일을 보고 라이브러리를 업데이트 한다.
* `pod repo`
    > 모든 프레임워크의 정보가 들어있다.
    
    > 최신버전 라이브러리일 경우, repo를 업데이트 하지 않으면 라이브러리를 못 받아오는 경우도 있다.

### references
* https://cocoapods.org/

---

## 🌸 Alamofire
* **비연결 HTTP 기반의 네트워크 통신 라이브러리**
* (Swift 자체 라이브러리 URLSession보다 사용법이 간단함)
* SPM, Carthage 또는 CocoaPods을 이용하여 설치
* `import Alamofire`

### request
* **AF.request(**_: method: parameters: encoder: headers: interceptor:**)**
* 사용 예시
    ```
    AF.request(url).responseJSON { response in
        guard let data: Data = response.data else { return }
        let decoder: JSONDecoder = JSONDecoder()
        
        // 디코딩 및 데이터 처리
        // ...
    }
    ```
### http method 종류
* .get
* .post
* .put
* .delete 
* 등...

### references
* https://github.com/Alamofire/Alamofire

---

## 🌸 Kingfisher
* 이미지 캐싱 라이브러리

### 이미지 캐싱이란?
* 네트워크 통신 시 이미지를 가져오는 것은 빈번하고, 상대적으로 비용이 많이 든다.
* 따라서 이미지를 한번 받아올 때 캐시 메모리에 저장해두면 자동으로 캐시에서 삭제되기 전까지는 빠르게 처리할 수 있게 된다.

### 사용 방법
```
let url: URL? = URL(string: "https://example.com/image.png")
imageView.kf.setImage(with: url)
````

### references
https://github.com/onevcat/Kingfisher