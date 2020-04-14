<template>
  <div>
    <ModuleTopicForm module="MessageCounter" />
    <MessageCounterForm />
  </div>
</template>

<script>
import MessageCounterForm from '~/components/Subscribers/MessageCounter/MessageCounterForm.vue'
import ModuleTopicForm from '~/components/ModuleTopic/ModuleTopicForm.vue'
/**
 * Компонент для отображения формы настроек модуля счетчика сообщений
 */
export default {
  components: {
    MessageCounterForm,
    ModuleTopicForm
  }
}
</script>