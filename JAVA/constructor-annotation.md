## 생성자 관련 어노테이션
* @NoArgsConstructor : 파라미터가 없는 디폴트 생성자를 생성
* @AllArgsConstructor : 모든 필드 값을 파라미터로 받는 생성자를 생성
* @RequiredArgsConstructor : final이나 @NonNull으로 선언된 필드만을 파라미터로 받는 생성자를 생성


## 롬복이란?
> 여러가지 @어노테이션을 제공하고 컴파일 과정에서 자동으로 메소드를 생성/주입해 주는 라이브러리이다. <br>
> model 클래스나 Entity 같은 도메인 클래스 등에 반복되는 getter, setter, toString 등의 메소드를 자동으로 만들어준다. <br>
> Lombok은 불필요한 코드와 작업을 줄여주는 좋은 라이브러리이지만, <br>
> 한 클래스에 여러 어노테이션을 무분별하게 사용하다보면 혼선이 올 가능성이 높다. <br>
> 무조건 Ctrl + c, Ctrl + v 해서 선언하는 것이 아닌 꼭 필요한 경우에만 사용하는 것이 바람직하다.

## @NoArgsConstructor
> 파라미터가 없는 기본 생성자를 만들어준다. <br>
> 주로 access = AccessLevel.PROTECTED를 설정하여 무분별한 객체 생성을 막는 용도로 쓰인다.
```java
@NoArgsConstructor
public class Customer {
    private Long id;
    private String name;
    private int age;
}
```

NoArgsConstructor 을 사용하면 Java 코드는 아래와 같아진다.

```java
public class Customer {
    private Long id;
    private String name;
    private int age;


    public Customer(){}
}
```


> 즉, @NoArgsConstructor가 붙어있는 객체의 인스턴스를 만들 때, <br>
> 아래처럼 argument를 하나도 넘기지 않으면서 생성자 호출을 할 수 있다.
```java
Customer customer = new Customer();
```

> 항상 초기화가 필요한 final 변수가 존재할 경우, @NoArgsContructor을 사용하면 compile error가 발생된다. <br>
> @NoArgsConstructor(force = true)처럼 force라는 옵션에 true 값을 주면, <br>
> 모든 final fields는 0 / false / null로 초기화되어 사용 가능하다.

## 엔티티는 무조건 NoArgsConstructor를 가져야 합니다.
https://codingwell.tistory.com/181 참조

## @RequiredArgsConstructor
> final 변수 또는 @NotNull으로 선언된 특별한 처리가 필요한 각 field마다 하나의 parameter를 갖는 생성자를 생성해준다. <br>
> 클래스가 의존하는 필드를 간단하게 초기화할 수 있다. <br>
> 생성자의 Parameter의 순서는 클래스 내부에서 선언된 field의 순서로 매칭된다.
```java
@RequiredArgsConstructor
public class Customer {
    private final Long id;
    private final String name;
    private int age;
}
```

RequiredArgsConstructor 을 사용하면 Java 코드는 아래와 같아진다.

```java
public class Customer {
    private final Long id;
    private final String name;
    private int age;


    public Customer(Long id, String name){
        this.id = id;
        this.name = name;
    }
}
```


## @AllArgsConstructor
> 클래스의 모든 필드 값을 파라미터로 받는 생성자를 자동으로 생성한다. <br>
> 이 어노테이션을 사용하면, 클래스의 모든 필드를 한 번에 초기화할 수 있다
```java
@AllArgsConstructor
public class Customer {
    private Long id;
    private String name;
    private int age;
}
```

AllArgsConstructor 을 사용하면 Java 코드는 아래와 같아진다.

```java
public class Customer {
    private Long id;
    private String name;
    private int age;


    public Customer(Long id, String name, int age){
        this.id = id;
        this.name = name;
        this.age = age;
    }
}
```

