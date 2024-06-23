import { createStore } from 'vuex';
import axios from '../axiosConfig';

const store = createStore({
    state: {
        videos: []
    },
    mutations: {
        SET_VIDEOS(state, videos) {
            state.videos = videos;
        },
        ADD_VIDEO(state, video) {
            state.videos.push(video);
        },
        DELETE_VIDEO(state, videoId) {
            const index = state.videos.findIndex(video => video.id === videoId);
            if (index !== -1) {
                state.videos.splice(index, 1);
            }
        }
    },
    actions: {
        async fetchVideos({ commit }) {
            const response = await axios.get('/api/videos');
            commit('SET_VIDEOS', response.data);
        },
        async uploadVideo({ commit }, formData) {
            const response = await axios.post('/api/videos', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            });
            commit('ADD_VIDEO', response.data);
        },
        async deleteVideo({ commit }, videoId) {
            await axios.delete(`/api/videos/${videoId}`);
            commit('DELETE_VIDEO', videoId);
        }
    }
});

export default store;

