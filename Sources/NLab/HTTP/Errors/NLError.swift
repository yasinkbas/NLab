//
//  NLError.swift
//  NetworkManager
//
//  Created by yasinkbas on 26.05.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

public protocol NLError: Error {
    var checkInternet: String { get }
    var invalidResponse: String { get }
    var invalidData: String { get }
}


