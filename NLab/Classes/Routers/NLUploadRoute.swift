//
//  UploadRoute.swift
//  NetworkManager
//
//  Created by yasinkbas on 4.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

// <disabled> for beta version of library
//public struct NLUploadRoute: HTTPUtilizableRoute {
//    public var path: String
//    public var data: Data?
//    public var client: HTTPClient
//    public var method: HTTPMethod
//    public var header: HTTPHeader?
//    public var options: [NLClientOption]
//    public var parameters: [URLQueryItem]
//    public var configuration: URLSessionConfiguration
//    public var authentication: NLAuthentication.Type?
//    
//    var decoder: JSONDecoder? = JSONDecoder()
//    var encoder: JSONEncoder? = JSONEncoder()
//    var bodyEncoder: JSONEncoder? = JSONEncoder()
//    var body: Encodable?
//    var resultHandler: UploadTaskHandler?
//    
//    public func asURLRequest() -> URLRequest {
//        let url = URL(string: path, relativeTo: client.baseURL)
//        
//        guard var urlComponents = URLComponents(url: url!, resolvingAgainstBaseURL: true) else {
//            fatalError("An undetermined error occurred in url")
//        }
//        
//        urlComponents.queryItems = self.parameters
//        
//        var urlRequest = URLRequest(url: urlComponents.url!)
//        urlRequest.httpMethod = self.method.rawValue
//        urlRequest.allHTTPHeaderFields = self.header?.dict
//        
//        let bodyEncoder = self.bodyEncoder ?? JSONEncoder()
//        if let httpBody = try? bodyEncoder.encode(self.body?.toJSONData()),
//            self.body != nil {
//            urlRequest.httpBody = httpBody
//        }
//        
//        return urlRequest
//    }
//    
//    func request() -> NLUploadRequest {
//        let resultHandler = self.resultHandler ?? EmptyHandler.UploadTask
//        return client.uploadTask(with: asURLRequest(), data: self.data, options: options, completionHandler: resultHandler)
//    }
//}
