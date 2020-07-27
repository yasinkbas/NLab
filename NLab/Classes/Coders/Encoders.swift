//
//  Encoders.swift
//  NetworkManager
//
//  Created by yasinkbas on 2.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

enum Encoder {
    case `default`
    
    var encoder: JSONEncoder {
        switch self {
        case .default: return JSONEncoder()
        }
    }
}
