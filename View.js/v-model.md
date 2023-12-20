## v-model 이란

### v-model의 역할
> Form 요소를 개발할 때 input box, select box, textarea 에 양방향(two-way) 데이터 바인딩을 만들고 싶을 때 v-model 디렉티브를 사용할 수 있다. <br>
> v-model은 유저의 입력 이벤트에 따라 데이터를 변경하기 위해 몇 가지 엣지 케이스에 대해 지원을 해준다.

```js
<script setup>
  import { ref } from 'vue'
  const text = ref('username')
</script>
```
```html
<template>
  <h2>Text Input</h2>
  <input v-model="text"> username : {{ text }}
</template>
```
![img](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/5fb8caab-dc29-4c9e-b03e-4638372217b9)

### v-model 속성
* (1) input 태그 : value / input
* (2) checkbox 태그 : checked / change
* (3) select 태그 : value / change

### 장점
> 기존 Jquery, React 에서 input에 있는 value 값을 핸들링하던 것을 비교해보면 정말 편하다는 것을 알 수 있다.

### 동작 원리
> v-model 속성은 v-bind와 v-on의 기능의 조합으로 동작한다.
> 매번 사용자가 일일이 v-bind와 v-on 속성을 다 지정해 주지 않아도 된다.

```html
<template>
  <h2>v-model</h2>
  <input v-model="text"> 
  <h2>value-input</h2>
  <input :value="text" @input="text = $event.target.value" />
	<p>username : {{ text }}</p>
</template>
```
![img](https://github.com/jinjucha/jinjucha.github.io/assets/46393932/d3dd40a0-8002-435e-8b1f-395d44dccaa7)
