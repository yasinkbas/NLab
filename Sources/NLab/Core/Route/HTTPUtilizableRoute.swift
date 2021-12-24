//
//  HTTPUtilizableRoute.swift
//  NetworkManager
//
//  Created by yasinkbas on 4.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

public protocol HTTPUtilizableRoute: HTTPBasicRoute, HTTPRequestable {   
    var options: [NLClientOption] { get set }
    var configuration: URLSessionConfiguration { get set }
    
    var and: Self { get }
}

extension HTTPUtilizableRoute {
    public var and: Self { self }
}
