<template>
  <div>
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

      <b-button type="submit" variant="primary" :disabled="isLoading">
        <b-spinner v-if="isLoading" small></b-spinner>
        Login
      </b-button>
    </b-form>
  </div>
</template>

<script>
import AuthService from "../../../AuthService";

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
        const { access_token } = await AuthService.login({
          email: this.email,
          password: this.password,
        })
        AuthService.setToken(access_token)
         this.$router.push('/')
      } catch (error) {
        console.error('Error logging in:', error)
        console.log("incorrect")
      } finally {
        this.isLoading = false
      }
    },
  },
}
</script>

<style scoped>
.login-form {
  max-width: 400px; /* Adjust the max-width as needed */
  margin: 0 auto; /* Center the form horizontally */
}

.form-group {
  margin-bottom: 20px; /* Adjust the bottom margin between form groups */
}

.form-control {
  width: 100%; /* Make the input fields fill the entire width of the form */
}

.submit-button {
  width: 100%; /* Make the button fill the entire width of the form */
}
</style>
