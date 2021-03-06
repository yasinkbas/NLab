//
//  HTTPClient.swift
//  NetworkManager
//
//  Created by yasinkbas on 4.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

public protocol HTTPClient {
    var baseURL: URL { get set }
    var session: URLSession { get set }
    var authentication: NLAuthentication.Type? { get set }
    
    init(baseURL: URL, session: URLSession, authentication: NLAuthentication.Type?)
    
    func defaultTask<Output: Decodable>(with request: URLRequest, options: [NLClientOption], decoder: JSONDecoder, errorMiddleware: ErrorMiddleware.Type?, onError: HTTPErrorHandler?, onData: HTTPDataHandler<Output>?, onResponse: HTTPResponseHandler?) -> NLTaskRequest
    
    // <disabled> for beta version of library
//    func downloadTask(with request: URLRequest, options: [NLClientOption], completionHandler: @escaping DownloadTaskHandler) -> NLDownloadRequest
//    func uploadTask(with request: URLRequest, data: Data?, options: [NLClientOption], completionHandler: @escaping UploadTaskHandler) -> NLUploadRequest
}
