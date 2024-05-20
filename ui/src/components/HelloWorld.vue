<template>
  <div id="app">
    <b-container>
      <b-row class="mb-3">
        <b-col>
          <h1>Product List</h1>
          <b-button size="md" variant="success" class="float-end" @click="showModal">Add New Product</b-button>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <b-table striped hover :items="productsWithStatus" :fields="fields" :show-empty="productsWithStatus.length === 0">
            <template #cell(actions)="data">
              <b-button size="sm" variant="primary" @click="openEditModal(data.item)" class="me-3">Edit</b-button>
              <b-button size="sm" variant="danger" @click="deleteProduct(data.item.id)">Delete</b-button>
            </template>
            <template #empty>
              <div class="text-center">
                Empty Data
              </div>
            </template>
          </b-table>
        </b-col>
      </b-row>
      <AddModal ref="addModal" @add-product="addProduct"/>
      <EditModal
          :editedItem="editedItem"
          :showEditModal="showEditModal"
          :statusOptions="statusOptions"
          @submit-edit="updateEditedItem"
          @cancel-edit="closeEditModal"
      />
    </b-container>
  </div>
</template>

<script>
import AddModal from "@/components/Modal/AddModal.vue";
import EditModal from "@/components/Modal/EditModal.vue";
import { mapState, mapActions } from 'vuex';
import Swal from 'sweetalert2';

export default {
  name: 'App',
  components: { AddModal, EditModal },
  data() {
    return {
      fields: [
        { key: 'id', label: 'ID' },
        { key: 'title', label: 'Title' },
        { key: 'description', label: 'Description' },
        { key: 'due_date', label: 'Due Date' },
        { key: 'status', label: 'Status' },
        { key: 'actions', label: 'Actions' }
      ],
      statusOptions: [
        { value: 1, text: 'Active' },
        { value: 0, text: 'Expired' }
      ],
      showEditModal: false,
      editedItem: {}
    }
  },
  computed: {
    ...mapState({
      products: state => state.products
    }),
    productsWithStatus() {
      return this.products.map(product => ({
        ...product,
        status: this.mapStatus(product.status)
      }));
    }
  },
  methods: {
    ...mapActions(['getProducts']),
    showModal() {
      this.$refs.addModal.showModal();
    },
    openEditModal(item) {
      this.editedItem = {...item};
      this.showEditModal = true;
    },
    closeEditModal() {
      this.showEditModal = false;
    },
    updateEditedItem(updatedItem) {
      const index = this.products.findIndex(p => p.id === updatedItem.id);
      if (index !== -1) {
        this.$store.commit('SET_PRODUCTS', [
          ...this.products.slice(0, index),
          updatedItem,
          ...this.products.slice(index + 1)
        ]);
      }
      this.showEditModal = false;
    },
    async deleteProduct(id) {
      try {
        await this.$store.dispatch('deleteProduct', id);
        Swal.fire({
          title: 'Success!',
          text: 'Product successfully deleted',
          icon: 'success',
          confirmButtonText: 'OK'
        });
      } catch (error) {
        console.error('Error: deleting product:', error);
      }
    },
    addProduct(newProduct) {
      this.$store.commit('ADD_PRODUCT', newProduct);
    },
    mapStatus(status) {
      return status === 1 ? 'active' : 'expired';
    }
  },
  created() {
    this.getProducts();
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
