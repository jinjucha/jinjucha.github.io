## v-model 이란

### v-model의 역할
> input box, select box, textarea 요소에 쌍방향(two-way) 데이터 바인딩을 만들고 싶을 때 v-model 디렉티브를 사용할 수 있다. <br>
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

쌍방향으로 링크되어 연동되고 있음을 알 수 있다.

```html
<template>
  <h2>Text Input</h2>
  <input v-model="text"> username : {{ text }}
</template>
```




참고자료 : https://engineer-mole.tistory.com/333
