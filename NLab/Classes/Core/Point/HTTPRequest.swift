//
//  HTTPRequest.swift
//  NetworkManager
//
//  Created by yasinkbas on 3.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

protocol EndpointProtocol: class {
    var path: String { get set }
    var client: Client { get set }
    var method: HTTPMethod { get set }
    var header: HeaderProvider { get set }
    var options: [ClientOption] { get set }
    var parameters: [URLQueryItem] { get set }
    var configuration: URLSessionConfiguration { get set }
    
    func path(_ path: String) -> Self
    func method(_ method: HTTPMethod) -> Self
    func header(_ header: HeaderProvider) -> Self
    func addParameter(_ parameter: URLQueryItem) -> Self
    func addOptions(_ options: [ClientOption]) -> Self
    func configure(configuration: (URLSessionConfiguration) -> ()) -> Self
}

class Endpoint: EndpointProtocol {
    var path: String
    var client: Client
    var method: HTTPMethod
    var header: HeaderProvider
    var options: [ClientOption]
    var parameters: [URLQueryItem]
    var configuration: URLSessionConfiguration
    
    init(
        client: Client,
        path: String = "",
        method: HTTPMethod = .get,
        header: HeaderProvider = [],
        options: [ClientOption] = [],
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
    
    func path(_ path: String) -> Self {
        self.path = path
        return self
    }
    
    func method(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func header(_ header: HeaderProvider) -> Self {
        self.header = header
        return self
    }
    
    func addOptions(_ options: [ClientOption]) -> Self {
        self.options = options
        return self
    }
    
    func addParameter(_ parameter: URLQueryItem) -> Self {
        self.parameters.append(parameter)
        return self
    }
    
    func configure(configuration: (URLSessionConfiguration) -> ()) -> Self {
        configuration(self.configuration)
        return self
    }
}
