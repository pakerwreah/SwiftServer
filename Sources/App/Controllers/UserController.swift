import Vapor

class UserController {
    class func getUsers(_ req: Request) -> EventLoopFuture<[User]> {
        UserRepository.getAll()
    }
}
