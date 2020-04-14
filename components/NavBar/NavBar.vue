<template>
  <ul class="nav nav-tabs flex-row bg-light">
    <NavBarLink v-for="(oLink, index) in aLinks"
        v-bind:key="index" 
        v-bind:link="oLink.link"
        v-bind:text="oLink.text"
    />
  </ul>
</template>

<script>
import NavBarLink from '~/components/NavBar/NavBarLink.vue'
/**
 * Компонент для отображения верхнего меню
 */
export default {
  components: {
    NavBarLink
  },
  data: function() {
    return {
      // Список пунктов меню
      aLinks: [
        {
          text: "Главная",
          link: "/",
        },
        {
          text: "Отправители",
          link: "/senders",
        },
                {
          text: "Подписчики",
          link: "/subscribers",
        },
        {
          text: "Настройки",
          link: "/settings",
        },
      ],
    };
  }
}
</script>

<style>
.navbar {
  margin-bottom: 50px;
}
</style>



