//
//  APIClient.swift
//  NLab
//
//  Created by yasinkbas on 10/17/20.
//

import Foundation

open class APIClient: API {
    public var client: NLClient
    
    public init(client: NLClient) {
        self.client = client
    }
}
