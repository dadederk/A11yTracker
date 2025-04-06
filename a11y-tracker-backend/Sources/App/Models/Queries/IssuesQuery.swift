//
//  IssuesQuery.swift
//
//
//  Created by Daniel Devesa Derksen-Staats on 24/08/2024.
//

import Foundation
import Vapor

enum SortOrder: String, Content {
    case mostRecent, mostPopular
}

struct IssuesQuery: Content {
    let sortOrder: SortOrder?
}
