<template>
  <b-modal v-model="showModal" @hidden="onHidden" title="Edit Task">
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
        <b-form-select id="editStatus" v-model="editedItemCopy.status" :options="statusOptions" required></b-form-select>
      </b-form-group>
    </b-form>
  </b-modal>
</template>

<script>
export default {
  props: {
    editedItem: Object,
    showEditModal: Array,
    statusOptions: {
      type: Array,
      default: () => [
        { value: 'active', text: 'Active' },
        { value: 'expired', text: 'Expired' }
      ]
    },
    index: Number,
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
      }
    }
  },
  methods: {
    submitEditForm() {
      this.$emit('submit-edit', this.editedItemCopy);
    },
    onHidden() {
      this.$emit('cancel-edit');
    }
  }
};
</script>

<style scoped>
</style>
