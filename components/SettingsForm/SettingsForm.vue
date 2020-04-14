<template>
  <div>
    <form>
      <div class="form-group">
        <label for="mqttServerAddress">Адрес mqtt сервера</label>
        <input v-model="mqttServerAddress" v-on:focusout="updateMqttServerAddress" type="text" class="form-control" id="mqttServerAddress">
      </div>
      <div class="form-group">
        <label for="mqttUserName">Логин пользователя mqtt сервера</label>
        <input v-model="mqttUserName" v-on:focusout="updateMqttUserName" type="text" class="form-control" id="mqttUserName">
      </div>
      <div class="form-group">
        <label for="mqttPassword">Пароль mqtt сервера</label>
        <input v-model="mqttPassword" v-on:focusout="updateMqttPassword" type="password" class="form-control" id="mqttPassword">
      </div>
    </form>
  </div>
</template>

<script>
import axios from "axios";
/**
 * Компонент настроек, позволяет настраивать параметры бэка
 */
export default {
  data: function() {
    return {
      mqttServerAddress: "",
      mqttUserName: "",
      mqttPassword: "",
    };
  },
  // запрашиваем список настроек
  created: function() {
    axios.post(this.$store.state.sApiLink, {
        module: "Settings",
        cmd: "getMqttSettings",
      }).then(response => this.setConfigFromResponse(response));
  },
  methods: {
    // обновляем адрес mqtt сервера
    updateMqttServerAddress: function() {
      axios.post(this.$store.state.sApiLink, {
        module: 'Settings',
        cmd: 'setMqttServerAddress',
        data: {
          mqttServerAddress: this.mqttServerAddress
        }
      }).then(response => this.setConfigFromResponse(response));
    },
    // обновляем имя пользователя mqtt сервера
    updateMqttUserName: function() {
      axios.post(this.$store.state.sApiLink, {
        module: 'Settings',
        cmd: 'setMqttUserName',
        data: {
          mqttUserName: this.mqttUserName
        }
      }).then(response => this.setConfigFromResponse(response));
    },
    // обновляем пароль mqtt сервера
    updateMqttPassword: function() {
      axios.post(this.$store.state.sApiLink, {
        module: 'Settings',
        cmd: 'setMqttPassword',
        data: {
          mqttPassword: this.mqttPassword
        }
      }).then(response => this.setConfigFromResponse(response));
    },
    // устанавливаем данные компонента из объекта настроек
    setConfigFromResponse: function(oSettings) {
      this.mqttServerAddress = oSettings.data.host;
      this.mqttUserName = oSettings.data.username;
      this.mqttPassword = oSettings.data.password;
    }
  }
}
</script>