import Vapor
import RxSwift
import NIOTransportServices

class UserController {
    private static let eventLoop = NIOTSEventLoopGroup()

    class func getUsers(_ req: Request) -> EventLoopFuture<[User]> {
        UserRepository.getAll().asFuture(eventLoop: eventLoop.next())
    }

    class func getRandomUsers(_ req: Request) -> EventLoopFuture<[User]> {
        RandomUsersAPI.get(count: 5).asFuture(eventLoop: eventLoop.next())
    }

    class func getCombinedUsers(_ req: Request) -> EventLoopFuture<[User]> {
        Observable.combineLatest(
            UserRepository.getAll(),
            RandomUsersAPI.get(count: 3)
        ).map { $0 + $1 }.asFuture(eventLoop: eventLoop.next())
    }
}
