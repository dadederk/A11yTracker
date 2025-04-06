//
//  UserController.swift
//
//
//  Created by Dani on 25/08/2024.
//

import Foundation
import Fluent
import JWTKit
import Vapor

class UserController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        routes.post("register", use: register)
        routes.post("login", use: login)
    }
    
    //TODO: Do this need to be sendable or not?
    @Sendable
    func register(req: Request) async throws -> RegisterResponseDTO {
        try User.validate(content: req)
        let registeringUser = try req.content.decode(User.self)
        
        // Check if the username is available
        if let _ = try await User.query(on: req.db)
            .filter(\.$username == registeringUser.username)
            .first() {
            throw Abort(.conflict, reason: "UsernameExists")
        }
        
        // Hash password
        registeringUser.password = try await req.password.async.hash(registeringUser.password)
        
        try await registeringUser.save(on: req.db)
        
        return RegisterResponseDTO(error: false)
    }
    
    @Sendable
    func login(req: Request) async throws -> LoginResponseDTO {
        let loggingUser = try req.content.decode(User.self)
        
        // Check if the username exists
        guard let user = try await User.query(on: req.db)
            .filter(\.$username == loggingUser.username)
            .first() else {
            throw Abort(.badRequest, reason: "UsernameDoesntExist")
        }
        
        // Validate password
        let result = try req.password.verify(loggingUser.password, created: user.password)
        
        guard result else {
            throw Abort(. unauthorized)
        }
        
        // Generate token
        //TODO: Generate secret and store it safely
        let authPayload = try AuthPayload(subject: "A11yTracker", expiration: .init(value: .distantFuture), userId: user.requireID())
        let keys = JWTKeyCollection()
        await keys.add(hmac: "secret", digestAlgorithm: .sha256)
        let jwt = try await keys.sign(authPayload)
        
        return try LoginResponseDTO(token: jwt, userId: user.requireID())
    }
}
