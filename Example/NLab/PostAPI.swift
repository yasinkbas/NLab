//
//  PostAPI.swift
//  NLab_Example
//
//  Created by yasinkbas on 31.08.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import NLab

class ErrorHandler: ErrorMiddleware {
    static func onError(_ error: Error) -> Error {
        // if request has any error
        // run this block
        return error
    }
}

class PostAPI: APIClient {
    func list() -> NLTaskDirector<[Post.Response], Empty> {
        NLTaskPoint(client: client)
            .path("posts/")
            .method(.get)
            .content(.json)
            .middleware(ErrorHandler.self)
            .build().and.direct()
    }
    
    func get(id: Int) -> NLTaskDirector<Post.Response, Empty> {
        NLTaskPoint(client: client)
            .path("posts/\(id)/")
            .method(.get)
            .content(.json)
            .middleware(ErrorHandler.self)
            .build().and.direct()
    }
}
