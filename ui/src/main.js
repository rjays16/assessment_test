import { createApp } from 'vue';
import App from './App.vue';
import BootstrapVue3 from 'bootstrap-vue-3';
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue-3/dist/bootstrap-vue-3.css';
import store from '../store';  // Adjust the import path to your store
import axios from '../axiosConfig';  // Adjust the import path to your axiosConfig

const app = createApp(App);

// Use BootstrapVue3
app.use(BootstrapVue3);

// Use Vuex store
app.use(store);

// Add Axios to the global properties if needed
app.config.globalProperties.$axios = axios;

// Mount the app
app.mount('#app');
