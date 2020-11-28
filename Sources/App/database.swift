import PostgresKit

class Database {
    typealias ConnectionPool = EventLoopGroupConnectionPool<PostgresConnectionSource>

    private static var instance: Database?

    private let eventLoopGroup: EventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
    private let pool: ConnectionPool

    class var pool: ConnectionPool {
        if instance == nil {
            instance = Database()
        }
        return instance!.pool
    }

    private init() {
        let source = PostgresConnectionSource(
            configuration: .init(
                hostname: "localhost",
                username: "postgres",
                password: "postgres",
                database: "mydb"
            )
        )
        pool = EventLoopGroupConnectionPool(source: source, on: eventLoopGroup)
    }

    deinit {
        pool.shutdown()
        try? eventLoopGroup.syncShutdownGracefully()
    }
}
