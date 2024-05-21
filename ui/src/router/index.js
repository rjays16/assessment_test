import { createRouter, createWebHistory } from 'vue-router'
import authGuard from './authGuard'

const router = createRouter({
    history: createWebHistory(),
    routes,
})

router.beforeEach((to, from, next) => {
    if (to.matched.some(record => record.meta.requiresAuth)) {
        authGuard(to, from, next)
    } else {
        next()
    }
})

export default router