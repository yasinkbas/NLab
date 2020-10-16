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
    /// first add the option as case
    
    var task: (NLClient) -> Void {
        /// add your case and your function that handle case
        switch self {
        case .cancelOtherRequests:
            return cancelOtherRequests
        }
    }
    
    /// returns session
    var asURLSession: (NLClient) -> URLSession {
        return { $0.session }
    }
    
    /// Add your function
    func cancelOtherRequests(_ client: NLClient) {
        asURLSession(client).getAllTasks { tasks in tasks.forEach { $0.cancel() }}
    }
}
