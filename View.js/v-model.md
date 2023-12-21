## v-model 이란

### v-model의 역할
> Form 요소를 개발할 때 input box, select box, textarea 에 양방향(two-way) 데이터 바인딩을 만들고 싶을 때 v-model 디렉티브를 사용할 수 있다. <br>
> v-model은 유저의 입력 이벤트에 따라 데이터를 변경하기 위해 몇 가지 엣지 케이스에 대해 지원을 해준다.

```html, js
<div id="app">
  <input type="text" :value="write" v-model="write" /><br>
  {{write}}
</div>
<script>
new Vue({
    el : "#app",
    data : {
	write : "type area"
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
> 아래와 같이 input에 있는 value 값을 가지고 이벤트를 걸어 핸들링하던 것을 비교해보면 정말 편하다는 것을 알 수 있다.
```html, js
<div id="app">
  <input type="text" :value="write" @keyup="textModifier"/><br>
  {{write}}
</div>
<script>
new Vue({
    el : "#app",
    data : {
	write : "type area"
    },
    methods : {
	textModifier(event) {
	    this.write = event.target.value;
	}
    }
})
</script>
```

![img](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/d3dd40a0-8002-435e-8b1f-395d44dccaa7)
