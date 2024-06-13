<template>
  <div class="login-container">
    <div class="login-form">
      <h2>Login</h2>
      <b-form @submit.prevent="login">
        <b-form-group label="Email" label-for="email">
          <b-form-input
              id="email"
              v-model="email"
              type="email"
              required
              :state="emailState"
          >
            <template #invalid-feedback>
              Please enter a valid email address.
            </template>
          </b-form-input>
        </b-form-group>

        <b-form-group label="Password" label-for="password">
          <b-form-input
              id="password"
              v-model="password"
              type="password"
              required
              :state="passwordState"
          >
            <template #invalid-feedback>
              Password must be at least 8 characters long.
            </template>
          </b-form-input>
        </b-form-group>

        <b-button
            type="submit"
            variant="primary"
            :disabled="isLoading"
            class="submit-button"
        >
          <b-spinner v-if="isLoading" small></b-spinner>
          Login
        </b-button>
      </b-form>

      <div class="register-link">
        <router-link to="/register">Don't have an account? Register here</router-link>
      </div>
    </div>
  </div>
</template>

<script>
import AuthService from "../../../AuthService";
import Swal from "sweetalert2";

export default {
  name: 'LoginForm',
  data() {
    return {
      email: '',
      password: '',
      isLoading: false,
    }
  },
  computed: {
    emailState() {
      return this.email.includes('@') ? true : false
    },
    passwordState() {
      return this.password.length >= 8 ? true : false
    },
  },
  methods: {
    async login() {
      if (!this.emailState || !this.passwordState) {
        return
      }

      this.isLoading = true

      try {
        const { access_token, user } = await AuthService.login({
          email: this.email,
          password: this.password,
        });
        AuthService.setToken(access_token);
        AuthService.setUser(user);
        this.$router.push('/');
        Swal.fire({
          title: 'Success!',
          text: 'Login successfully',
          icon: 'success',
          confirmButtonText: 'OK'
        });
      } catch (error) {
        Swal.fire({
          title: 'Error!',
          text: error.response?.data?.message || 'Failed to login',
          icon: 'error',
          confirmButtonText: 'OK'
        });
      } finally {
        this.isLoading = false
      }
    },
  },
}
</script>

<style scoped>
.login-container {
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  align-items: center;
  height: 100vh;
  background-color: #f5f5f5;
}

.login-form {
  max-width: 400px;
  width: 100%;
  padding: 40px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  background: #fff;
  border-radius: 8px;
  margin-bottom: 300px;
}

.form-group {
  margin-bottom: 20px;
}

.form-control {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
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

.register-link {
  margin-top: 20px;
  text-align: center;
}

.register-link a {
  color: #007bff;
  text-decoration: none;
}

.register-link a:hover {
  text-decoration: underline;
}
</style>
