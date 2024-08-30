//
//  A11yTrackerDataStore.swift
//  A11yTracker
//
//  Created by Dani on 26/08/2024.
//

import Foundation

class A11yTrackerDataStore: ObservableObject {
    let httpClient = HttpClient()
    
    //TODO: Manage request objects and parameters differently
    //TODO: Return Result enum
    func register(username: String, password: String) async throws -> Bool {
        guard let url = Constants.Endpoint.register else {
            fatalError("Invalid register url")
        }
        let registerData = ["username": username, "password": password]
        let resource = try Resource(url: url, method: .post(JSONEncoder().encode(registerData)), type: RegisterResponseDTO.self)
        let registerResponseDTO = try await httpClient.load(resource)
        return !registerResponseDTO.error
    }
    
    func login(username: String, password: String) async throws -> LoginResponseDTO {
        guard let url = Constants.Endpoint.login else {
            throw NetworkError.badRequest
        }
        let loginData = ["username": username, "password": password]
        let resource = try Resource(url: url, method: .post(JSONEncoder().encode(loginData)), type: LoginResponseDTO.self)
        let loginResponseDTO = try await httpClient.load(resource)
        return loginResponseDTO
    }
}
