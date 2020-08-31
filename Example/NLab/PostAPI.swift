//
//  PostAPI.swift
//  NLab_Example
//
//  Created by yasinkbas on 31.08.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import NLab

struct PostAPI {
    let client = NLClient(baseURL: URL(string: "https://jsonplaceholder.typicode.com/")!)
    
    func list() -> NLTaskDirector<[Post.Response], Empty> {
        NLTaskPoint(client: client)
            .path("posts/")
            .method(.get)
            .content(.json)
            .build().and.direct()
    }
    
    func get(id: Int) -> NLTaskDirector<Post.Response, Empty> {
        NLTaskPoint(client: client)
            .path("posts/\(id)/")
            .method(.get)
            .content(.json)
            .build().and.direct()
    }
}
