## 롬복이란?
> Lombok은 불필요한 코드와 작업을 줄여주는 좋은 라이브러리이지만, <br>
> 한 클래스에 여러 어노테이션을 무분별하게 사용하다보면 혼선이 올 가능성이 높다. <br>
> 무조건 Ctrl + c, Ctrl + v 해서 선언하는 것이 아닌 꼭 필요한 경우에만 사용하는 것이 바람직하다.

## 생성자 관련 어노테이션
> @NoArgsConstructor @RequiredArgsConstructor @AllArgsConstructor
> @NoArgsConstructor : 파라미터가 없는 디폴트 생성자를 생성
> @AllArgsConstructor : 모든 필드 값을 파라미터로 받는 생성자를 생성
> @RequiredArgsConstructor : final이나 @NonNull으로 선언된 필드만을 파라미터로 받는 생성자를 생성

### 생성자의 규칙
* 클래스명과 메서드명이 동일하다.
* 리턴타입을 정의하지 않는다.


생성자는 객체가 생성될 때 호출된다. 여기서 객체는 `new` 라는 키워드로 객체가 만들어질 때이다.

즉, 생성자는 다음과 같이 `new`라는 키워드가 사용될 때 호출된다.
```java
new 클래스명(입력항목)
```

생성자는 메서드와 마찬가지로 입력을 받을 수 있다.  

우리가 만든 생성자는 다음과 같이 입력값으로 문자열을 필요로 하는 생성자다.
```java
public HouseDog(){
    this.setName(name);
}
```

따라서 다음과 같이 `new` 키워드로 객체를 만들때 문자열을 전달해야만 한다.  
```java
HouseDog dog = new HouseDog("happy"); // 생성자 호출 시 String을 전달.
```

아래와 같이 코딩하면 컴파일 오류가 발생할 것 
```java
HouseDog dog = new HouseDog();
```

오류가 발생하는 이유는 객체 생성 방법이 생성자 규칙과 맞지 않기 때문에.  
생성자가 선언된 경우 생성자의 규칙대로만 객체를 생성할 수 있다.  

```java
public class HouseDog extends Dog {
    public HouseDog(String name) {
        this.setName(name);
    } 

    public void sleep() {
        System.out.println(this.name+" zzz in house");
    } 

    public void sleep(int hour) {
        System.out.println(this.name+" zzz in house for " + hour + " hours");
    } 

    public static void main(String[] args) {
        HouseDog dog = new HouseDog("happy");
        System.out.println(dog.name);
    }
}
```
결과는 .. 다음과 같이 출력된다.
```
happy
```
