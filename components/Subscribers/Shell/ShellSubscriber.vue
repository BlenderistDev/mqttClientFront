<template>
  <div>
    <ModuleTopicForm module="shell" />
    <ShellSubscriberForm />
  </div>
</template>

<script>
import ShellSubscriberForm from '~/components/Subscribers/Shell/ShellSubscriberForm.vue'
import ModuleTopicForm from '~/components/ModuleTopic/ModuleTopicForm.vue'
/**
 * Компонент для настроек подписчика модуля командной строки
 */
export default {
  components: {
    ShellSubscriberForm,
    ModuleTopicForm
  },
}
</script>