//
//  ViewController.swift
//  NLab
//
//  Created by yasinkbas on 07/27/2020.
//  Copyright (c) 2020 yasinkbas. All rights reserved.
//

import UIKit
import NLab

// MARK: - All
struct Post: NLResponseModel {
    struct Response: Decodable {
        let id: Int
        let title: String
        let body: String
    }
}


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


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPost(id: 5)
        listPosts()
    }
    
    func getPost(id: Int) {
        let api = PostAPI()
        let postDirector = api.get(id: id)
        postDirector.onData { post in
            print("------------- You got \(id). post -------------")
            print("\(id) -> \(post.title)\n--\(post.body)\n")
        }
        
        postDirector.start()
    }
    
    func listPosts() {
        let api = PostAPI()
        let postListDirector = api.list()
        postListDirector.onData { posts in
            // works when successfully got data
            print("------------- You got these posts -------------")
            posts.enumerated().forEach { print("\($0)-) \($1.title)\n--\($1.body)\n-------------")}
        }
        postListDirector.onError { error in
            // only works on networking or decoding error
            print(error)
        }
        postListDirector.onResponse { response in
            // response always works
            print("response worked as it's supposed to be")
        }
        postListDirector.start()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

