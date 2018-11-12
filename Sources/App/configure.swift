import FluentPostgreSQL
import Vapor
import Leaf
import Authentication

public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
    ) throws {
    try services.register(FluentPostgreSQLProvider())
    try services.register(LeafProvider())
    try services.register(AuthenticationProvider())
    


    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    var middlewares = MiddlewareConfig()
    middlewares.use(FileMiddleware.self) // Serves files from `Public/
    middlewares.use(ErrorMiddleware.self)
    middlewares.use(SessionsMiddleware.self)
    services.register(middlewares)
    var databases = DatabasesConfig()
    var databaseConfig = PostgreSQLDatabaseConfig(
        hostname: "localhost",
        username: "syky",
        database: "queue")

    let database = PostgreSQLDatabase(config: databaseConfig)
    databases.add(database: database, as: .psql)
    services.register(databases)

    var migrations = MigrationConfig()
//    migrations.add(model: User.self, database: .psql)
//    migrations.add(model: Moto.self, database: .psql)
//    migrations.add(model: Token.self, database: .psql)
//    migrations.add(migration: AdminUser.self, database: .psql)
    services.register(migrations)

    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    config.prefer(MemoryKeyedCache.self, for: KeyedCache.self)

    services.register { container -> LeafTagConfig in
        var config = LeafTagConfig.default()
        config.use(Raw(), as: "raw")   // #raw(<myVar>) to print it as raw html in leaf vars
        return config
    }
}

