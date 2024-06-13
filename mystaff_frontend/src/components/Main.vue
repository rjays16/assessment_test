<template>
  <div id="app">
    <b-container>
      <b-row class="mb-3">
        <b-col>
          <h1>Video List</h1>
          <b-button size="md" variant="success" class="float-start" @click="showModal">Add New Video</b-button>
          <b-button size="md" variant="danger" class="float-end" @click="logout">Logout</b-button>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
      
        </b-col>
      </b-row>
      <AddModal ref="addModal" @add-video="addVideo"/>
      <!-- <EditModal
          :editedItem="editedItem"
          :showEditModal="showEditModal"
          :statusOptions="statusOptions"
          @submit-edit="updateEditedItem"
          @cancel-edit="closeEditModal"
      /> -->
    </b-container>
  </div>
</template>

<script>
import AddModal from "@/components/Modal/AddModal.vue";
// import EditModal from "@/components/Modal/EditModal.vue";
// import { mapState, mapActions } from 'vuex';
import { mapActions } from 'vuex';
import Swal from 'sweetalert2';
import AuthService from "../../AuthService";

export default {
  name: 'App',
  // components: {AddModal, EditModal },
  components: {AddModal },
  data() {
    return {
      // fields: [
      //   { key: 'id', label: 'ID' },
      //   { key: 'title', label: 'Title' },
      //   { key: 'description', label: 'Description' },
      //   { key: 'due_date', label: 'Due Date' },
      //   { key: 'status', label: 'Status' },
      //   { key: 'actions', label: 'Actions' }
      // ],
      // statusOptions: [
      //   { value: 1, text: 'Active' },
      //   { value: 0, text: 'Expired' }
      // ],
      // showEditModal: false,
      // editedItem: {}
    }
  },
  computed: {
    // ...mapState({
    //   products: state => state.products
    // }),
    // productsWithStatus() {
    //   return this.products.map(product => ({
    //     ...product,
    //     status: this.mapStatus(product.status)
    //   }));
    // },
    // isAdmin() {
    //   const user = AuthService.getUser();
    //   return user && user.roles === 'admin';
    // }
  },
  methods: {
    // ...mapActions(['getProducts', 'updateProduct', 'logout']),
    ...mapActions(['logout']),
    showModal() {
      this.$refs.addModal.showModal();
    },
    // openEditModal(item) {
    //   this.editedItem = {...item};
    //   this.showEditModal = true;
    // },
    closeEditModal() {
      this.showEditModal = false;
    },

    // async updateEditedItem(updatedItem) {
    //   try {
    //     const response = await this.updateProduct(updatedItem);
    //     const index = this.products.findIndex(p => p.id === response.id);
    //     if (index !== -1) {
    //       this.$store.commit('UPDATE_PRODUCT', response);
    //     }
    //     this.showEditModal = false;
    //   } catch (error) {
    //     console.error('Error updating product:', error);
    //     Swal.fire({
    //       title: 'Error!',
    //       text: 'Failed to update product',
    //       icon: 'error',
    //       confirmButtonText: 'OK'
    //     });
    //   }
    // },
    // async deleteProduct(id) {
    //   try {
    //     console.log('Deleting product with id:', id);
    //     await this.$store.dispatch('deleteProduct', id);
    //     Swal.fire({
    //       title: 'Success!',
    //       text: 'Product successfully deleted',
    //       icon: 'success',
    //       confirmButtonText: 'OK'
    //     });
    //   } catch (error) {
    //     console.error('Error deleting product:', error);
    //   }
    // },
    // addProduct(newProduct) {
    //   this.$store.commit('ADD_PRODUCT', newProduct);
    // },
    // mapStatus(status) {
    //   return status === 1 ? 'active' : 'expired';
    // },
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
  },
  created() {
    // this.getProducts();
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
