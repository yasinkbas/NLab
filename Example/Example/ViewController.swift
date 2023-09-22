//
//  ViewController.swift
//  Example
//
//  Created by Yasin Akbas on 22.09.2023.
//

import UIKit
import NLab

// MARK: Models
struct Post: NLResponseModel {
  struct Response: Decodable {
    let id: Int
    let title: String
    let body: String
  }
}

// MARK: Error Middleware
class ErrorHandler: ErrorMiddleware {
  static func onError(_ error: Error) -> Error {
    // if request has any error
    // this is the first place to run
    return error
  }
}

// MARK: API
class PostAPI {
  let client = NLClient(baseURL: URL(string: "https://jsonplaceholder.typicode.com/")!)
  
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

// MARK: UI
class ViewController: UIViewController {
  
  // MARK: Usage
  
  let api = PostAPI()
  
  func getPost(id: Int) {
    let postDirector = api.get(id: id)
    postDirector.onData { post in
      print("------------- Got \(id)'s post -------------")
      print("\(id) -> \(post.title)\n--\(post.body)\n")
    }
    postDirector.start()
    
    // or simpler one
    
    api.get(id: id).onData { post in
      print("------------- Got \(id)'s post -------------")
      print("\(id) -> \(post.title)\n--\(post.body)\n")
    }.start()
  }
  
  func listPosts() {
    let postListDirector = api.list()
    postListDirector.onData { posts in
      // when successfully got data and decoded without problem
      print("------------- Got posts -------------")
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getPost(id: 5)
    listPosts()
  }
}

