//
//  NLDownloadPoint.swift
//  NetworkManager
//
//  Created by yasinkbas on 3.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

// <disabled> for beta version of library
//protocol NLDownloadPointProtocol {
//    associatedtype Input = Encodable
//    
//    var decoder: JSONDecoder { get set }
//    var encoder: JSONEncoder { get set }
//    var bodyEncoder: JSONEncoder { get set }
//    var body: Input? { get set }
//    var resultHandler: DownloadTaskHandler? { get set }
//    
//    func decoder(_ decoder: JSONDecoder) -> Self
//    func encoder(_ encoder: JSONEncoder) -> Self
//    func bodyEncoder(_ encoder: JSONEncoder) -> Self
//    func body(_ body: Input) -> Self
//    func resultHandler(_ handler: @escaping DownloadTaskHandler) -> Self
//}
//
//// TODO: update specific to download
//public final class NLDownloadPoint: NLPoint, NLDownloadPointProtocol, HTTPRoutable {
//    var decoder: JSONDecoder = JSONDecoder()
//    var encoder: JSONEncoder = JSONEncoder()
//    var bodyEncoder: JSONEncoder = JSONEncoder()
//    var body: Input?
//    var resultHandler: DownloadTaskHandler?
//    
//    func decoder(_ decoder: JSONDecoder) -> Self {
//        self.decoder = decoder
//        return self
//    }
//    
//    func encoder(_ encoder: JSONEncoder) -> Self {
//        self.encoder = encoder
//        return self
//    }
//    
//    func bodyEncoder(_ encoder: JSONEncoder) -> Self {
//        self.bodyEncoder = encoder
//        return self
//    }
//    
//    func body(_ body: Encodable) -> Self {
//        self.body = body
//        return self
//    }
//    
//    func resultHandler(_ handler: @escaping DownloadTaskHandler) -> Self {
//        self.resultHandler = handler
//        return self
//    }
//    
//    func build() -> NLDownloadRoute {
//        NLDownloadRoute(
//            path: self.path ,
//            client: self.client,
//            method: self.method,
//            header: self.header,
//            options: self.options,
//            parameters: self.parameters,
//            configuration: self.configuration,
//            decoder: self.decoder,
//            encoder: self.encoder,
//            bodyEncoder: self.bodyEncoder,
//            body: self.body,
//            resultHandler: self.resultHandler
//        )
//    }
//}
