import axios from './axiosConfig';

class AuthService {
    async login(credentials) {
        try {
            const response = await axios.post(`/api/login`, credentials);
            this.setToken(response.data.token);
            this.setUser(response.data.user);
            return response.data;
        } catch (error) {
            console.error('Error logging in:', error);
            throw error;
        }
    }

    async logout() {
        try {
            await axios.post(`/api/logout`);
            this.removeToken();
            this.removeUser();
        } catch (error) {
            console.error('Error logging out:', error);
            throw error;
        }
    }

    setToken(token) {
        localStorage.setItem('token', token);
    }

    getToken() {
        return localStorage.getItem('token');
    }

    removeToken() {
        localStorage.removeItem('token');
    }

    setUser(user) {
        localStorage.setItem('user', JSON.stringify(user));
    }

    getUser() {
        return JSON.parse(localStorage.getItem('user'));
    }

    removeUser() {
        localStorage.removeItem('user');
    }

    isAuthenticated() {
        const token = this.getToken();
        return !!token;
    }
}

export default new AuthService();
