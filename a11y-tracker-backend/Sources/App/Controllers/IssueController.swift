//
//  IssueController.swift
//
//
//  Created by Daniel Devesa Derksen-Staats on 24/08/2024.
//

import Foundation
import Vapor

struct IssueController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let issue = routes.grouped("issue")
        
        issue.get(":id", use: index)
        issue.grouped(AuthMiddleware()).post(use: create)
        issue.grouped(AuthMiddleware()).put(use: update)
        issue.grouped(AuthMiddleware()).delete(":id", use: delete)
    }
    
    @Sendable
    func index(req: Request) async throws -> Issue {
        guard let issue = try await Issue.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        return issue
    }
    
    @Sendable
    func create(req: Request) async throws -> Issue {
        let issue = try req.content.decode(Issue.self)
        try await issue.save(on: req.db)
        return issue
    }
    
    @Sendable
    func update(req: Request) async throws -> Issue {
        let updatedIssue = try req.content.decode(Issue.self)
        
        guard let issue = try await Issue.find(updatedIssue.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        issue.title = updatedIssue.title
        
        try await issue.update(on: req.db)
        
        return issue
    }
    
    @Sendable
    func delete(req: Request) async throws -> Issue {
        guard let issue = try await Issue.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await issue.delete(on: req.db)
        
        return issue
    }
}
