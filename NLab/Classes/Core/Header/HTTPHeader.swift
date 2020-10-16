//
//  HeaderProvider.swift
//  NetworkManager
//
//  Created by yasinkbas on 26.05.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

public typealias HeaderDict = [String:String]

public protocol HTTPHeader {
    var dict: HeaderDict { get }
}

public protocol HTTPHeaderType {
    static func make(_ headers: [HTTPHeaderType]) -> HeaderDict
}

protocol ExpressibleByHeaderLiteral: ExpressibleByArrayLiteral, HTTPHeader { }

open class ExpressibleByHeaderLiteralClass<Type: HTTPHeaderType>: ExpressibleByHeaderLiteral {

    private var auths: [Type] = []

    public var dict: HeaderDict {
        return make(auths)
    }

    required public init(arrayLiteral auths: Type...) {
        self.auths = auths
    }
    
    public init(arrayLiteral auths: [Type]) {
        self.auths = auths
    }
    
    public convenience init(_ auths: Type...) {
        self.init(arrayLiteral: auths)
    }

    /// Ensures that the parameters entered are translated according to httpheader.
    ///  This function must be overridden.
    /// - Parameter auths: required an enum  that implements HTTPHeaderType
    /// - Returns: returns httpheader dictionary
    open func make(_ auths: [Type]) -> HeaderDict {
        return HeaderDict()
    }
}
