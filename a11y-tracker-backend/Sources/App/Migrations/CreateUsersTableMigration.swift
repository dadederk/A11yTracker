//
//  CreateUsersTableMigration.swift
//
//
//  Created by Dani on 25/08/2024.
//

import Fluent

struct CreateUsersTableMigration: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required).unique(on: "username")
            .field("password", .string, .required)
            .create()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("users")
            .delete()
    }
}
