<template>
  <form>
    <div class="form-row">
      <div class="col">
        <input v-model="cmd" v-on:focusout="save" type="text" class="form-control" placeholder="Команда">
      </div>
      <div class="col">
        <input v-model="commandTemplate" v-on:focusout="save" type="text" class="form-control" placeholder="Шаблон команды">
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
 * Строка формы настроек модуля ShellSubscriber
 */
export default {
  props: {
    // объект подписчика
    subscriber: Object, 
    // индекс строки в списке отображения
    index: Number
  },
  data: function() {
    return {
      id: "",
      cmd: "",
      commandTemplate: ""
    };
  },
  created: function() {
    this.id = this.subscriber.id;
    this.setSubscriberData(this.subscriber);
  },
  methods: {
    save: function() {
      if (this.id === undefined) {
        this.create();
      } else {
        this.update();
      }
    },
    // устанавливаем данные компонена на основе объекта подписчика
    setSubscriberData: function(oSubscriber) {
      this.cmd = oSubscriber.cmd;
      this.commandTemplate = oSubscriber.commandTemplate;
    },
    create: function() {
      axios.post(this.$store.state.sApiLink, {
        module: 'Shell',
        cmd: 'create',
        data: {
          cmd: this.cmd,
          commandTemplate: this.commandTemplate
        }
      }).then((response) => {
        this.id = response.data.id;
        this.setSubscriberData(response.data);
      });
    },
    update: function() {
      axios.post(this.$store.state.sApiLink, {
        module: 'Shell',
        cmd: 'update',
        data: {
          id: this.id,
          cmd: this.cmd,
          commandTemplate: this.commandTemplate
        }
      }).then(response => this.setSubscriberData(response.data));
    },
    del: function() {
      // если id не определен - достаточно удалить из списка
      if (this.id === undefined) {
        this.$emit('del', this.index);
        return;
      }
      // иначе отправляем запрос на удаление на бэк
      axios.post(this.$store.state.sApiLink, {
        module: 'Shell',
        cmd: 'delete',
        data: {
          id: this.id,
        }
      }).then(response => this.$emit('del', this.index));
    }
  }
}
</script>