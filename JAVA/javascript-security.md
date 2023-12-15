##  JavaScript 보안에 대하여

### 웹보안 취약점(OWASP-10 중 상위 5가지)

### SQL Injection
> 서버에 특정 SQL문을 입력하여 데이터베이스에 접근, 회원정보 등을 유출할 수 있는 공격
> ![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/8c218130-8fb5-4bba-889b-61d8c8f4c86e) 

### 크로스사이트 스크립트(XSS, Cross-Site Scripting)
> 악성스크립트가 삽입된 게시글 클릭을 유도하여 사용자의 쿠키 정보, 세션 정보를 탈취하는 방법
> ![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/4ecf718f-8195-47ca-816b-abe7bdde6342)

### 취약한 인증과 세션관리
> 인증과 세션관리와 연관된 어플리케이션 기능이 올바르게 구현되지 않아, <br>
> 공격자로 하여금 다른 사용자로 가장하여 패스워드, 키, 세션, 토큰 체계를 허용하게 된다.

### 크로스 사이트 변조 요청(CSRF, Cross-Site Request Forgery)
> 악성스크립트가 삽입된 게시글을 클릭하게 되면 사용자가 의도하지 않은 행위, <br>
> 게시판이나 웹 메일 등에 스크립트를 삽입하여 비정상적인 페이지가 보이게해 <br>
> 타 사용자의 사용을 방해하거나 쿠키 및 기타 정보를 특정 사이트로 전송하는 등의 공격 방법
