<template>
  <form>
    <div class="form-row">
      <div class="col">
        <input v-model="topic" v-on:focusout="save" type="text" class="form-control" placeholder="Топик">
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
 * Модуль одной строки для формы подписок модуля на mqtt топики
 */
export default {
  props: {
    // имя модуля
    module: String,
    // индекс строки в списке
    index: Number,
    // объект подписки
    subscription: Object,
  },
  data: function() {
    return {
      // id подписки
      id: "",
      // топик подписки
      topic: "",
    };
  },
  created: function() {
    this.id = this.subscription.id;
    this.topic = this.subscription.topic;
  },
  methods: {
    save: function() {
      if (this.id === undefined) {
        this.create();
      } else {
        this.update();
      }
    },
    // создаем новую подписку для модуля
    create: function() {
      axios.post(this.$store.state.sApiLink, {
        module: 'Main',
        cmd: 'createSubscriber',
        data: {
          module: this.module,
          topic: this.topic
        }
      }).then((response) => {
        this.id = response.data.id;
        this.topic = response.data.topic;
      });
    },
    // обновляем существующую подписку для модуля
    update: function() {
      axios.post(this.$store.state.sApiLink, {
        module: 'Main',
        cmd: 'updateSubscriber',
        data: {
          id: this.id,
          module: this.module,
          topic: this.topic
        }
      }).then(response => this.topic = response.data.topic);
    },
    // удаление подписки модуля
    del: function() {
      // если нет id - значит подписка еще не созранена на бэке. Нужно лишь удалить ее из списка отображения
      if (this.id === undefined) {
        this.$emit('del', this.index);
        return;
      }
      // иначе отправляем запрос тна удаление на бэк
      axios.post(this.$store.state.sApiLink, {
        module: 'Main',
        cmd: 'deleteSubscriber',
        data: {
          id: this.id,
        }
      }).then(response => this.$emit('del', this.index));
    }
  }
}
</script>