//
//  DefaultDirector.swift
//  NetworkManager
//
//  Created by yasinkbas on 3.07.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

protocol NLTaskDirectorProtocol {
    
}

// TODO: update specific to default
// Default director
public final class NLTaskDirector<Output: Decodable, Body: Encodable>: HTTPDirector<DataTask, Output, NLTaskRequest>, NLTaskDirectorProtocol {
    // <disabled> for beta version of library
//    public func start() {
//        let request = client.defaultTask(
//            with: urlRequest,
//            options: options,
//            decoder: decoder,
//            onError: onError,
//            onData: onData,
//            onResponse: onResponse
//        )
//        request.start()
//    }
}
