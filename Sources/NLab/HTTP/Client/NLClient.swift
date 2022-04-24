//
//  HTTPClient.swift
//  NetworkManager
//
//  Created by yasinkbas on 26.05.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

open class NLClient: HTTPClient {
    public var baseURL: URL
    public var session: URLSession
    public var authentication: NLAuthentication.Type?
    
    required public init(baseURL: URL, session: URLSession = .shared, authentication: NLAuthentication.Type? = nil) {
        self.baseURL = baseURL
        self.session = session
        self.authentication = authentication
    }
    
    convenience init(baseURL: URL, configuration: URLSessionConfiguration, authentication: NLAuthentication.Type? = nil) {
        self.init(baseURL: baseURL, session: URLSession.init(configuration: configuration), authentication: authentication)
    }
    
    convenience init(baseURL: String, configuration: URLSessionConfiguration = .default, authentication: NLAuthentication.Type? = nil) {
        self.init(baseURL: URL(string: baseURL)!, configuration: configuration, authentication: authentication)
    }
    
    public func defaultTask<Output: Decodable>(
        with request: URLRequest,
        options: [NLClientOption],
        decoder: JSONDecoder = JSONDecoder(),
        errorMiddleware: ErrorMiddleware.Type?,
        onError: HTTPErrorHandler?,
        onData: HTTPDataHandler<Output>?,
        onResponse: HTTPResponseHandler?
    ) {
        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log(request: request)
            
            error.unwrap {
                if let errorMiddleware = errorMiddleware {
                    onError?(errorMiddleware.onError($0))
                } else {
                    onError?($0)
                }
            }
            
            response.unwrap { onResponse?($0) }
            
            guard let data = data else { return }
            
            do {
                self?.prettyPrint(data: data)
                let resultData = try decoder.decode(Output.self, from: data)
                onData?(resultData)
            } catch {
                if let errorMiddleware = errorMiddleware {
                    onError?(errorMiddleware.onError(error))
                } else {
                    onError?(error)
                }
            }
        }
    }
    
    @available(iOS 15, *)
    public func asyncDefaultTask<Output: Decodable>(
        with request: URLRequest,
        options: [NLClientOption],
        decoder: JSONDecoder = JSONDecoder(),
        errorMiddleware: ErrorMiddleware.Type?,
        onError: HTTPErrorHandler?,
        onData: HTTPDataHandler<Output>?,
        onResponse: HTTPResponseHandler?
    ) async -> Output? {
        log(request: request)
        do {
            let (data, response) = try await session.data(for: request)
            onResponse?(response)
            prettyPrint(data: data)
            let resultData = try decoder.decode(Output.self, from: data)
            onData?(resultData)
            return resultData
        } catch {
            if let errorMiddleware = errorMiddleware {
                onError?(errorMiddleware.onError(error))
            } else {
                onError?(error)
            }
        }
        return nil
    }
}

extension NLClient: HTTPCLientLogging {}
