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
struct Album: NLResponseModel {
    struct Response: Decodable {
        let id: Int
        let title: String
    }
}


struct AlbumAPI {
    let client = NLClient(baseURL: URL(string: "https://jsonplaceholder.typicode.com/")!)
    
    func list() -> NLTaskDirector<[Album.Response], Empty> {
        NLTaskPoint(client: client)
            .path("albums/")
            .method(.get)
            .content(.json)
            .build().and.direct()
    }
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = AlbumAPI()
        let listDirector = api.list()
        listDirector.onData { albums in
            // works when successfully got data
            print("You got these albums.\n")
            albums.enumerated().forEach { print("\($0)-) \($1.title)\n-------------")}
        }
        listDirector.onError { error in
            // only works on networking or decoding error
            print(error)
        }
        listDirector.onResponse { response in
            // response always works
            print("response worked as it's supposed to be")
        }
        listDirector.start()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

