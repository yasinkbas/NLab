//
//  HTTPBasicRoute.swift
//  NetworkManager
//
//  Created by yasinkbas on 4.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

public protocol HTTPBasicRoute {
    var path: String                            { get set }
    var method: HTTPMethod                      { get set }
    var header: HTTPHeader?                     { get set }
    var parameters: [URLQueryItem]              { get set }
    var errorMiddleware: ErrorMiddleware.Type?  { get set }
    var authentication: NLAuthentication.Type?  { get set }
    
    func asURLRequest() -> URLRequest
}
