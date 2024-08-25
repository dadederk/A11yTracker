//
//  CreateIssuesTableMigration.swift
//
//
//  Created by Dani on 25/08/2024.
//

import Fluent

struct CreateIssuesTableMigration: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        return try await database.schema("issues")
            .id()
            .field("title", .string, .required)
            .create()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        return try await database.schema("issues")
            .delete()
    }
}
