//
// Copyright (c) Vatsal Manot
//

import Combine
import Swift

public struct SinkPublisher<P: Publisher>: Publisher {
    public typealias Output = P.Output
    public typealias Failure = P.Failure
    
    public let base = PassthroughSubject<Output, Failure>()
    public var subscription: AnyCancellable
    
    public init(publisher: P) {
        subscription = publisher.subscribe(base)
    }
    
    public func receive<S: Subscriber>(
        subscriber: S
    ) where S.Input == Output, S.Failure == Failure {
        base.receive(subscriber: subscriber)
    }
}

extension Publisher {
    public func sinkPublisher() -> SinkPublisher<Self> {
        SinkPublisher(publisher: self)
    }
}
