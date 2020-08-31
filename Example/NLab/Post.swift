//
//  Post.swift
//  NLab_Example
//
//  Created by yasinkbas on 31.08.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import NLab

struct Post: NLResponseModel {
    struct Response: Decodable {
        let id: Int
        let title: String
        let body: String
    }
}
