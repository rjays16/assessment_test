import { createRouter, createWebHistory } from 'vue-router'
import authGuard from './authGuard';
import router from "../../router";
const router = createRouter({
    history: createWebHistory(),
    router,
})

router.beforeEach((to, from, next) => {
    if (to.matched.some(record => record.meta.requiresAuth)) {
        authGuard(to, from, next)
    } else {
        next()
    }
})

export default router