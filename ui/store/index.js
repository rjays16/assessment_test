import index, { createStore } from 'vuex';
import axios from '../axiosConfig';  // Adjust the import path

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
          state.tasks.splice(index, 1);
        }
    },
    actions: {
        createProduct({ commit }, product) {
            return axios.post('/api/products', product)
                .then(response => {
                    commit('ADD_PRODUCT', response.data);
                    return response.data;
                })
                .catch(error => {
                    throw error;
                });
        },
        getProducts({ commit }) {
            return axios.get('/api/products')
                .then(response => {
                    commit('SET_PRODUCTS', response.data);
                    return response.data;
                })
                .catch(error => {
                    throw error;
                });
        },
        deleteProduct({ commit }, productId) {
            return axios.delete(`/api/products/${productId}`)
                .then(() => {
                    commit('DELETE_PRODUCT', productId);
                })
                .catch(error => {
                    throw error;
                });
        }
    },
    modules: {
        // Your modules here
    }
});

export default store;
