<template>
  <div>
    <ul>
      <li v-for="conversation in conversations" :key="conversation.id">{{ conversation.name }}</li>
    </ul>
    <div v-if="error">{{ error.message }}</div>
  </div>
</template>

<script>
import conversationService from '@/services/conversationService';

export default {
  data() {
    return {
      conversations: [],
      error: null,
    };
  },
  mounted() {
    this.fetchConversations();
  },
  methods: {
    fetchConversations() {
      conversationService.getAllConversations(userId)
        .then(conversations => {
          this.conversations = conversations;
        })
        .catch(error => {
          this.error = error;
        });
    },
  },
};
</script>
