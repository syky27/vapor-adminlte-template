import Vapor
import Leaf
import Fluent
import Authentication

struct LoginController: RouteCollection {

    func boot(router: Router) throws {
        router.get("login", use: loginHTMLHandler)
    }
}

func loginHTMLHandler(_ req: Request) throws -> Future<View> {
    return try req.view().render("admin/pages/login/login")
}

struct LoginPostData: Content {
    let username: String
    let password: String
}

struct LoginIndexContext: Encodable {
    let title = "Log In"
    let loginError: Bool

    init(loginError: Bool = false) {
        self.loginError = loginError
    }
}
