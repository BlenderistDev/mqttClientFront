<template>
  <form>
    <div class="form-row">
      <div class="col">
        <input v-model="topic" v-on:focusout="save" type="text" class="form-control" placeholder="Топик">
      </div>
      <div class="col">
        <input v-model="interval" v-on:focusout="save" type="number" class="form-control" placeholder="Интервал">
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
 * Компонент для строки формы настройки счетчика сообщений
 */
export default {
  props: {
    // Объект счетчика сообщений
    messageCounter: Object,
    // Индекс строки в списке
    index: Number
  },
  data: function() {
    return {
      id: "",
      topic: "",
      interval: ""
    };
  },
  created: function() {
    this.id = this.messageCounter.id;
    this.setMessageCounterData(this.messageCounter);
  },
  methods: {
    save: function() {
      if (this.id === undefined) {
        this.create();
      } else {
        this.update();
      }
    },
    // Устанавливаем данные компонента из объекта счетчика
    setMessageCounterData: function(oMessageCounter) {
      this.topic = oMessageCounter.topic;
      this.interval = oMessageCounter.interval;
    },
    create: function() {
      axios.post(this.$store.state.sApiLink, {
        module: 'MessageCounter',
        cmd: 'create',
        data: {
          topic: this.topic,
          interval: this.interval
        }
      }).then((response) => {
        this.id = response.data.id;
        this.setMessageCounterData(response.data);
      });
    },
    update: function() {
      axios.post(this.$store.state.sApiLink, {
        module: 'MessageCounter',
        cmd: 'update',
        data: {
          id: this.id,
          topic: this.topic,
          interval: this.interval
        }
      }).then(response => this.setMessageCounterData(response.data));
    },
    del: function() {
      // если id не определен, то достаточно удалить из списка отображения
      if (this.id === undefined) {
        this.$emit('del', this.index);
        return;
      }
      // иначе отправляем запрос на удаление на бэк
      axios.post(this.$store.state.sApiLink, {
        module: 'MessageCounter',
        cmd: 'delete',
        data: {
          id: this.id,
        }
      }).then(response => this.$emit('del', this.index));
    }
  }
}
</script>