<template>
  <div class="register-container">
    <div class="register-form">
      <h2>Register</h2>
      <b-form @submit.prevent="register">
        <b-form-group label="Name" label-for="name">
          <b-form-input
              id="name"
              v-model="name"
              type="text"
              required
          ></b-form-input>
        </b-form-group>

        <b-form-group label="Email" label-for="email">
          <b-form-input
              id="email"
              v-model="email"
              type="email"
              required
          ></b-form-input>
        </b-form-group>

        <b-form-group label="Password" label-for="password">
          <b-form-input
              id="password"
              v-model="password"
              type="password"
              required
          ></b-form-input>
        </b-form-group>

        <b-form-group label="Confirm Password" label-for="confirmPassword">
          <b-form-input
              id="confirmPassword"
              v-model="confirmPassword"
              type="password"
              required
          ></b-form-input>
        </b-form-group>

        <b-button
            type="submit"
            variant="primary"
            :disabled="isLoading"
            class="submit-button"
        >
          <b-spinner v-if="isLoading" small></b-spinner>
          Register
        </b-button>
        <div class="login-link">
          <router-link to="/login">Already have an account? Login here</router-link>
        </div>
      </b-form>
    </div>
  </div>
</template>

<script>
import AuthService from "../../../AuthService";
import Swal from "sweetalert2";

export default {
  name: "RegisterForm",
  data() {
    return {
      name: "",
      email: "",
      password: "",
      confirmPassword: "",
      isLoading: false,
    };
  },
  methods: {
    async register() {
      if (this.password !== this.confirmPassword) {
        Swal.fire({
          title: "Error!",
          text: "Passwords do not match",
          icon: "error",
          confirmButtonText: "OK",
        });
        return;
      }

      this.isLoading = true;

      try {
        await AuthService.register({
          name: this.name,
          email: this.email,
          password: this.password,
        });
        this.$router.push("/login");
        Swal.fire({
          title: "Success!",
          text: "Registration successful",
          icon: "success",
          confirmButtonText: "OK",
        });
      } catch (error) {
        Swal.fire({
          title: "Error!",
          text: error.response?.data?.message || "Failed to register",
          icon: "error",
          confirmButtonText: "OK",
        });
      } finally {
        this.isLoading = false;
      }
    },
  },
};
</script>

<style scoped>
.register-container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background-color: #f5f5f5;
}

.register-form {
  max-width: 400px;
  width: 100%;
  padding: 40px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  background: #fff;
  border-radius: 8px;
}

.submit-button {
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.submit-button:hover {
  background-color: #0056b3;
}
</style>