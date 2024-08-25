//
//  CreateIssue.swift
//
//
//  Created by Dani on 25/08/2024.
//

import Fluent

struct CreateIssue: Migration {
    func prepare(on database: any FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("issues")
            .id()
            .field("title", .string, .required)
            .create()
    }
    
    func revert(on database: any FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("issues")
            .delete()
    }
    
    
}
