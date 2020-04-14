<template>
  <form>
    <div class="form-row">
      <div class="col">
        <input v-model="command" v-on:focusout="save" type="text" class="form-control" placeholder="Команда">
      </div>
      <div class="col">
        <input v-model="topic" v-on:focusout="save" type="text" class="form-control" placeholder="Топик">
      </div>
      <div class="col">
        <input v-model="interval" v-on:focusout="save" type="text" class="form-control" placeholder="Интервал">
      </div>
      <div class="coll">
        <button 
          v-on:click="del"
          type="button"
          class="btn btn-primary"
        >X</button>
      </div>
    </div>
  </form>
</template>

<script>
import axios from "axios";
/**
 * Строка для формы настроек модуля ShellSender
 */
export default {
  props: {
    // объект настроек отправителя
    sender: Object,
    // индекс строки в списке
    index: Number,
  },
  data: function() {
    return {
      id: "",
      command: "",
      topic: "",
      interval: "",
    };
  },
  created: function() {
    this.id = this.sender.id;
    this.setSenderData(this.sender);
  },
  methods: {
    save: function() {
      if (this.id === undefined) {
        this.create();
      } else {
        this.update();
      }
    },
    // устанавливаем данные компонента на основе объекта отправителя
    setSenderData: function(oSender) {
      this.command = oSender.command;
      this.topic = oSender.topic;
      this.interval = oSender.interval;
    },
    create: function() {
      axios.post(this.$store.state.sApiLink, {
        module: 'Shell',
        cmd: 'createSender',
        data: {
          command: this.command,
          topic: this.topic,
          interval: this.interval
        }
      }).then((response) => {
        this.id = response.data.id;
        this.setSender(response.data);
      });
    },
    update: function() {
      axios.post(this.$store.state.sApiLink, {
        module: 'Shell',
        cmd: 'updateSender',
        data: {
          command: this.command,
          topic: this.topic,
          interval: this.interval
        }
      }).then(response => this.setSubscriberData(response.data));
    },
    del: function() {
      // если нет id, то достаточно удалить из списка
      if (this.id === undefined) {
        this.$emit('del', this.index);
        return;
      }
      // иначе отправляем запрос на удаление на бэк
      axios.post(this.$store.state.sApiLink, {
        module: 'Shell',
        cmd: 'deleteSender',
        data: {
          id: this.id,
        }
      }).then((response) => this.$emit('del', this.index));
    }
  }
}
</script>