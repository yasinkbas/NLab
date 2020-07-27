//
//  Encodable+JSON.swift
//  NetworkManager
//
//  Created by yasinkbas on 4.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

extension Encodable {
    /// Encodes data if it can
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
