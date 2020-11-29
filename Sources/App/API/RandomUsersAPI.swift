import Foundation
import RxSwift
import RxCocoa

private struct Response<T: Decodable>: Decodable {
    let results: [T]
}

private struct RandomUser: Decodable {
    struct Name: Decodable {
        let title: String
        let first: String
        let last: String
    }
    let name: Name
    let email: String
}

class RandomUsersAPI {
    class func get(count: Int) -> Observable<[User]> {
        URLSession.shared.rx.data(
            request: URLRequest(url: URL(string: "https://randomuser.me/api?results=\(count)&inc=name,email")!)
        )
        .map { data in
            (try JSONDecoder().decode(Response<RandomUser>.self, from: data)).results
        }
        .map { users in
            users.map { user in
                User(id: Int.random(in: 100...200),
                     name: "\(user.name.title) \(user.name.first) \(user.name.last)",
                     email: user.email,
                     active: Bool.random())
            }
        }
    }
}
