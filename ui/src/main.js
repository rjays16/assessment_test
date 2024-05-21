import { createApp } from 'vue';
import App from './App.vue';
import BootstrapVue3 from 'bootstrap-vue-3';
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue-3/dist/bootstrap-vue-3.css';
import store from '../store';
import axios from '../axiosConfig';
import router from "../router";

const app = createApp(App);

app.use(BootstrapVue3);

app.use(store);

app.use(router);

app.config.globalProperties.$axios = axios;

// Mount the app
app.mount('#app');
