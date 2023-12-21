## v-model 이란

### v-model의 역할
> Form 요소를 개발할 때 input box, select box, textarea 에 양방향(two-way) 데이터 바인딩을 만들고 싶을 때 v-model 디렉티브를 사용할 수 있다. <br>

```html, js
<div id="app">
  <input type="text" :value="write" v-model="write" /><br>
  username : {{write}}
</div>
<script>
new Vue({
    el : "#app",
    data : {
	write : "username"
    }
})
</script>
```
![img](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/5fb8caab-dc29-4c9e-b03e-4638372217b9)

### v-model 속성
* (1) input 태그 : value / input
* (2) checkbox 태그 : checked / change
* (3) select 태그 : value / change

### 장점
> @keyup 이벤트를 만들고, 함수를 선언할 필요가 없다. <b>v-model="내가 원하는 Data값"</b> 으로 지정해주면 <br>
> 자동으로 input 태그의 keyup, 입력값과 data.write 값을 서로 바인딩해주게 된다.<br>
> 아래와 같이 input에 있는 value 값을 가지고 이벤트를 걸어 핸들링하던 것을 비교해보면 정말 편하다는 것을 알 수 있다.
```html, js
<div id="app">
  <input type="text" :value="write" @keyup="textModifier"/><br>
  username : {{write}}
</div>
<script>
new Vue({
    el : "#app",
    data : {
	write : "username"
    },
    methods : {
	textModifier(event) {
	    this.write = event.target.value;
	}
    }
})
</script>
```

### 한계
> 자음과 모음의 조합이 필요한 한국어의 경우 input의 입력값을 즉각적으로 표현하지 못하고 문자를 모두 완성한 다음 표현하게 된다. <br>
> 이런 문제를 해결하기 위해서는 v-model 방식이 아니라 기존대로 value 값에 data를 바인딩하고, <br>
> 메서드로 이벤트 처리를 한 뒤, 해당 함수명을 @input 속성에 달아주면 된다.

![img](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/d3dd40a0-8002-435e-8b1f-395d44dccaa7)
