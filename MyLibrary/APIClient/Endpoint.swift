//
//  Endpoint.swift
//  MyLibrary
//
//  Created by haya on 2018/11/25.
//  Copyright © 2018年 haya. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponent: URLComponents {
        var component = URLComponents(string: baseUrl)
        component?.path = path
        component?.queryItems = queryItems
        
        return component!
    }
    
    var request: URLRequest {
        return URLRequest(url: urlComponent.url!)
    }
}


