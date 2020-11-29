import Vapor
import RxSwift

class UserController {
    class func getUsers(_ req: Request) throws -> Observable<[User]> {
        UserRepository.getAll(
            active: try req.query.get(Bool?.self, at: "active")
        )
    }

    class func getRandomUsers(_ req: Request) -> Observable<[User]> {
        RandomUsersAPI.get(count: 5)
    }

    class func getCombinedUsers(_ req: Request) -> Observable<[User]> {
        Observable.combineLatest(
            UserRepository.getAll(),
            RandomUsersAPI.get(count: 3)
        ).map { $0 + $1 }
    }
}
