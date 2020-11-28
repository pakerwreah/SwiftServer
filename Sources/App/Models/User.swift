import Vapor

struct User: Content {
    let id: Int
    let name: String
    let email: String
    let active: Bool
}
