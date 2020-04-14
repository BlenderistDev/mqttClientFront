<template>
  <div>
    <div class="text-center">
      <h3>Настройки</h3>
    </div>
    <ul class="list-group">
      <div class="row">
        <div class="col text-center"><h4>Команда</h4></div>
        <div class="col text-center"><h4>Шаблон команды</h4></div>
      </div>
      <ShellSubscriberFormRow v-for="(subscriber, index) in shellSubscribers" class="list-group-item" 
        v-bind:key="index" 
        v-bind:subscriber="subscriber"
        v-bind:index="index"
        v-on:del="del($event)"
      />
      <div class="list-group-item">
        <button type="button" v-on:click="add" class="btn btn-primary btn-lg btn-block">Добавить</button>
      </div>
    </ul> 
  </div>
</template>

<script>
import axios from "axios";
import ShellSubscriberFormRow from '~/components/Subscribers/Shell/ShellSubscriberFormRow.vue'
/**
 * Форма для настроек модуля ShellSubscriber
 */
export default {
  data: function() {
    return {
      // список подписчиков
      shellSubscribers: []
    };
  },
  components: {
    ShellSubscriberFormRow
  },
  created: function() {
    // получаем список подписок модуля
    axios.post(this.$store.state.sApiLink, {
        module: "Shell",
        cmd: "getList",
      }).then(response => {
        this.shellSubscribers = response.data;
      });
  },
  methods: {
    // добавляем модулю подписку в список отображения
    add: function() {
      this.shellSubscribers.push({});
    },
    // удаляем подписку модуля из списка отображения
    del: function(index) {
      this.shellSubscribers.splice(index, 1)
    }
  }
}
</script>