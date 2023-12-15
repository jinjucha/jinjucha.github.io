## SQL 쿼리 튜닝 방법

### 인덱스 사용하기
> 인덱스를 사용하면 데이터베이스가 특정 열을 쉽게 찾을 수 있어 대용량 데이터베이스에서 검색속도를 향상시키는데 유용하다. <br>
> 따라서 적절한 인덱스를 생성해 쿼리의 실행 속도를 높이는 것이 중요하다.<br>

#### 인덱스를 사용하면 좋은 경우
* WHERE 절에 사용되는 컬럼
* 자주 조회되는 컬럼
  
다음은 적절한 인덱스 사용 예시입니다.
SELECT *
FROM orders
WHERE order_date > '2021-01-01'
ORDER BY order_id


이 쿼리에서는 WHERE 절에서 order_date 열에 대한 조건을 사용하고, ORDER BY 절에서 order_id 열을 사용합니다. 따라서, order_date와 order_id 열에 대한 인덱스를 만들어 쿼리의 실행 속도를 향상시키는 것이 좋습니다.
> CREATE INDEX idx_order_date ON orders (order_date);
> CREATE INDEX idx_order_id ON orders (order_id);
