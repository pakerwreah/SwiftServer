import PostgresKit
import RxSwift

class UserRepository: Repository {
    class func getAll(active: Bool? = nil) -> Observable<[User]> {
        db.withConnection { con in
            let query = con.sql().select().columns("*").from("users")
            return (active.map { query.where("active", .equal, $0) } ?? query).all(decoding: User.self)
        }.asObservable()
    }
}
