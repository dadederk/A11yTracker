//
//  HttpClient.swift
//  A11yTracker
//
//  Created by Dani on 26/08/2024.
//

import Foundation

enum HttpMethod {
    case get([URLQueryItem])
    case post(Data?)
    
    var methodName: String {
        switch self {
        case .get(_): "GET"
        case .post(_): "POST"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HttpMethod
    var model: T
}

struct HttpClient {
    
}
