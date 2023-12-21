## Computed 이란

### Computed의 역할
> HTML의 DOM 구조가 생성되기 전에 computed 객체 내부에 있는 값들을 계산해 캐싱(저장)하고, <br>
> 내부의 data값이 변경되면 추척하여 다시 계산해준다.

{{ message.split('').reverse().join('') }}
