//
//  Constants.swift
//  A11yTracker
//
//  Created by Dani on 26/08/2024.
//

import Foundation

struct Constants {
    private static let baseURL = "http://localhost:8080"
    struct Endpoint {
        static let register = URL(string: baseURL)?.appendingPathComponent("register")
        static let login = URL(string: baseURL)?.appendingPathComponent("login")
    }
}
