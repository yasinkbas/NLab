//
//  ViewController.swift
//  NLab
//
//  Created by yasinkbas on 07/27/2020.
//  Copyright (c) 2020 yasinkbas. All rights reserved.
//

import UIKit
import NLab

// MARK: - Model

struct Post: NLResponseModel {
    struct Response: Decodable {
        let id: Int
        let title: String
        let body: String
    }
}

// MARK: - API

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

// MARK: - Controller

class ViewController: UIViewController {
    
    var api: PostAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = PostAPI()
        
        getPost(id: 5)
        listPosts()
    }
    
    // MARK: Use written api
    // testing onData
    func getPost(id: Int) {
        let postDirector = api.get(id: id)
        postDirector.onData { post in
            print("------------- You got \(id). post -------------")
            print("\(id) -> \(post.title)\n--\(post.body)\n")
        }
        
        postDirector.start()
    }
    
    // testing onData, onResponse, onError
    func listPosts() {
        let postListDirector = api.list()
        postListDirector.onData { posts in
            // when successfully got data and decoded without problem
            print("------------- You got these posts -------------")
            posts.enumerated().forEach { index, post in
                let num = index + 1
                print("\(num)-) \(post.title)\n--\(post.body)\n-------------")
            }
        }
        
        postListDirector.onError { error in
            // when something is wrong
            print(error)
        }
        
        postListDirector.onResponse { response in
            // always works both on Error and on Data
            print("response worked as it's supposed to be")
        }
        
        postListDirector.start()
    }
}

