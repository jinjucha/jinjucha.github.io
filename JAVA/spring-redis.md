### Redis 장점
> Redis는 메모리 기반의 저장소로 데이터에 접근하는 속도가 빠르다. 하드웨어 성능차이를 극복할 수 있음 <br>
> String, Hash, List, Set, Sorted Set 등의 데이터 구조 활용 가능하다. 유연성 제공

### Redis 목적
> cashing : 실제 원본에 가지 않아도 빠르게 접근할 수 있도록 임시 저장하는 기능 <br>
> 미리 계산된 데이터나 자주 사용되는 데이터를 임시적으로 저장함으로써, 데이터에 빠르게 접근할 수 있다.

### Redis 사용하기
Spring에서는 Spring Data Redis 라이브러리를 이용하여 Redis에 접근할 수 있다. <br>
이때 Redis를 접근할 수 있는 프레임워크로 Lettuce, Jedis가 있다. <br>
Lettuce는 별도의 설정 없이 이용할 수 있고, Jedis는 별도의 의존성 추가가 필요하다.

> 또한 Spring Data Redis로 Redis에 접근하는 방식으로는
> 1. RedisTemplate
> 2. RedisRepository
> 방식이 존재한다.

Lettuce와 RedisTemplate을 이용하여 Redis를 Spring boot local 환경에서 사용해보자.

* Redis 설치 이후 진행과정입니다.

### 1. Spring Data Redis 의존성 추가
>  Redis에 접근하기 위해서 Redis 저장소와 연결
```java
//Gradle 의존성 추가
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-data-redis' // spring에서 redis에 대한 의존성
    implementation 'org.springframework.session:spring-session-data-redis' // spring에서 redis를 session storage로 사용하기 위한 의존성
}
```
```java
//Maven 의존성 추가
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
    <version>2.4.10</version>
</dependency>
```

### 2. RedisTemplate 설정
> RedisTemplate, StringRedisTemplate bean 생성
```java
//RedisConfig 클래스 생성
@Configuration
public class RedisConfig {
    @Value("${spring.redis.cluster.nodes}")
    private List<String> clusterNodes;

    @Value("${spring.redis.password}")
    private String password;

    @Bean
    public RedisConnectionFactory redisConnectionFactory() {
        RedisClusterConfiguration redisClusterConfiguration = new RedisClusterConfiguration(clusterNodes);
        redisClusterConfiguration.setPassword(password);
        return new LettuceConnectionFactory(redisClusterConfiguration);
    }

    @Bean
    public RedisTemplate<String, Object> redisTemplate(){
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(redisConnectionFactory());

        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setValueSerializer(new StringRedisSerializer());
        return redisTemplate;
    }

    @Bean
    public StringRedisTemplate stringRedisTemplate(){
        StringRedisTemplate stringRedisTemplate = new StringRedisTemplate();
        stringRedisTemplate.setKeySerializer(new StringRedisSerializer());
        stringRedisTemplate.setValueSerializer(new StringRedisSerializer());
        stringRedisTemplate.setConnectionFactory(redisConnectionFactory());

        return stringRedisTemplate;
    }
}
```
> RedisConnectionFactory 인터페이스를 통해 LettuceConnectionFactory를 생성하여 반환합니다.


| 변수 | 기본값 | 설명 |
| ------------ | ------------- | ------------- |
| spring.redis.database | 0 | 커넥션 팩토리에 사용되는 데이터베이스 인덱스 |
| spring.redis.host | localhost | 레디스 서버 호스트 |
| spring.redis.password |  | 레디스 서버 로그인 패스워드 |
| spring.redis.pool.max-active | 8 | pool에 할당될 수 있는 커넥션 최대수 (음수로 하면 무제한) |
| spring.redis.pool.max-idle | 8 | pool의 "idle" 커넥션 최대수 (음수로 하면 무제한) |
| spring.redis.pool.max-wait | -1 | pool이 바닥났을 때 예외 발생 전, 커넥션 할당 차단 최대 시간 <br> (단위 밀리세컨드, 음수는 무제한 차단) |
| spring.redis.pool.min-idle | 0 | 풀에서 관리하는 idle 커넥션의 쵀소수 대상 (양수일 때만 유효) |
| spring.redis.port | 6379 | 레디스 서버 포트 |
| spring.redis.sentinel.master |  | 레디스 서버 이름 |
| spring.redis.sentinel.nodes |  | 호스트: 포트 쌍 목록 (콤마로 구분) |
| spring.redis.timeout | 0 | 커넥션 타임아웃 (단위 밀리세컨드) |


### 3. Redis Test
로그인 계정 정보를 1분동안 Redis 캐시에 저장하는 비즈니스 로직을 생성해보자.
* MemberDto 클래스: name, price, quantity를 담는 데이터 클래스를 생성한다. Redis는 바이트코드로 저장되기 때문에 Serializable을 구현해줘야 한다.
* LoginDao 클래스: 장바구니를 담는 Repository 클래스를 생성한다. RedisConfig에 빈을 등록한 RedisTemplate을 사용하여 캐시에 저장하고 조회하는 로직을 만든다.
*CartController 클래스: 비즈니스 로직을 실행하는 API(GET, POST "/{id}/cart")를 생성한다.


```java
    @Autowired
    private StringRedisTemplate redisTemplate;
    private final String KEY="keyword";

    @org.junit.Test
    public void 검색어_저장(){
        //given
        String keyword="한남동 맛집";
        String keyword2="서촌 맛집";

        //when
        redisTemplate.opsForZSet().add(KEY,keyword,1);
        redisTemplate.opsForZSet().incrementScore(KEY,keyword,1);
        redisTemplate.opsForZSet().incrementScore(KEY,keyword,1);

        redisTemplate.opsForZSet().add(KEY,keyword2,1);

        //then
        System.out.println(redisTemplate.opsForZSet().popMax(KEY));
        System.out.println(redisTemplate.opsForZSet().popMin(KEY));

    }
```

> "한남동 맛집"은 count가 3회 되어야 하고 <br>
> "서촌 맛집"은 count가 1회 수행되어야 한다.


