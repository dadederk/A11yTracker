//
//  IssuesController.swift
//
//
//  Created by Daniel Devesa Derksen-Staats on 24/08/2024.
//

import Foundation
import Vapor

struct IssuesController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let issues = routes.grouped("issues")
        
        issues.get(use: self.index)
        issues.get(":appId", use: index)
    }
    
    @Sendable
    func index(req: Request) async throws -> [Issue] {
        let appId = req.parameters.get("appId")
        let issuesQuery = try req.query.decode(IssuesQuery.self)
        
        var forAppId = ""
        
        if let appId = appId {
            forAppId = " for \(appId)"
        }
        
        if let sortOrder = issuesQuery.sortOrder {
            switch sortOrder {
                
            case .mostRecent:
                return [
                    Issue(title: "The most recent\(forAppId)"),
                    Issue(title: "The second most recent\(forAppId)"),
                ]
            case .mostPopular:
                return [
                    Issue(title: "The most popular\(forAppId)"),
                    Issue(title: "The second most popular\(forAppId)"),
                ]
            }
        }
        
        return try await Issue.query(on: req.db).all()
    }
}
