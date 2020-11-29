import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    app.get("users", use: UserController.getUsers)
    app.get("random", use: UserController.getRandomUsers)
    app.get("combined", use: UserController.getCombinedUsers)
}
