import axios from 'axios';
import AuthService from './AuthService';

const instance = axios.create({
  baseURL: process.env.VUE_APP_BASE_URL || 'http://localhost:8080',
});

// Add a request interceptor
instance.interceptors.request.use(
  config => {
    const token = AuthService.getToken();
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  error => {
    return Promise.reject(error);
  }
);

export default instance;
