## 롬복이란?
> Lombok은 불필요한 코드와 작업을 줄여주는 좋은 라이브러리이지만, <br>
> 한 클래스에 여러 어노테이션을 무분별하게 사용하다보면 혼선이 올 가능성이 높다. <br>
> 무조건 Ctrl + c, Ctrl + v 해서 선언하는 것이 아닌 꼭 필요한 경우에만 사용하는 것이 바람직하다.

## 생성자 관련 어노테이션
* @NoArgsConstructor : 파라미터가 없는 디폴트 생성자를 생성
* @AllArgsConstructor : 모든 필드 값을 파라미터로 받는 생성자를 생성
* @RequiredArgsConstructor : final이나 @NonNull으로 선언된 필드만을 파라미터로 받는 생성자를 생성

## @NoArgsConstructor
> 파라미터가 없는 디폴트 생성자를 자동으로 생성하기 때문에 클래스에 명시적으로 선언된 생성자가 없더라도 인스턴스를 생성할 수 있다.

```java
@NoArgsConstructor
public class Person {
    private String name;
    private int age;
    // getters and setters
}
```
NoArgsConstructor 을 사용하면 Java 코드는 아래와 같아진다.

```java
public class Person {
    private String name;
    private int age;
    
	public Person(){}
}
```
