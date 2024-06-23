<template>
    <div>
      <b-modal id="upload-video-modal" v-model="isModalVisible" title="Upload Video" ok-title="Upload" ok-class="btn-upload" @ok="handleUpload">
        <div class="custom-file-upload" @click="triggerFileInput">
          <i class="fas fa-cloud-upload-alt"></i>
          <p>Click to choose a video or drag and drop it here</p>
          <p v-if="videoFile">Selected: {{ videoFile.name }}</p>
        </div>
        <input 
          type="file" 
          ref="fileInput" 
          @change="onFileSelected" 
          accept="video/*" 
          style="display: none;"
        >
      </b-modal>
    </div>
  </template>
  
  <script>
  import Swal from 'sweetalert2';
  import { mapActions } from 'vuex';
  
  export default {
    data() {
      return {
        videoFile: null,
        isModalVisible: false,
      };
    },
    methods: {
      ...mapActions(['uploadVideo']),
      showModal() {
        this.isModalVisible = true;
      },
      triggerFileInput() {
        this.$refs.fileInput.click();
      },
      onFileSelected(event) {
        this.videoFile = event.target.files[0];
      },
      handleUpload() {
        if (this.videoFile) {
          const formData = new FormData();
          formData.append('file', this.videoFile);
  
          this.uploadVideo(formData)
            .then(() => { 
              Swal.fire({
                icon: 'success',
                title: 'Success',
                text: 'Video uploaded successfully',
                confirmButtonText: 'OK',
              });
              this.resetForm();
              this.$emit('video-uploaded');
            })
            .catch(error => {
              Swal.fire({
                icon: 'error',
                title: 'Error',
                text: error.response?.data?.message || 'An error occurred'
              });
            });
        }
      },
      resetForm() {
        this.videoFile = null;
        this.isModalVisible = false;
      }
    }
  };
  </script>
  
  <style scoped>
  .custom-file-upload {
    border: 2px dashed #3498db;
    border-radius: 5px;
    padding: 30px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s ease;
  }
  
  .custom-file-upload:hover {
    background-color: #f7f9fc;
  }
  
  .custom-file-upload i {
    font-size: 48px;
    color: #3498db;
    margin-bottom: 10px;
  }
  
  .custom-file-upload p {
    margin: 0;
    color: #34495e;
  }
  </style>