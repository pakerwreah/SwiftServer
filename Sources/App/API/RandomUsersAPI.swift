import Vapor
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
            users.map {
                User(id: 0, name: "\($0.name.title) \($0.name.first) \($0.name.last)", email: $0.email, active: false)
            }
        }
    }
}
