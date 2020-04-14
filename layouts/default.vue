<template>
  <div class="container-fluid">
    <NavBar />
    <nuxt/>
  </div>
</template>

<script>
import NavBar from '~/components/NavBar/NavBar.vue';

export default {
  components: {
    NavBar
  }
}
</script>
