## 빌더 패턴을 사용해야만 하는 이유

```java
@NoArgsConstructor 
@AllArgsConstructor 
public class User { 
    private String name; 
    private int age; 
    private int height; 
    private String job; 
}
```

### 빌더 패턴이란?
> 수제버거를 주문할 때 속 재료는 취향에 맞게 선택해서 변경할 수 있다. <br>
> 어느 사람은 치즈를 추가할 수도 있고 누군가는 토마토를 빼달라고 할 수가 있는데, <br>
> 이처럼 속재료들을 유연하게 받아 다양한 타입의 인스턴스를 생성할 수 있어 <br>
> 클래스의 선택적 매개변수가 많은 상황(점층적 생성자 패턴)에서 사용된다.


### 빌더 패턴의 장점
#### 1. 필요한 데이터만 설정할 수 있다.
> User 객체를 생성해야 하는데 age 라는 파라미터가 필요 없는 상황이라고 가정하면,  
> 우리는 age에 더미를 넣어주거나 age 가 없는 생성자를 새로 만들어 줘야 한다.  
> 이런 작업이 한두번이면 괜찮지만, 반복적인 경우에는 시간 낭비로 이어지게 된다. 하지만 이러한 것을 빌더를 이용하면 동적으로 처리 가능하다.

```java
User user = User.builder()
            .name("jinjucha") 
            .height(160)
            .job("developer").build();
```

그리고 이렇게 필요한 데이터만 설정할 수 있는 빌더의 장점은 테스트용 객체를 생성할 때 용이하게 해주고, 불필요한 코드의 양을 줄이는 등의 이점을 안겨준다.

#### 2. 유연성을 확보할 수 있다.
User에 몸무게를 나타내는 새로운 변수 weight 를 추가했다고 가정하면..  
하지만 이미 다음과 같은 생성자로 객체를 만드는 코드가 있다고 해보자.

```java
// ASIS 
User user = new User("jinjucha", 30, 160, "developer") 
// TOBE 
User user = new User("jinjucha", 30, 160, "developer", 50)
```

그러면 우리는 새롭게 추가되는 변수 때문에 기존의 코드를 수정해야 하는 상황에 직면하게 된다.
빌더 패턴을 이용하면 새로운 변수가 추가되는 등의 상황에 직면하더라도 기존의 코드에 영향을 주지 않을 수 있다.

#### 3. 가독성을 높일 수 있다.
매개변수가 많아질 경우 직관성이 떨어지고, 작업할 때마다 순서를 확인해야 해서 불편하다.  

```java
User user = new User("jinjucha", 30, 160, "developer") 
```

위와 같은 코드를 보면 30과 160이 무엇을 의미하는지 직관적으로 보기가 어렵다.
아래와 같이 빌더 패턴을 이용하면 어떤 값이 설정되는지 쉽게 파악할 수 있다.

```java
User user = User.builder()
            .name("jinjucha") 
            .height(160)
            .job("developer")
.build();
```


#### 4. 변경 가능성을 최소화(불변성)을 확보 할 수 있다. 
많은 개발자들이 수정자(Setter) 패턴을 흔히 사용한다. 하지만 Setter 를 구현하는 것은 불필요하게 확장 가능성을 열어두는 것이다.
Open-Closed 법칙에 위반되고, (개방폐쇄의원칙) 불필요한 코드 리딩을 유발한다. 
그렇기 때문에 클래스 변수를 final로 선언함으로써 불변성을 확보하고 객체의 생성은 빌더에게 맡기는 것이 좋다.

```java
@RequiredArgsConstructor 
@Builder
public class User { 
    private final String name; 
    private final int age;
    private final int height;
    private final String job; 
}
```

다른 사람과 협업을 하거나 변경에 대한 요구 사항이 많은 경우라면 빌더 패턴을 이용해야 하는 이유를 더욱 극명하게 느낄 수 있다.  
