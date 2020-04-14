<template>
  <div>
    <div class="text-center">
      <h3>Настройки</h3>
    </div>
    <ul class="list-group">
      <div class="row">
        <div class="col text-center"><h4>Команда</h4></div>
        <div class="col text-center"><h4>Топик</h4></div>
        <div class="col text-center"><h4>Интервал</h4></div>
      </div>
      <ShellSenderFormRow v-for="(sender, index) in shellSenders" class="list-group-item" 
        v-bind:key="index" 
        v-bind:sender="sender"
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
import ShellSenderFormRow from '~/components/Senders/Shell/ShellSenderFormRow.vue'
/**
 * Форма для настроек ShellSender
 */
export default {
  data: function() {
    return {
      // список отправителей модуля
      shellSenders: []
    };
  },
  components: {
    ShellSenderFormRow
  },
  created: function() {
    // получаем список отправителей модуля
    axios.post(this.$store.state.sApiLink, {
        module: "Shell",
        cmd: "getSenderList",
      }).then(response => this.shellSenders = response.data);
  },
  methods: {
    // добавление в список отображения
    add: function() {
      this.shellSenders.push({});
    },
    // удаление из списка отображения
    del: function(index) {
      this.shellSenders.splice(index, 1)
    }
  }
}
</script>