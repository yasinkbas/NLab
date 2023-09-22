//
//  NLClientOption.swift
//  NetworkManager
//
//  Created by yasinkbas on 26.05.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

/// Custom Option implementation
public enum NLClientOption {
    case cancelOtherRequests
    
    var asURLSession: (NLClient) -> URLSession {
        return { $0.session }
    }
    
    var optionTask: (NLClient) -> Void {
        switch self {
        case .cancelOtherRequests:
            return cancelOtherRequests
        }
    }
}

extension NLClientOption {
    func cancelOtherRequests(_ client: NLClient) {
        asURLSession(client).getAllTasks { $0.forEach { $0.cancel() }}
    }
}
