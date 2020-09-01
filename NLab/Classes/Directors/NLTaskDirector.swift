//
//  DefaultDirector.swift
//  NetworkManager
//
//  Created by yasinkbas on 3.07.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

protocol NLTaskDirectorProtocol {
    
}

public final class NLTaskDirector<Output: Decodable, Body: Encodable>: HTTPDirector<DataTask, Output, NLTaskRequest>, NLTaskDirectorProtocol {}
