//
//  File.swift
//  
//
//  Created by Yasin Akbas on 22.04.2022.
//

import Foundation

protocol AsyncHTTPRequestProtocol: Request {}

public class AsyncHTTPRequest: AsyncHTTPRequestProtocol {
    var client: NLClient
    var options: [NLClientOption]
    
    var handler: RequestHandler?
    
    required init(client: NLClient, options: [NLClientOption] = []) {
        self.client = client
        self.options = options
    }

    internal func loadOptions() {
        options.load(client: client)
    }
    
    func with(handler: @escaping RequestHandler) {
        self.handler = handler
    }
    
    func update(with request: AsyncHTTPRequest) {
        self.client = request.client
        self.options = request.options
    }
    
    // TODO: start/cancel features
}
