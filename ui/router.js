import { createRouter, createWebHistory } from 'vue-router'
import Main from "@/components/Main.vue";
import Login from "@/components/User/Login.vue";
import AuthService from "./AuthService";

const routes = [
    {
        path: '/',
        name: 'Main',
        component: Main
    },
    {
        path: '/login',
        name: 'Login',
        component: Login
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

router.beforeEach((to, from, next) => {
    if (to.path !== '/login' && !AuthService.isAuthenticated()) {
        // If the user is not authenticated and trying to access any route other than /login, redirect to /login
        next('/login')
    } else if (to.path === '/login' && AuthService.isAuthenticated()) {
        // If the user is authenticated and trying to access /login, redirect to /
        next('/')
    } else {
        // Otherwise, allow navigation
        next()
    }
})

export default router
