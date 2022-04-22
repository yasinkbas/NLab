//
//  HTTPDirector.swift
//  NetworkManager
//
//  Created by yasinkbas on 3.07.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

public class HTTPDirector<Task: URLSessionTask, Output: Decodable, Request: HTTPRequest<Task>> {
    internal var client: HTTPClient
    internal var urlRequest: URLRequest
    internal var errorMiddleware: ErrorMiddleware.Type?
    internal var decoder: JSONDecoder
    internal var options: [NLClientOption]
    
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

extension HTTPDirector where Task == DataTask {
    /// starts your request with options(default)
    /// - Parameter pure: if it is true disables options, otherwise runs options before request.
    public func start(pure: Bool = false) {
        let request = (client.defaultTask(
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
    
    @available(iOS 15, *)
    public func startAsync() async {
        await (client.asyncDefaultTask(
            with: urlRequest,
            options: options,
            decoder: decoder,
            errorMiddleware: errorMiddleware,
            onError: onError,
            onData: onData,
            onResponse: onResponse
        ))
    }
}

