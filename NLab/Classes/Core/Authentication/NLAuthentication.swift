//
//  Authentication.swift
//  NetworkManager
//
//  Created by yasinkbas on 2.07.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

public protocol NLAuthentication {}

public protocol NLBaiscAuthenticationModel: NLAuthentication {
    static var key: String { get set }
}

public protocol NLAccessTokenAuthentication: NLAuthentication {
    static var accessKey: String { get set }
}

