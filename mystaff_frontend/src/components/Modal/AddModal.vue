<template>
  <b-modal id="add-product-modal" v-model="isModalVisible" title="Add New Product" ok-title="Save" ok-class="btn-save" @ok="handleSubmit">
    <b-form @submit.stop.prevent="handleSubmit">
      <b-form-group label="Title" label-for="product-title">
        <b-form-input
          id="product-title"
          v-model="newProduct.title"
          required
        ></b-form-input>
      </b-form-group>
      <b-form-group label="Description" label-for="product-description">
        <b-form-input
          id="product-description"
          v-model="newProduct.description"
          required
        ></b-form-input>
      </b-form-group>
      <b-form-group label="Due Date" label-for="product-due-date">
        <b-form-input
          id="product-due-date"
          v-model="newProduct.due_date"
          type="date"
          required
        ></b-form-input>
      </b-form-group>
      <b-form-group label="Status" label-for="product-status">
        <b-form-select
          id="product-status"
          v-model="newProduct.status"
          :options="statusOptions"
          required
        ></b-form-select>
      </b-form-group>
    </b-form>
  </b-modal>
</template>

<script>
import Swal from 'sweetalert2';
import { mapActions } from 'vuex';
import { disableButton } from "../Helper/functions.js";

export default {
  data() {
    return {
      newProduct: {
        title: '',
        description: '',
        due_date: '',
        status: ''
      },
      statusOptions: [
        { value: '1', text: 'Active' },
        { value: '0', text: 'Expired' }
      ],
      isModalVisible: false,
    };
  },
  methods: {
    ...mapActions(['createProduct']),
    showModal() {
      this.isModalVisible = true;
    },
    handleSubmit() {
      disableButton('.btn-save', true);

      this.createProduct(this.newProduct)
        .then(response => {
          Swal.fire({
            icon: 'success',
            title: 'Success',
            text: response.message,
            confirmButtonText: 'OK',
          });
          this.resetForm();
        })
        .catch(error => {
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: error.response?.data?.message || 'An error occurred'
          });
          disableButton('.btn-save', false);
        });
    },
    resetForm() {
      this.newProduct = {
        title: '',
        description: '',
        due_date: '',
        status: ''
      };
      this.isModalVisible = false;
      setTimeout(() => {
        window.location.reload();
      }, 4000);
    }
  }
};
</script>
