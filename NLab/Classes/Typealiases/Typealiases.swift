//
//  Typealiases.swift
//  NetworkManager
//
//  Created by yasinkbas on 26.05.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

//typealias Body = [String:Any]
//typealias Parameters = [String: Any]
//
//typealias DataErrorResult = (Data?, Error?) -> Void
//typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
//typealias DecodableResult<T: Decodable> = (T?, Error?) -> Void

import Foundation

public typealias DataTask = URLSessionDataTask
public typealias DownloadTask = URLSessionDownloadTask
public typealias UploadTask = URLSessionUploadTask

public typealias DefaultTaskHandler<T: Decodable> = (T?, URLResponse?, Error?) -> Void
public typealias DataTaskHandler = DefaultTaskHandler<Data>

public typealias UploadTaskHandler = (Data?, URLResponse?, Error?) -> Void
public typealias DownloadTaskHandler = (URL?, URLResponse?, Error?) -> Void

public typealias OptionalHTTPErrorHandler = ((Error?) -> Void)
public typealias OptionalHTTPDataHandler<T: Decodable> = ((T?) -> Void)
public typealias OptionalHTTPResponseHandler = ((URLResponse?) -> Void)

public typealias HTTPErrorHandler = ((Error) -> Void)
public typealias HTTPDataHandler<T: Decodable> = ((T) -> Void)
public typealias HTTPResponseHandler = ((URLResponse) -> Void)

enum EmptyHandler {
    static var DefaultTask: DefaultTaskHandler<Empty> {
        return { _,_,_ in }
    }
    
    static var UploadTask: UploadTaskHandler {
        return { _,_,_ in }
    }
    
    static var DownloadTask: DownloadTaskHandler {
        return { _,_,_ in }
    }
}

/// A blank codable type, use for passing generic parameter
public final class Empty {}
extension Empty: Codable {}
