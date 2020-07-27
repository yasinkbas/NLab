//
//  HTTPRoutable.swift
//  
//
//  Created by yasinkbas on 3.06.2020.
//

protocol HTTPRoutable {
    associatedtype Route: HTTPUtilizableRoute
    
    func build() -> Route
}
