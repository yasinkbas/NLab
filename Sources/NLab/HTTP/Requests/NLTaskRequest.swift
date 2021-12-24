//
//  DefaultTaskDirector.swift
//  NetworkManager
//
//  Created by yasinkbas on 4.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

protocol NLTaskRequestProtocol { }

public class NLTaskRequest: HTTPRequest<DataTask>, NLTaskRequestProtocol {}
