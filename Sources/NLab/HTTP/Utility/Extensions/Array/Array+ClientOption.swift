//
//  Array+ClientOption.swift
//  NetworkManager
//
//  Created by yasinkbas on 4.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

extension Array where Element == NLClientOption {
    /// loads option tasks of request
    /// - Parameter client: client instance
    func load(client: NLClient) {
        self.forEach { $0.optionTask(client) }
    }
}
