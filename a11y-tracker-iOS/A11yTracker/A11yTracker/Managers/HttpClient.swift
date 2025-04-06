//
//  HttpClient.swift
//  A11yTracker
//
//  Created by Dani on 26/08/2024.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case invalidResponse
    case invalidData
}

enum HttpMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    case put(Data?)
    
    var name: String {
        switch self {
        case .get(_): "GET"
        case .post(_): "POST"
        case .delete: "DELETE"
        case .put(_): "PUT"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HttpMethod
    var type: T.Type
}

struct HttpClient {
    //TODO: Break this down
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        let url = resource.url
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        let session = URLSession(configuration: configuration)
        let decoder = JSONDecoder()
        var request = URLRequest(url: url)
        request.httpMethod = resource.method.name
        
        switch resource.method {
        case .get(let queryItems):
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                throw NetworkError.badRequest
            }
            request = URLRequest(url: url)
        case .post(let data):
            request.httpBody = data
        case .delete: break
        case .put(_): break
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let _ = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        //TODO: Handle HTTP codes (409 confict error, 500 unauthorized...)
        guard let result = try? decoder.decode(resource.type, from: data) else {
            throw NetworkError.invalidData
        }
        
        return result
    }
}
