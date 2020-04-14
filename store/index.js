import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = () => new Vuex.Store({
  state: {
    // ссылка на endpoint бэка
    sApiLink: 'http://192.168.0.100:4000/api'
  }
})

export default store;