<template>
  <div id="app">
    <b-container>
      <b-row class="mb-3">
        <b-col>
          <h1>Video List</h1>
          <b-button size="md" variant="success" class="float-start" @click="showUploadModal">Upload Video</b-button>
          <b-button size="md" variant="danger" class="float-end" @click="logout">Logout</b-button>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <b-table striped hover :items="videos" :fields="fields" :show-empty="videos.length === 0">
            <template #cell(actions)="data">
              <b-button size="sm" variant="danger" @click="deleteVideo(data.item.id)">Delete</b-button>
            </template>
            <template #empty>
              <div class="text-center">
                Empty Data
              </div>
            </template>
          </b-table>
        </b-col>
      </b-row>
      <UploadModal ref="uploadModal" @video-uploaded="fetchVideos" />
    </b-container>
  </div>
</template>

<script>
import UploadModal from "@/components/Modal/UploadModal.vue";
import { mapState, mapActions } from 'vuex';
import Swal from 'sweetalert2';
import AuthService from "../../AuthService";

export default {
  name: 'App',
  components: { UploadModal },
  data() {
    return {
      fields: [
        { key: 'id', label: 'ID' },
        { key: 'name', label: 'Name' },
        { key: 'size', label: 'Size', formatter: this.formatSize },
        { key: 'actions', label: 'Actions' }
      ],
    };
  },
  computed: {
    ...mapState({
      videos: state => state.videos
    }),
  },
  methods: {
    ...mapActions(['fetchVideos', 'logout']),
    showUploadModal() {
      this.$refs.uploadModal.showModal();
    },
    async deleteVideo(id) {
      try {
        console.log('Deleting video with id:', id);
        await this.$store.dispatch('deleteVideo', id);
        Swal.fire({
          title: 'Success!',
          text: 'Video successfully deleted',
          icon: 'success',
          confirmButtonText: 'OK'
        });
      } catch (error) {
        console.error('Error deleting video:', error);
        Swal.fire({
          title: 'Error!',
          text: 'Failed to delete video',
          icon: 'error',
          confirmButtonText: 'OK'
        });
      }
    },
    async logout() {
      try {
        await this.$store.dispatch('logout');
        AuthService.removeToken();
        AuthService.removeUser();
        Swal.fire({
          title: 'Logged Out',
          text: 'You have been successfully logged out.',
          icon: 'success',
          confirmButtonText: 'OK'
        }).then(() => {
          this.$router.push('/login');
        });
      } catch (error) {
        console.error('Error logging out:', error);
        Swal.fire({
          title: 'Error!',
          text: 'Failed to logout',
          icon: 'error',
          confirmButtonText: 'OK'
        });
      }
    },
    formatSize(sizeInBytes) {
      if (sizeInBytes === 0) return '0 B';

      const units = ['B', 'KB', 'MB', 'GB', 'TB'];
      const digitGroups = Math.floor(Math.log(sizeInBytes) / Math.log(1024));

      return `${(sizeInBytes / Math.pow(1024, digitGroups)).toFixed(2)} ${units[digitGroups]}`;
    },
  },
  created() {
    if (AuthService.isAuthenticated()) {
      this.fetchVideos();
    } else {
      this.$router.push('/login');
    }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
