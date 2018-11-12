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


//import Vapor
//import HTTP
//
//
///// Here we have a controller that helps facilitate
///// creating typical REST patterns
//final class AdminController: ResourceRepresentable {
//    
//    let view: ViewRenderer
//    init(_ view: ViewRenderer) {
//        self.view = view
//    }
//    
//    /// GET /admin/dashboard
//    func dashboard(_ req: Request) throws -> ResponseRepresentable {
//        return try view.make("admin/pages/dashboard/index", [
//            "name": "World"
//            ], for: req)
//    }
//    
//    
//    /// When making a controller, it is pretty flexible in that it
//    /// only expects closures, this is useful for advanced scenarios, but
//    /// most of the time, it should look almost identical to this
//    /// implementation
//    func makeResource() -> Resource<String> {
//        return Resource(
//            index: dashboard
//        )
//    }
//    
//}
