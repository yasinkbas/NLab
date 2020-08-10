//
//  DefaultTaskDirector.swift
//  NetworkManager
//
//  Created by yasinkbas on 4.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

protocol NLTaskRequestProtocol { }

// TODO: Add needed funtions
// TODO: move onData, onError, onResponse functions to here
// TODO: update specific to default
public class NLTaskRequest: HTTPRequest<DataTask>, NLTaskRequestProtocol {
    // <disabled> for beta version of library
//    func onData() {
//        guard let task = task as? URLSessionDataTask else { return }
//        
//    }
    
//    public var onData: OptionalDataHandler<Output> = nil
//    
//    init(client: Client, task: Task, output: Output.Type, options: [ClientOption] = []) {
//        super.init(client: client, task: task, options: options)
//    }
//    
//    required init(client: Client, task: Task, options: [ClientOption] = []) {
//        fatalError("init(client:task:options:) has not been implemented")
//    }
    
}
