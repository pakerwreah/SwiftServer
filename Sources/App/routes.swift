import Vapor

func routes(_ app: Application) throws {

    app.group("users") { group in
        group.get(use: UserController.getUsers)
        group.get("random", use: UserController.getRandomUsers)
        group.get("combined", use: UserController.getCombinedUsers)
    }

}
