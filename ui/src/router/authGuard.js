import AuthService from "../../AuthService";

export default function authGuard(to, from, next) {
    const isAuthenticated = AuthService.isAuthenticated()

    if (isAuthenticated) {
        next()
    } else {
        next('/login')
    }
}