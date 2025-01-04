//
//  User.swift
//
//
//  Created by Dani on 25/08/2024.
//

import Foundation
import Fluent
import Vapor

final class User: Model, Content, Validatable, @unchecked Sendable {
    static let schema: String = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    init() {}
    
    init(id: UUID? = nil, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
    
    static func validations(_ validations: inout Vapor.Validations) {
        validations.add("username", as: String.self, is: !.empty, required: true, customFailureDescription: "UsernameEmpty")
        validations.add("password", as: String.self, is: !.empty, required: true, customFailureDescription: "PasswordEmpty")
        
        validations.add("password", as: String.self, is: .count(8...16), customFailureDescription: "PasswordNotWithinLenghtRequirements")
    }
}
