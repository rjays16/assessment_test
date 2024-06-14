<template>
  <b-modal id="add-video-modal" v-model="isModalVisible" title="Add New Video" @ok="handleSubmit">
    <b-form @submit.stop.prevent="handleSubmit">
      <b-form-group label="Title" label-for="video-title">
        <b-form-input id="video-title" v-model="newVideo.title" required></b-form-input>
      </b-form-group>
      <b-form-group label="Video" label-for="video">
        <input id="video" type="file" @change="handleFileUpload" required>
        <small class="text-danger" v-if="videoError"><br>{{ videoError }}</small>
      </b-form-group>
    </b-form>
  </b-modal>
</template>

<script>
import Swal from 'sweetalert2';
import axiosInstance from '../../../axiosConfig'; // Update the path according to your file structure

export default {
  data() {
    return {
      newVideo: {
        title: '',
        videoFile: null,
      },
      isModalVisible: false,
      videoError: ''
    };
  },
  methods: {
    showModal() {
      this.isModalVisible = true;
    },
    async handleSubmit() {
      if (!this.newVideo.videoFile) {
        this.videoError = 'Please upload a valid video file.';
        return;
      }

      try {
        const formData = new FormData();
        formData.append('title', this.newVideo.title);
        formData.append('video', this.newVideo.videoFile);

        const response = await axiosInstance.post('api/videos', formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          },
          onUploadProgress: progressEvent => {
            const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
            console.log('Upload progress: ', percentCompleted);
          }
        });

        Swal.fire({
          icon: 'success',
          title: 'Success',
          text: response.data.message,
          confirmButtonText: 'OK',
        });
        this.resetForm();
      } catch (error) {
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: error.response?.data?.message || 'An error occurred'
        });
      }
    },
    handleFileUpload(event) {
      const file = event.target.files[0];
      const validVideoTypes = ['video/mp4', 'video/avi', 'video/mkv', 'video/mov', 'video/webm'];

      if (file && validVideoTypes.includes(file.type)) {
        this.newVideo.videoFile = file;
        this.videoError = '';
      } else {
        this.newVideo.videoFile = null;
        this.videoError = 'Please upload a valid video file.';
      }
    },
    resetForm() {
      this.newVideo = {
        title: '',
        videoFile: null,
      };
      this.videoError = '';
      this.isModalVisible = false;
    }
  }
};
</script>

<style scoped>
.text-danger {
  color: #dc3545;
}
</style>