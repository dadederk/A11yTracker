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
        let issue = routes.grouped(AuthMiddleware()).grouped("issue")
        issue.post(use: create)
    }
    
    @Sendable
    func create(req: Request) async throws -> Issue {
        let issue = try req.content.decode(Issue.self)
        try await issue.save(on: req.db)
        return issue
    }
}
