//
//  HTTPClientLogging.swift
//  NetworkManager
//
//  Created by yasinkbas on 4.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

protocol HTTPCLientLogging {
    func log(request: URLRequest)
    func decoderErrorLog(error: Error, data: Data)
}

extension HTTPCLientLogging {
    func decoderErrorLog(error: Error, data: Data) {
        print("\n------------------------->")
        print("!-->Decoder error: ", error)
        print("!-->Coming Data: ", prettyPrint(data: data))
        print("------------------------->\n")
    }
    
    func prettyPrint(data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
             print(String(decoding: jsonData, as: UTF8.self))
         } else {
             print("there is no json data")
         }
    }
}

extension HTTPCLientLogging where Self: HTTPClient {
    func log(request: URLRequest) {
        let urlString = request.url?.absoluteString ?? ""
        let components = NSURLComponents(string: urlString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod!)": ""
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        let host = "\(components?.host ?? "")"
        
        var requestLog = "\n---------- OUT ---------->\n"
        requestLog += "\(urlString)"
        requestLog += "\n\n"
        requestLog += "\(method) \(path)?\(query) HTTP/1.1\n"
        requestLog += "Host: \(host)\n"
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            requestLog += "\(key): \(value)\n"
        }
        
        request.httpBody.unwrap {
            let bodyString = String(data: $0, encoding: .utf8) ?? "Can't render body due to inability to be resolved in utf8"
            requestLog += "\n\(bodyString)\n"
        }
        
        requestLog += "\n------------------------->\n";
        print(requestLog)
    }
}
