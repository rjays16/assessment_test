import { createStore } from 'vuex';
import axios from '../axiosConfig'; // Adjust the import path

const store = createStore({
    state: {
        products: []
    },
    mutations: {
        ADD_PRODUCT(state, product) {
            state.products.push(product);
        },
        SET_PRODUCTS(state, products) {
            state.products = products;
        },
        DELETE_PRODUCT(state, productId) {
            const index = state.products.findIndex(product => product.id === productId);
            if (index !== -1) {
                state.products.splice(index, 1);
            }
        }
    },
    actions: {
        async createProduct({ commit }, product) {
            const response = await axios.post('/api/products', product);
            commit('ADD_PRODUCT', response.data);
            return response.data;
        },
        async getProducts({ commit }) {
            const response = await axios.get('/api/products');
            commit('SET_PRODUCTS', response.data);
            return response.data;
        },
        async deleteProduct({ commit }, productId) {
            await axios.delete(`/api/products/${productId}`);
            commit('DELETE_PRODUCT', productId);
        }
    },
    modules: {
        // Your modules here
    }
});

export default store;
