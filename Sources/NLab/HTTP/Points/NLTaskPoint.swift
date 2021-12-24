//
//  NLTaskPoint.swift
//  NetworkManager
//
//  Created by yasinkbas on 3.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

// TODO: move these associate fields to base protocol EndpointProtocol
// TODO: change resulthandler as onData(data:,result: -> ()) & onError(error: -> ())
protocol NLTaskPointProtocol {
    associatedtype Body: Encodable
    associatedtype Output: Decodable
    
    var decoder: JSONDecoder { get set }
    var encoder: JSONEncoder { get set }
    var body: Body? { get set }

    var authentication: NLAuthentication.Type? { get set }
    var content: NLContentType { get set }
    
    func decoder(_ decoder: JSONDecoder) -> Self
    func encoder(_ encoder: JSONEncoder) -> Self
    func body(_ body: Body) -> Self
    func authentication(_ authentication: NLAuthentication.Type) -> Self
    func content(_ content: NLContentType) -> Self

}

public final class NLTaskPoint<Output: Decodable, Body: Encodable>: NLPoint, NLTaskPointProtocol {
    var decoder: JSONDecoder = JSONDecoder()
    var encoder: JSONEncoder = JSONEncoder()
    var bodyEncoder: JSONEncoder = JSONEncoder()
    var body: Body?
    var authentication: NLAuthentication.Type?
    var content: NLContentType = .json
    
    var onData: HTTPDataHandler<Output>? = nil
    var onError: HTTPErrorHandler? = nil
    var onResponse: HTTPResponseHandler? = nil
    
    public func decoder(_ decoder: JSONDecoder) -> Self {
        self.decoder = decoder
        return self
    }
    
    public func encoder(_ encoder: JSONEncoder) -> Self {
        self.encoder = encoder
        return self
    }
    
    public func bodyEncoder(_ encoder: JSONEncoder) -> Self {
        self.bodyEncoder = encoder
        return self
    }
    
    public func body(_ body: Body) -> Self {
        self.body = body
        return self
    }
    
    public func authentication(_ authentication: NLAuthentication.Type) -> Self {
        self.authentication = authentication
        return self
    }
    
    public func content(_ content: NLContentType) -> Self {
        self.content = content
        return self
    }
    
    func onData(_ onData: @escaping HTTPDataHandler<Output>) -> Self {
        self.onData = onData
        return self
    }
    
    func onError(_ onError: @escaping HTTPErrorHandler) -> Self {
        self.onError = onError
        return self
    }
    
    func onResponse(_ onResponse: @escaping HTTPResponseHandler) -> Self {
        self.onResponse = onResponse
        return self
    }
    
    public func build() -> NLTaskRoute<Output, Body> {
        NLTaskRoute(
            path: self.path ,
            client: self.client,
            method: self.method,
            header: self.header,
            options: self.options,
            parameters: self.parameters,
            errorMiddleware: self.errorMiddleware,
            configuration: self.configuration,
            authentication: self.authentication,
            contentType: self.content,
            decoder: self.decoder,
            encoder: self.encoder,
            bodyEncoder: self.bodyEncoder,
            body: self.body,
            onData: self.onData,
            onError: self.onError,
            onResponse: self.onResponse
        )
    }
}
