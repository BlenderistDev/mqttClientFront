<template>
  <nuxt-link :class="this.class" :to="this.link"><h2>{{ this.text }}</h2></nuxt-link>
</template>

<script>
/**
 * Компонент для ссылки в верхнем меню
 */
export default {
  props: {
    text: String,
    link: String
  },
  computed: {
    // класс для ссылки
    class: function () {
      let sClass = "nav-link nav-item flex-fill text-center";
      // если текущий путь совпадает с ссылкой, то делаем ссылку активной
      if (this.$nuxt.$route.path === this.link) {
        return sClass += " active";
      } 
      return sClass;
    }
  }
}
</script>