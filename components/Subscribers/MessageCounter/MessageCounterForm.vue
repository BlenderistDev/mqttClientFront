<template>
  <div>
    <div class="text-center">
      <h3>Настройки</h3>
    </div>
    <ul class="list-group">
      <div class="row">
        <div class="col text-center"><h4>Топик для отправки значения</h4></div>
        <div class="col text-center"><h4>Интервал замера</h4></div>
      </div>
      <MessageCounterFormRow v-for="(messageCounter, index) in messageCounters" class="list-group-item" 
        v-bind:key="index" 
        v-bind:messageCounter="messageCounter"
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
import MessageCounterFormRow from '~/components/Subscribers/MessageCounter/MessageCounterFormRow.vue'
/**
 * Компонент для формы настроек модуля счетчика сообщений
 */
export default {
  data: function() {
    return {
      // список счетчиков собщений
      messageCounters: [],
    };
  },
  components: {
    MessageCounterFormRow
  },
  created: function() {
    // получаем список счетчиков обращений
    axios.post(this.$store.state.sApiLink, {
        module: "MessageCounter",
        cmd: "getList",
      }).then(response => this.messageCounters = response.data)
  },
  methods: {
    // добавление в список отображения
    add: function() {
      this.shellSubscribers.push({});
    },
    // удаление из списка отображения
    del: function(index) {
      this.shellSubscribers.splice(index, 1)
    }
  }
}
</script>