//
//  Decoders.swift
//  NetworkManager
//
//  Created by yasinkbas on 2.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

enum Decoder {
    case `default`
    
    var decoder: JSONDecoder {
        switch self {
        case .default: return JSONDecoder()
        }
    }
}
