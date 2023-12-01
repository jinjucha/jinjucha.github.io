### Redis란?

Redis는 `모든 데이터를 메모리에 저장하고 조회`합니다. 즉, `인메모리 데이터베이스` 입니다. <br>
다른 인메모리 디비들과의 가장 큰 차이점은 `레디스의 다양한 자료구조` 입니다.

![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/ead75fdf-4694-4ed3-967a-327b62ea7c21)

이렇게 다양한 자료구조를 지원하게 되면 `개발의 편의성이 좋아진다`는 장점이 있습니다. <br>

예를들어, 어떤 데이터를 정렬을 해야하는 상황이 있을 때, DBMS를 이용한다면 DB에 데이터를 저장하고,<br>
저장된 데이터를 정렬하여 다시 읽어오는 과정은 디스크에 직접 접근을 해야하기 때문에 시간이 더 걸린다는 단점이 있습니다. <br>
하지만 이 때 `In-Memory` 데이터베이스인 `Redis`를 이용하고 <br>
레디스에서 제공하는 `Sorted-Set`이라는 자료구조를 사용하면 더 빠르고 간단하게 데이터를 정렬할 수 있습니다.
![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/e0aa73ed-d2c8-47f9-94ee-50c5ece08814)

NoSQL로서 Key-Value 타입의 저장소인 `레디스(Redis, Remote Dictionary Server)`의 주요 특징은 아래와 같습니다.

- `영속성을 지원하는 인메모리 데이터 저장소`
- `읽기 성능 증대를 위한 서버 측 복제를 지원`
- `쓰기 성능 증대를 위한 클라이언트 측 샤딩(Sharding) 지원`
- `다양한 서비스에서 사용되며 검증된 기술`
- `문자열, 리스트, 해시, 셋, 정렬된 셋과 같은 다양한 데이터형을 지원. 메모리 저장소임에도 불구하고 많은 데이터형을 지원하므로 다양한 기능을 구현`

그래서 최종적으로 Redis를 한 문장으로 정의하면 아래와 같습니다.

> 레디스는 고성능 키-값 저장소로서 문자열, 리스트, 해시, 셋, 정렬된 셋 형식의 데이터를 지원하는 NoSQL이다.
> 

# `Redis 영속성`

레디스는 지속성을 보장하기 위해 데이터를 `DISK`에 저장할 수 있습니다. 서버가 내려가더라도 `DISK`에 저장된 데이터를 읽어서 메모리에 로딩을 합니다.

데이터를 `DISK`에 저장하는 방식은 크게 두 가지 방식이 있습니다.

- RDB(Snapshotting) 방식
    - 순간적으로 메모리에 있는 내용을 DISK에 전체를 옮겨 담는 방식
- AOF (Append On File) 방식
    - Redis의 모든 write/update 연산 자체를 모두 log 파일에 기록하는 형태

# `Redis 간단한 실습`

```
brewinstallredis (Mac Redis 설치)
redis-server (Redis Server 실행)
redis-cli (Redis Client 접속)

brewservicesstartredis   (Redis 서비스 실행)
brewservicesstopredis    (Redis 서비스 중지)
brewservicesrestartredis (Redis 서비스 재시작)

flushAll (Redis 모든 Key 삭제)
```



![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/9ab89883-8bc1-4f7f-b320-8847abe33588)

- set key value 의 문법으로 작성합니다. ex) set key "hello" (key-value를 저장할 때 사용)
- get key(key에 저장된 value를 꺼낼 때 사용)

![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/a5b13aa5-e10c-4466-be51-983456bcaf8d)

- append는 key1 value 뒤에 문자열을 추가할 수 있게 해줍니다.

![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/f31e9406-bfc9-40fa-a96e-03d1095f1e90)

- sadd 명령어를 통해서 Set 자료구조를 사용합니다.
- smembers 명령어를 통해서 Set 자료구조를 출력합니다. (보면 순서가 뒤죽박죽으로 나오는 것을 알 수 있습니다.)

# `sortedSet 명령어`

![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/b2ece67c-bff4-4690-8d86-67858ef25b23)

- `zadd` 명령어를 통해서 `가중치-값`으로 지정합니다.
- `zrange` 명령어를 통해서 출력 범위를 지정할 수 있습니다. (-1 이면 뒤에서 부터 시작)

# `HashMap 명령어`

![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/d359d715-7818-410d-a907-0b0696cc3645)

- 흔히 많이 사용하는 Map의 구조와 똑같습니다.

이와 같이 간단하게 Redis란 무엇이고 Redis에서 지원하는 자료구조에 대해서 간단하게 알아보았습니다.
