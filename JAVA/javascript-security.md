##  JavaScript 보안에 대하여

## 웹보안 취약점(OWASP-10 중 상위 5가지)

### SQL Injection
> ![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/8c218130-8fb5-4bba-889b-61d8c8f4c86e) <br>
> 서버에 특정 SQL문을 입력하여 데이터베이스에 접근, 회원정보 등을 유출할 수 있는 공격

### 크로스사이트 스크립트(XSS, Cross-Site Scripting)
> ![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/4ecf718f-8195-47ca-816b-abe7bdde6342) <br>
> 악성 스크립트가 삽입된 게시글 클릭을 유도하여 사용자의 쿠키 정보, 세션 정보를 탈취하는 방법

### 취약한 인증과 세션관리
> 인증과 세션관리와 연관된 어플리케이션 기능이 올바르게 구현되지 않아, <br>
> 공격자로 하여금 다른 사용자로 가장하여 패스워드, 키, 세션, 토큰 체계를 허용하게 된다.

### 크로스 사이트 변조 요청(CSRF, Cross-Site Request Forgery)
> 악성스크립트가 삽입된 게시글을 클릭하게 되면 사용자가 의도하지 않은 행위, <br>
> 게시판이나 웹 메일 등에 스크립트를 삽입하여 비정상적인 페이지가 보이게해 <br>
> 타 사용자의 사용을 방해하거나 쿠키 및 기타 정보를 특정 사이트로 전송하는 등의 공격 방법

### XSS 공격 취약점 보완코드
> 게시판 글작성 페이지에서는 제목란이나 내용란, <input/> 태그 안에 텍스트를 입력할 수 있는 곳에서 <br>
> 스크립트 코드를 작성하여 XSS 공격을 시도할 수 있다.<br>
> 스크립트 입력 구문 : <audio oncanplay=prompt('XSS')><source src="https://공격자.서버/test.wav" type="audio/wav"></audio> <br>
> HTML 코드 또는 쿼리문으로 인식되는 문자를 일반 문자열로 치환해서 방어한다.
```java
public static String checkXss(String input) {
    if (input == null || input.trim().isEmpty()) {
        return "";
    }
    String output = input;
    output = output.replaceAll("<", "&lt;");
    output = output.replaceAll(">", "&gt;");
    output = output.replaceAll("script", "");
    output = output.replaceAll("union", "");
    output = output.replaceAll("update", "");
    output = output.replaceAll("delete", "");
    output = output.replaceAll("select", "");
    output = output.replaceAll("drop", "");
    output = output.replaceAll("truncate", "");
    output = output.replaceAll("\\(", "&#40;");
    output = output.replaceAll("\\)", "&#41;");
    output = output.replaceAll("'", "&#39;");
    output = output.replaceAll("eval\\((.*)\\)", "");
    output = output.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
    return output;
}
```

### 허가되지 않은 접근 보완코드
> 특정 권한을 가진 사용자만 글을 작성할 수 있도록 제한하는 페이지에서 JSP의 JavaScript 영역에서만 <br>
> 코드를 검증하면 클라이언트 요청 파라미터에서 데이터 조작이 가능해 권한을 부여하지 않은 사용자도 접근 가능하다. <br>
> 서버에서 권한 체크를 하고 글쓰기 버튼이 포함된 html 코드를 리턴 시 반환하도록 한다.
```java

```
