//
//  Operation.swift
//  NetworkManager
//
//  Created by yasinkbas on 4.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

protocol HTTPRequestProtocol {
    associatedtype Task = URLSessionTask
    
    var task: Task { get set }
    var client: NLClient { get set }
    var options: [NLClientOption] { get set }
    
    func start(pure: Bool)
    func cancel()
    func loadOptions()
}

typealias RequestHandler = (Any?, URLResponse?, Error?) -> Void

/**
 Ensures the network task start and cancel
 */
public class HTTPRequest<Task: URLSessionTask>: HTTPRequestProtocol {
    var task: Task
    var client: NLClient
    var options: [NLClientOption]
    
//    var onError: OptionalErrorHandler = nil
////    var onData: OptionalDataHandler<Output> = nil
//    var onResponse: OptionalResponseHandler = nil
    
    var handler: RequestHandler?
    
    required init(client: NLClient, task: Task, options: [NLClientOption] = []) {
        self.client = client
        self.task = task
        self.options = options
    }
    
    /** default work with options
            parameters @pure: if true work with options else works without options
     */
    public func start(pure: Bool = false) {
        _ = pure ? nil : loadOptions()
        task.resume()
    }
    
    public func cancel() {
        task.cancel()
    }
    
    internal func loadOptions() {
        options.load(client: client)
    }
    
    func with(handler: @escaping RequestHandler) {
        self.handler = handler
    }
    
    func update(with request: HTTPRequest) {
        self.task = request.task
        self.client = request.client
        self.options = request.options
    }
}
