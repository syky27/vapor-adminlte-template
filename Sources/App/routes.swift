import Vapor
import Fluent

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let loginController = LoginController()
    try router.register(collection: loginController)
}


