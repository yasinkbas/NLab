//
//  Middleware.swift
//  NLab
//
//  Created by yasinkbas on 10/17/20.
//

import Foundation


public protocol ErrorMiddleware: Middleware {
    static func onError(_ error: Error) -> Error
}


