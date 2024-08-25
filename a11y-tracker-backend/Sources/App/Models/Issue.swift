//
//  Issue.swift
//  
//
//  Created by Daniel Devesa Derksen-Staats on 24/08/2024.
//

import Foundation
import Fluent
import Vapor

final class Issue: Model, Content {
    static let schema: String = "issues"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    init() {}
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
