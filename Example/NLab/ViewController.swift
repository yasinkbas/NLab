//
//  ViewController.swift
//  NLab
//
//  Created by yasinkbas on 07/27/2020.
//  Copyright (c) 2020 yasinkbas. All rights reserved.
//

import UIKit
import NLab

class ViewController: UIViewController {
    
    var api: PostAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = PostAPI()
        
        getPost(id: 5)
        listPosts()
    }
    
    func getPost(id: Int) {
        let postDirector = api.get(id: id)
        postDirector.onData { post in
            print("------------- You got \(id). post -------------")
            print("\(id) -> \(post.title)\n--\(post.body)\n")
        }
        
        postDirector.start()
    }
    
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

