//
//  NLPoint.swift
//  NetworkManager
//
//  Created by yasinkbas on 3.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

protocol NLPointProtocol: class {
    var path: String { get set }
    var client: NLClient { get set }
    var method: HTTPMethod { get set }
    var header: HTTPHeader? { get set }
    var options: [NLClientOption] { get set }
    var parameters: [URLQueryItem] { get set }
    var configuration: URLSessionConfiguration { get set }
    
    func path(_ path: String) -> Self
    func method(_ method: HTTPMethod) -> Self
    func header(_ header: HTTPHeader) -> Self
    func addParameter(_ parameter: URLQueryItem) -> Self
    func addOptions(_ options: [NLClientOption]) -> Self
    func configure(configuration: (URLSessionConfiguration) -> ()) -> Self
}

public class NLPoint: NLPointProtocol {
    var path: String
    var client: NLClient
    var method: HTTPMethod
    var header: HTTPHeader?
    var options: [NLClientOption]
    var parameters: [URLQueryItem]
    var errorMiddleware: ErrorMiddleware.Type?
    var configuration: URLSessionConfiguration
    
    public init(
        client: NLClient,
        path: String = "",
        method: HTTPMethod = .get,
        header: HTTPHeader? = nil,
        options: [NLClientOption] = [],
        parameters: [URLQueryItem] = [],
        configuration: URLSessionConfiguration = .default
    ) {
        self.client = client
        self.path = path
        self.method = method
        self.header = header
        self.options = options
        self.parameters = parameters
        self.configuration = configuration
    }
    
    public func path(_ path: String) -> Self {
        self.path = path
        return self
    }
    
    public func method(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    public func header(_ header: HTTPHeader) -> Self {
        self.header = header
        return self
    }
    
    public func middleware(_ errorMiddleware: ErrorMiddleware.Type) -> Self {
        self.errorMiddleware = errorMiddleware
        return self
    }
    
    public func addOptions(_ options: [NLClientOption]) -> Self {
        self.options = options
        return self
    }
    
    public func addParameter(_ parameter: URLQueryItem) -> Self {
        self.parameters.append(parameter)
        return self
    }
    
    public func configure(configuration: (URLSessionConfiguration) -> ()) -> Self {
        configuration(self.configuration)
        return self
    }
}
