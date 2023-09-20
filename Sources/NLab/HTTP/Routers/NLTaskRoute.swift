//
//  DefaultRoute.swift
//  NetworkManager
//
//  Created by yasinkbas on 4.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

public struct NLTaskRoute<Output: Decodable, Body: Encodable>: HTTPUtilizableRoute {
    
    public var path: String
    public var client: HTTPClient
    public var method: HTTPMethod
    public var header: HTTPHeader?
    public var options: [NLClientOption]
    public var parameters: [URLQueryItem]
    public var errorMiddleware: ErrorMiddleware.Type?
    public var configuration: URLSessionConfiguration
    public var authentication: NLAuthentication.Type?
    public var contentType: NLContentType
    
    var decoder: JSONDecoder = JSONDecoder()
    var encoder: JSONEncoder = JSONEncoder()
    var bodyEncoder: JSONEncoder = JSONEncoder()
    var body: Body?
    
    var onData: HTTPDataHandler<Output>?
    var onError: HTTPErrorHandler?
    var onResponse: HTTPResponseHandler?
    
    public func asURLRequest() -> URLRequest {
        let url = URL(string: path, relativeTo: client.baseURL)
        
        guard var urlComponents = URLComponents(url: url ?? client.baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("An undetermined error occurred in url")
        }
        
        urlComponents.queryItems = self.parameters
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = self.header?.dict
        urlRequest.setValue(contentType.mime, forHTTPHeaderField: "Content-Type")

        if let httpBody = try? bodyEncoder.encode(self.body),
           self.body != nil {
            urlRequest.httpBody = httpBody
        }
        
        return urlRequest
    }
    
    public func direct() -> NLTaskDirector<Output, Body> {
        NLTaskDirector(client: client, urlRequest: asURLRequest(), errorMiddleware: errorMiddleware, decoder: decoder)
    }
}
