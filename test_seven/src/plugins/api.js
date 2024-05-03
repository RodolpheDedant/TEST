
import conversationService from '@/services/conversationService';

export default {
    install(Vue) {
        Vue.prototype.$conversationService = conversationService;
    }
};
