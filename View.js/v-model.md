## v-model 이란

### v-model의 역할
> input box, select box, textarea 요소에 쌍방향(two-way) 데이터 바인딩을 만들고 싶을 때. v-model 디렉티브를 사용할 수 있다. 

```html
<template>
  <h2>Text Input</h2>
  <input v-model="text"> {{ text }}
</template>
```
