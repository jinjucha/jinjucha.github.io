## SQL 쿼리 튜닝 방법

### 테이블에 인덱스 사용하기
> 인덱스를 사용하면 데이터베이스가 특정 열을 쉽게 찾을 수 있어 대용량 데이터베이스에서 검색속도를 향상시킬 수 있다. <br>
> 따라서 적절한 인덱스를 생성해 쿼리의 실행 속도를 높이는 것이 중요하다.<br>

#### 인덱스를 사용하면 좋은 경우
* WHERE 절에 사용되는 컬럼
* 자주 SELECT 되는 컬럼
  
다음은 적절한 인덱스 사용 예시입니다.
```query
SELECT *
FROM orders
WHERE order_date > '2021-01-01'
ORDER BY order_id
```
이 쿼리에서는 WHERE 절에서 order_date 열에 대한 조건을 사용하고, ORDER BY 절에서 order_id 열을 사용한다. <br>
따라서 order_date와 order_id 열에 대한 인덱스를 만들어 쿼리의 실행 속도를 향상시키는 것이 좋다.

```query
CREATE INDEX idx_order_date ON orders (order_date);
CREATE INDEX idx_order_id ON orders (order_id);
```

### 적절한 JOIN 사용하기
> INNER JOIN은 모든 행이 일치하는 경우에만 검색하므로 쿼리 성능이 뛰어나지만, <br>
> OUTER JOIN은 일치하지 않는 행도 검색할 수 있어 성능이 떨어질 수 있다. <br>
> 또한, JOIN의 순서를 최적화하여 성능을 높이는 것도 중요하다.

### 서브쿼리 최소화하기
> 서브쿼리는 복잡한 쿼리 조건을 작성할 때 유용하지만, 성능 저하의 원인이 될 수 있다. <br>
> 서브쿼리 대신 JOIN, UNION, EXISTS 등 방법을 사용하여 쿼리를 작성하는 것이 좋다.
> 사용 시 서브쿼리의 결과를 캐시하여 재사용하는 것이 바람직하다. 

```query
SELECT *
FROM orders
WHERE customer_id IN (
  SELECT customer_id
  FROM customers
  WHERE gender = 'F'
)
```
위 쿼리에서는 성별이 여자인 고객이 주문한 모든 주문을 가져오는데 서브쿼리가 사용되었다.

```query
SELECT *
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
WHERE customers.gender = 'F'
```
굳이 서브쿼리를 사용하지 않고도 JOIN을 사용하여 같은 결과를 얻을 수 있다.

### 쿼리 실행 계획 확인하기
> 쿼리 실행 계획은 데이터베이스가 쿼리를 실행할 때 어떤 방식으로 데이터를 검색하는지 알려주므로<br>
> 쿼리가 어떤 인덱스를 사용하는지, 어떤 테이블을 스캔하는지 정보를 확인하여 쿼리의 성능을 분석 후 개선하는 것이 중요하다.
 
### 쿼리 최적화
```query
//원본 쿼리
SELECT *
FROM orders
WHERE order_date > '2021-01-01'
ORDER BY order_date DESC
```

```query
//인덱스를 사용한 최적화된 쿼리
SELECT *
FROM orders
WHERE order_date > '2021-01-01'
ORDER BY order_id DESC
```

위 쿼리에서는 쿼리 성능을 향상시키기 위해 order_date 열에 대한 인덱스를 만들었다.
하지만 ORDER BY절에서는 인덱스를 사용하지 못하기 때문에 order_id 열에 대한 인덱스를 추가하여
ORDER BY 절에서 인덱스를 사용하도록 변경해서 쿼리 실행 속도를 개선하였다.

### 총 정리
> 테이블 주 사용 컬럼에는 인덱스를 생성하고, 서브 쿼리를 남용하지 않아야 한다. <br>
> 가능하다면 조인 조건을 이용하자. 
