//
//  DownloadTaskOperation.swift
//  NetworkManager
//
//  Created by yasinkbas on 4.06.2020.
//  Copyright © 2020 Yasin Akbaş. All rights reserved.
//

import Foundation

// <disabled> for beta version of library
//protocol NLDownloadRequestProtocol {
//    func pause()
//    func resumeIfPossible()
//}
//
//// TODO: update specific to download
//public class NLDownloadRequest: HTTPRequest<DownloadTask>, NLDownloadRequestProtocol {
//    var pausedData: Data?
//    
//    func pause() {
//        task.cancel { data in
//            guard let data = data else { return }
//            self.pausedData = data
//        }
//    }
//    
//    func resumeIfPossible() {
//        guard let data = pausedData,
//            let handler = handler else { return }
//        
//        let operation = client.downloadTask(resumingData: data, completionHandler: handler)
//        self.update(with: operation)
//        self.pausedData = nil
//        self.start()
//    }
//}
