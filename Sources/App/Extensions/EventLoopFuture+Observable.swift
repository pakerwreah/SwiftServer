import NIO
import RxSwift

extension EventLoopFuture {
    func asObservable() -> Observable<Value> {
        Observable<Value>.create { [weak self] observable in
            self?.whenSuccess { value in
                observable.onNext(value)
            }
            self?.whenFailure { error in
                observable.onError(error)
            }
            self?.whenComplete { _ in
                observable.onCompleted()
            }
            return Disposables.create {
                self?.eventLoop.shutdownGracefully { _ in }
            }
        }
    }
}

extension Observable {
    func asFuture(eventLoop: EventLoop) -> EventLoopFuture<Element> {
        let promise = eventLoop.makePromise(of: Element.self)

        _ = subscribe(onNext: { value in
            promise.succeed(value)
        }, onError: { error in
            promise.fail(error)
        }, onCompleted: {
            promise.completeWith(promise.futureResult)
        })

        return promise.futureResult
    }
}
