### [Spring Boot] Redis 사용하기
Spring에서는 Spring Data Redis 라이브러리를 이용하여 Redis에 접근할 수 있다.
이때 Redis를 접근할 수 있는 프레임워크로 Lettuce, Jedis가 있다.
Lettuce는 별도의 설정 없이 이용할 수 있고, Jedis는 별도의 의존성 추가가 필요하다.

> 또한 Spring Data Redis로 Redis에 접근하는 방식으로는
> 1. RedisTemplate
> 2. RedisRepository
> 방식이 존재한다.
