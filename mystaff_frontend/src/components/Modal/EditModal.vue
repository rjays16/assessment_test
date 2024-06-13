<template>
  <b-modal v-model="showModal" @hidden="onHidden" title="Edit Task" ok-title="Edit Product" @ok="submitEditForm">
    <b-form @submit.stop.prevent="submitEditForm">
      <b-form-group label="Title" label-for="editTitle">
        <b-form-input id="editTitle" v-model="editedItemCopy.title" required></b-form-input>
      </b-form-group>
      <b-form-group label="Description" label-for="editDescription">
        <b-form-textarea id="editDescription" v-model="editedItemCopy.description" required></b-form-textarea>
      </b-form-group>
      <b-form-group label="Due Date" label-for="editDueDate">
        <b-form-input id="editDueDate" v-model="editedItemCopy.due_date" type="date" required></b-form-input>
      </b-form-group>
      <b-form-group label="Status" label-for="editStatus">
        <b-form-select
            id="product-status"
            v-model="editedItemCopy.status"
            :options="statusOptions"
            required
        ></b-form-select>
      </b-form-group>
    </b-form>
  </b-modal>
</template>

<script>
import { mapActions } from 'vuex';
import Swal from 'sweetalert2';
export default {
  props: {
    editedItem: {
      type: Object,
      required: true
    },
    showEditModal: {
      type: Boolean,
      required: true
    },
    statusOptions: {
      type: Array,
      default: () => [
        { value: '1', text: 'Active' },
        { value: '0', text: 'Expired' }
      ]
    }
  },
  data() {
    return {
      showModal: false,
      editedItemCopy: {}
    };
  },
  watch: {
    showEditModal(newVal) {
      this.showModal = newVal;
      if (newVal) {
        this.editedItemCopy = { ...this.editedItem };
          if (this.editedItem.status === '1') {
            this.editedItemCopy.status = '1';
          } else {
            this.editedItemCopy.status = '0';
          }
      }
    },
    showModal(newVal) {
      if (!newVal) {
        this.$emit('update:showEditModal', false);
      }
    }
  },
  methods: {
    ...mapActions(['updateProduct']),
    async submitEditForm() {
      try {
        const updatedProduct = await this.updateProduct(this.editedItemCopy);
        this.$emit('submit-edit', updatedProduct);
        this.showModal = false;
        Swal.fire({
          icon: 'success',
          title: 'Success!',
          text: 'Product updated successfully',
          confirmButtonText: 'OK'
        });
      } catch (error) {
        console.error('Error updating product:', error);
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: error.response?.data?.message || 'An error occurred while updating the product'
        });
      }
    },
    onHidden() {
      this.$emit('cancel-edit');
    }
  }
};
</script>
<style scoped>
</style>
