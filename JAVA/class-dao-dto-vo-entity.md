## DAO란?
> Data Access Object의 약자로, Database에 접근하는 역할을 수행하는 객체 <br>
> 프로젝트의 서비스 모델에 해당하는 부분과 데이터베이스를 연결한다. <br>
> 데이터에 대한 CRUD 기능을 전담하는 오브젝트, 일반적으로 Controller - Service - ServiceImpl - DAO 구조이다.

## DAO 사용 이유
* 효율적인 커넥션 관리와 보안성
* DAO는 비즈니스 로직을 분리하여 도메인 로직으로부터 DB와 관련한 메커니즘을 숨기기 위해 사용

```java
public class TestDao {
public void add(TestDto dto) throws ClassNotFoundException, SQLException {
		private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/dao_Db";
    private static final String USER = "root";
    private static final String PASSWORD = "1234";   
		
		String sql = "SELECT * FROM vouchers";

        try {
            con = DriverManager.getConnection(URL, USER, PASSWORD);
            stmt = con.createStatement();
            res = stmt.executeQuery(sql);
            while (res.next()) {
                System.out.println(res.getString("id") + " ");
                System.out.println(res.getString("value") + " ");
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    preparedStatement.setString(1, dto.getName());
    preparedStatement.setInt(2, dto.getValue());
    preparedStatement.setString(3, dto.getData());
    preparedStatement.executeUpdate();
    preparedStatement.close();

    connection.close();

	}
}
```

![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/7aad4498-bd1d-4c78-830b-1a14495273bd)

## Repository
> JPA와 같은 ORM을 사용하게 되면 객체 단위로 테이블을 관리 (Entity) <br>
> JPA를 사용할 때 DAO의 역할을 대신한다. <br>

## DTO란?
> Data Transfer Object의 약자로 각 계층간 데이터를 교환하기 위한 객체 <br>
> 어떠한 비즈니스 로직도 가지지 않는 순수한 데이터 객체이다. (getter & setter 만 가진 클래스) <br>
> 데이터를 주고 받을 때 사용할 수 있고 주로 View와 Controller 사이에서 이용

```java
// 가변 객체 DTO
// 기본생성자로 생성 후 값을 유동적으로 변경 
public class DtoEx {
    private String name;
    private int age;

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAge(int age) {
        this.age = age;
    }
}
```

```java
// 불변 객체 DTO
// 생성시 지정했던 값이 변하지 않고 getter() 메소드만 사용 가능
public class DtoEx {
    private final String name;
    private final int age;

    public DtoEx(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }
}
```

## VO란?
> Value Object의 약자로 DTO와 동일하게 각 계층간 데이터를 교환하기 위한 객체 <br>
> 어떠한 비즈니스 로직도 가지지 않는 순수한 데이터 객체이다. (getter 만 가진 클래스)<br>
> getter만 사용하기 때문에 불변의 성격을 띄는 클래스이다.

## 요약
* DAO :  Database에 접근하는 역할을 하는 객체.
* DTO : 데이터를 전달하기 위한 객체
* VO : 값 자체를 표현하는 객체.
* Entity : 실제 DB 테이블과 매핑이 되는 클래스.


## Entity란?
> 실제 DB테이블과 1:1로 매핑이 되는 클래스 <br>
> Entity를 데이터를 전달하는 클래스로 사용하면 안된다 <br>
> Entity를 기준으로 테이블이 형성되고, 컬럼이 변경되므로 테이블 내에 존재하는 컬럼만을 속성(필드)으로 가져야 한다. <br>
> Entity는 비즈니스 로직을 포함할 수도, setter() 메소드를 포함할 수도 있다.

```java
public class EntityEx {
    private final Long id;
    private final String name;
    private final int value;

    public EntityEx(Long id, String name, int value) {
        this.id = id;
        this.name = name;
        this.value = value;
    }
}
```
