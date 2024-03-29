## Thread 란?
OS에서 크롬 브라우저를 실행하여 사용하면서도 동시에 한글문서도 작성하고, 동영상을 시청하기도 한다. <br>
동시에 여러 프로그램이 실행이 되어도 CPU는 시간을 분할하여 프로세스마다 우선권을 주어 작업을 처리하기에 가능하다. <br>
스레드(thread)란 프로세스 내에서 실제로 작업을 수행하는 주체를 의미한다. <br>
모든 프로세스에는 한 개 이상의 스레드가 존재하여 작업을 수행한다. <br>
또한, 두 개 이상의 스레드를 가지는 프로세스를 멀티스레드 프로세스라고 한다.

* process = 운영체제에서 실행되는 하나의 프로그램 단위이다 (ex. 크롬, 한글, 엑셀)
* thread = 프로세스내에서 실행되는 세부 작업단위

## 장점
> 1. 메모리 공유로 인한 시스템 자원 소모가 줄어 듭니다.
> 2. 동시에 두가지 이상의 활동을 하는 것이 가능해집니다.

## 단점
> 1. 서로 자원을 소모하다가 충돌이 일어날 가능성이 존재합니다.
> 2. 코딩이 난해해져 버그생성활률이 높아집니다.

## Thread의 생성주기
![image](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/af77a605-8cec-4262-ae12-c53af0ed34e9)
* Runnable 상태 : Thrade가 실행되기 위한 준비 단계
* Running 상태 : 스케줄러에 의해 선택된 Thread가 실행되는 단계
* Blocked 상태 : Thread가 작업을 완수하지 못하고 잠시 작업을 멈추는 단계

## Thread의 생성과 실행
자바에서 스레드를 생성하는 방법에는 다음과 같이 두 가지 방법이 있습니다.  
1. Runnable 인터페이스를 구현하는 방법 (더 많이 사용!)
2. Thread 클래스를 상속받는 방법

두 방법 모두 스레드를 통해 작업하고 싶은 내용을 `run()` 메소드에 작성하면 됩니다.

```java
class ThreadWithClass extends Thread {
    public void run(){
        for (int i = 0; i < 5; i++){
            System.out.println(getName());
            try{
                Thread.sleep(10);
            } catch(InterruptedException e){
                e.printStackTrace();
            }
        }
    }
}
class ThreadWithRunnable implements Runnable {
    public void run() {
        for (int i = 0; i < 5; i++) {
            System.out.println(Thread.currentThread().getName());
            try {
                Thread.sleep(10);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
public class Thread01 {
    public static void main(String[] args){
        ThreadWithClass thread1 = new ThreadWithClass();       // Thread 클래스를 상속받는 방법
        Thread thread2 = new Thread(new ThreadWithRunnable()); // Runnable 인터페이스를 구현하는 방법
        // Thread 클래스는 start 실행 시 run 메소드가 수행되도록 내부적으로 동작한다.
        thread1.start(); // 스레드의 실행
        thread2.start(); // 스레드의 실행
    
    }
}
```

실행결과
```
Thread-0
Thread-1
Thread-0
Thread-1
Thread-0
Thread-1
Thread-0
Thread-1
Thread-0
Thread-1
```

## Thread의 우선순위
자바에서 각 스레드는 우선순위(priority)에 관한 자신만의 필드를 가지고 있습니다.  
이러한 우선순위에 따라 특정 스레드가 더 많은 시간 동안 작업을 할 수 있도록 설정할 수 있습니다.  

```java
static int MAX_PRIORITY: 스레드가 가질 수 있는 최대 우선순위를 명시함.
static int MIN_PRIORITY: 스레드가 가질 수 있는 최소 우선순위를 명시함.
static int NORM_PRIORITY: 스레드가 생성될 때 가지는 기본 우선순위를 명시함.
```
getPriority()와 setPriority() 메소드를 통해 스레드의 우선순위를 반환하거나 변경할 수 있습니다.  
스레드의 우선순위가 가질 수 있는 범위는 1부터 10까지이며, 숫자가 높을수록 우선순위 또한 높아집니다.

하지만 스레드의 우선순위는 비례적인 절댓값이 아닌 어디까지나 상대적인 값일 뿐입니다.  
**우선순위가 10인 스레드가 우선순위가 1인 스레드보다 10배 더 빨리 수행되는 것이 아닙니다.**  
단지 우선순위가 10인 스레드는 우선순위가 1인 스레드보다 좀 더 많이 실행 큐에 포함되어, 좀 더 많은 작업 시간을 할당받을 뿐입니다.

## 상속 시 Runnable 인터페이스 사용하는 이유
Thread를 상속하여 구현하면 다른 클래스를 상속할 수 없으나,<br>
보통은 Runnable 인터페이스를 구현할 경우 다른 클래스를 상속받아 사용할 수 있다.

자바의 특징 중 하나인 '다중상속 불가능' 이유로 Runnable 인터페이스로 구현한다면 <br>
다른 클래스를 상속받아서 재사용성을 높일 수 있다. 즉 객체지향적이다.


## 실무 사용 느낀점
실무에서 Thread의 필요성을 느끼기 전까지 동시에 꼭 여러 작업을 처리해야 할 필요가 있나? 
의문이 있었으나 서비스 및 솔루션 개발을 하면서 하나의 작업이 완료될 때까지 기다렸다가 
다음 작업이 시작하는 것이 효율성이 떨어진다는 사실을 알게 되었다.

