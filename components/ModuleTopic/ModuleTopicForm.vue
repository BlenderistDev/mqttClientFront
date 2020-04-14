<template>
  <div>
    <div class="text-center">
      <h3>Топики</h3>
    </div>
    <ModuleTopicFormRow v-for="(subscription, index) in moduleSubcriptionList" class="list-group-item" 
        v-bind:key="index" 
        v-bind:subscription="subscription"
        v-bind:index="index"
        v-bind:module="module"
        v-on:del="del($event)"
    />
    <div class="list-group-item">
      <button type="button" v-on:click="add" class="btn btn-primary btn-lg btn-block">Добавить</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import ModuleTopicFormRow from '~/components/ModuleTopic/ModuleTopicFormRow.vue'
/**
 * Форма для списка подписок модуля на mqtt топики
 */
export default {
  props: {
    // текущий модуль
    module: String,
  },
  data: function() {
    return {
      // список подписок моудля
      moduleSubcriptionList: [],
    };
  },
  components: {
    ModuleTopicFormRow
  },
  created: function() {
    // запрашиваем список подписок модуля
    axios.post(this.$store.state.sApiLink, {
        module: "Main",
        cmd: "GetModuleSubscriptions",
        data: {
          module: this.module
        }
      }).then(response => this.moduleSubcriptionList = response.data)
  },
  methods: {
    // добавление подписки в список для отображения
    add: function() {
      this.moduleSubcriptionList.push({});
    },
    // Удаление подписки из списка для отображения
    del: function(index) {
      this.moduleSubcriptionList.splice(index, 1)
    }
  }
}
</script>