//
//  File.swift
//  
//
//  Created by Yasin Akbas on 26.05.2022.
//

import Foundation

protocol Request {
    var client: NLClient { get set }
    var options: [NLClientOption] { get set }
    
    func loadOptions()
}
