import { createRouter, createWebHistory } from 'vue-router';
import Main from "@/components/Main.vue";
import Login from "@/components/User/Login.vue";
import Register from "@/components/User/Register.vue";
import AuthService from "./AuthService";

const routes = [
    {
        path: '/',
        name: 'Main',
        component: Main,
        meta: { requiresAuth: true }
    },
    {
        path: '/login',
        name: 'Login',
        component: Login
    },
    {
        path: '/register',
        name: 'Register',
        component: Register
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes
});

router.beforeEach((to, from, next) => {
    const isAuthenticated = AuthService.isAuthenticated();

    if (to.matched.some(record => record.meta.requiresAuth)) {
        if (isAuthenticated) {
            next();
        } else {
            next('/login');
        }
    } else if (to.path === '/login' && isAuthenticated) {
        next('/');
    } else {
        next();
    }
});

export default router;
