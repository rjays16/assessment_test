// axiosConfig.js
import axios from 'axios';
import AuthService from './AuthService';
import router from './router';  // import your Vue Router instance

const instance = axios.create({
  baseURL: process.env.VUE_APP_BASE_URL || 'http://localhost:8000',
});

// Add a request interceptor to include the token
instance.interceptors.request.use(
  (config) => {
    const token = AuthService.getToken();
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Add a response interceptor to handle 401 errors
instance.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response && error.response.status === 401) {
      AuthService.removeToken();
      router.push('/login');
    }
    return Promise.reject(error);
  }
);

export default instance;
