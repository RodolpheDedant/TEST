import axios from 'axios';

const API_URL = 'http://localhost:3005';

export default {
    getAllConversations() {
        return axios.get(`${API_URL}/conversations/`)
            .then(response => response.data)
            .catch(error => {
                console.error('Error fetching conversations:', error);
                throw error;
            });
    },
    createConversation(userId, recipientId) {
        const body = { recipientId };
        return axios.post(`${API_URL}/conversations/${userId}`, body)
            .then(response => response.data)
            .catch(error => {
                console.error('Error creating conversation:', error);
                throw error;
            });
    },
    getMessages(conversationId) {
        return axios.get(`${API_URL}/messages/${conversationId}`)
            .then(response => response.data)
            .catch(error => {
                console.error('Error fetching messages:', error);
                throw error;
            });
    },
    sendMessage(conversationId, message) {
        return axios.post(`${API_URL}/messages/${conversationId}`, message)
            .then(response => response.data)
            .catch(error => {
                console.error('Error sending message:', error);
                throw error;
            });
    },
};
