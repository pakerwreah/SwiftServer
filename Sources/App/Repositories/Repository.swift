import Foundation

protocol Repository {
    static var db: Database.ConnectionPool { get }
}

extension Repository {
    static var db: Database.ConnectionPool {
        return Database.pool
    }
}
