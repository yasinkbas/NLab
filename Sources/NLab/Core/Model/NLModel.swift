//
//  Model.swift
//  NetworkManager
//
//  Created by yasinkbas on 2.07.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

/// Base Model
public protocol NLModel {}

/// Request model that requires a request field that implements encodable
public protocol NLRequestModel: NLModel {
    associatedtype Request: Encodable
}

/// Response model that requires a response field that implements decodable
public protocol NLResponseModel: NLModel {
    associatedtype Response: Decodable
}

/// Model that implements RequestModel and ResponseModel
public protocol NLComprehensiveModel: NLRequestModel & NLResponseModel {}
