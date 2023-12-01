### [Spring Boot] Redis 사용하기
Spring에서는 Spring Data Redis 라이브러리를 이용하여 Redis에 접근할 수 있다.
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
