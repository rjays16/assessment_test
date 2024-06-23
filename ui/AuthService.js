import axios from './axiosConfig';

class AuthService {
    async register(user) {
        try {
            const response = await axios.post(`/api/register`, user);
            return response.data;
        } catch (error) {
            console.error('Error registering:', error);
            throw error;
        }
    }
    async login(credentials) {
        try {
            const response = await axios.post(`/api/login`, credentials);
            if (response.data.token) {
                this.setToken(response.data.token);
                this.setUser(response.data.user);
            }
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
        const user = localStorage.getItem('user');
        try {
            return user ? JSON.parse(user) : null;
        } catch (error) {
            console.error('Error parsing user JSON:', error);
            return null;
        }
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
