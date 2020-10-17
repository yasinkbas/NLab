//
//  Optional+Unwrap.swift
//  NetworkManager
//
//  Created by yasinkbas on 3.07.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

extension Optional {
    /// helper function for minimizing `if let` unwrap
    func unwrap(_ closure: (Wrapped) -> Void) {
        guard let self = self else { return }
        closure(self)
    }
}
