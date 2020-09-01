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
    internal var decoder: JSONDecoder
    internal var options: [NLClientOption]
    
    internal var request: Request?
    internal var task: Task?
    
    internal var onData: HTTPDataHandler<Output>?
    internal var onError: HTTPErrorHandler?
    internal var onResponse: HTTPResponseHandler?
    
    init(client: HTTPClient, urlRequest: URLRequest, decoder: JSONDecoder, options: [NLClientOption] = []) {
        self.client = client
        self.urlRequest = urlRequest
        self.decoder = decoder
        self.options = options
    }
    
    /// When the request was successfully and no problem with decoding.
    public func onData(_ closure: @escaping HTTPDataHandler<Output>) {
        self.onData = closure
    }
    
    /// When there is an error on request or decoding.
    public func onError(_ closure: @escaping HTTPErrorHandler) {
        self.onError = closure
    }
    
    /// When the response is not nil
    public func onResponse(_ closure: @escaping HTTPResponseHandler) {
        self.onResponse = closure
    }
}

extension HTTPDirector where Task == DataTask {
    /// starts your request with options(default)
    /// - Parameter pure: if it is true disables options, otherwise runs options before request.
    public func start(pure: Bool = false) {
        self.request = (client.defaultTask(
            with: urlRequest,
            options: options,
            decoder: decoder,
            onError: onError,
            onData: onData,
            onResponse: onResponse
        ) as? Request)
        request?.start(pure: pure)
    }
}

// <disabled> for beta version of library
//extension HTTPDirector where Task == DownloadTask {
//    /// starts your request with options(default)
//    /// - Parameter pure: if it is true disables options, otherwise runs options before request.
//    public func start() {
//        //        let request = client.downloadTask(
//        //            with: urlRequest,
//        //            options: options,
//        //            completionHandler: <#T##DownloadTaskHandler##DownloadTaskHandler##(URL?, URLResponse?, Error?) -> Void#>
//        //        )
//        //        request.start()
//    }
//}
//
//// <disabled> for beta version of library
//extension HTTPDirector where Task == UploadTask {
//    /// starts your request with options(default)
//    /// - Parameter pure: if it is true disables options, otherwise runs options before request.
//    public func start() {
//        //        let request = client.downloadTask(
//        //            with: urlRequest,
//        //            options: options,
//        //            completionHandler: <#T##DownloadTaskHandler##DownloadTaskHandler##(URL?, URLResponse?, Error?) -> Void#>
//        //        )
//        //        request.start()
//    }
//}

