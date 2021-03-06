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
    ) -> NLTaskRequest {
        performOperation(options) {
            session.dataTask(with: request) { data, response, error in
                self.log(request: request)
                
                error.unwrap {
                    if let errorMiddleware = errorMiddleware {
                        onError?(errorMiddleware.onError($0))
                    } else {
                        onError?($0)
                    }
                }
                
                response.unwrap { onResponse?($0) }
                
                guard let data = data else {
                    return
                }
                do {
                    self.prettyPrint(data: data)
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
    }
    
    private func performOperation<
        Task: URLSessionTask,
        TaskOperation: HTTPRequest<Task>
    >(_ options: [NLClientOption], task: () -> Task) -> TaskOperation {
        TaskOperation.init(client: self, task: task(), options: options)
    }
    
    // <disabled> for beta version of library
//    public func downloadTask(with request: URLRequest, options: [NLClientOption], completionHandler: @escaping DownloadTaskHandler) -> NLDownloadRequest {
//        performOperation(options) {
//            session.downloadTask(with: request, completionHandler: completionHandler)
//        }
//    }
//
//    public func downloadTask(resumingData: Data, completionHandler: @escaping DownloadTaskHandler) -> NLDownloadRequest {
//        performOperation([]) {
//            session.downloadTask(withResumeData: resumingData, completionHandler: completionHandler)
//        }
//    }
//
//    public func uploadTask(with request: URLRequest, data: Data?, options: [NLClientOption], completionHandler: @escaping UploadTaskHandler) -> NLUploadRequest {
//        performOperation(options) {
//            session.uploadTask(with: request, from: data, completionHandler: completionHandler)
//        }
//    }
    
    //    public func task<T: Decodable>(with request: URLRequest, decoder: JSONDecoder = .init(), options: [ClientOption], completionHandler: @escaping (T?, Error?) -> Void) -> DefaultTaskDirector {
    //        defaultTask(with: request, options: options) { (data, response, error) in
    //            guard let data = data else {
    //                completionHandler(nil, NetworkError.dataIsNil)
    //                return
    //            }
    //            do {
    //                let result = try decoder.decode(T.self, from: data)
    //                completionHandler(result, nil)
    //            } catch {
    //                completionHandler(nil, error)
    //            }
    //        }
    //    }
}

extension NLClient: HTTPCLientLogging {}
