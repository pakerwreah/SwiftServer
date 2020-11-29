import PostgresKit
import RxSwift

class UserRepository: Repository {
    class func getAll() -> Observable<[User]> {
        db.withConnection { con in
            con.query("SELECT * FROM users WHERE active = $1", [true]).flatMapEachCompactThrowing { row in
                guard
                    let id = row.column("id")?.int,
                    let name = row.column("name")?.string,
                    let email = row.column("email")?.string,
                    let active = row.column("active")?.bool
                    else { return nil }

                return User(id: id, name: name, email: email, active: active)
            }
        }.asObservable()
    }
}
