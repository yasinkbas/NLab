//
//  File.swift
//  
//
//  Created by Yasin Akbas on 22.04.2022.
//

import Foundation

public class AsyncHTTPDirector<Task: URLSessionTask, Output: Decodable, Request: AsyncHTTPRequest> {
    internal var client: HTTPClient
    internal var urlRequest: URLRequest
    internal var errorMiddleware: ErrorMiddleware.Type?
    internal var decoder: JSONDecoder
    internal var options: [NLClientOption]
    
    internal var request: Request?
    internal var task: Task?
    
    internal var onData: HTTPDataHandler<Output>?
    internal var onError: HTTPErrorHandler?
    internal var onResponse: HTTPResponseHandler?
    
    init(client: HTTPClient, urlRequest: URLRequest, errorMiddleware: ErrorMiddleware.Type?, decoder: JSONDecoder, options: [NLClientOption] = []) {
        self.client = client
        self.urlRequest = urlRequest
        self.errorMiddleware = errorMiddleware
        self.decoder = decoder
        self.options = options
    }
    
    /// When the request was successfully and no problem with decoding.
    @discardableResult
    public func onData(_ closure: @escaping HTTPDataHandler<Output>) -> Self {
        self.onData = closure
        return self
    }
    
    /// When there is an error on request or decoding.
    @discardableResult
    public func onError(_ closure: @escaping HTTPErrorHandler) -> Self {
        self.onError = closure
        return self
    }
    
    /// When the response is not nil
    @discardableResult
    public func onResponse(_ closure: @escaping HTTPResponseHandler) -> Self {
        self.onResponse = closure
        return self
    }
}

extension AsyncHTTPDirector where Task == DataTask {
    /// starts your request with options(default)
    /// - Parameter pure: if it is true disables options, otherwise runs options before request.
    public func start(pure: Bool = false) {
        self.request = (client.defaultTask(
            with: urlRequest,
            options: options,
            decoder: decoder,
            errorMiddleware: errorMiddleware,
            onError: onError,
            onData: onData,
            onResponse: onResponse
        ) as? Request)
        request?.start(pure: pure)
    }
}
