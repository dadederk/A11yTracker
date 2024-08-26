//
//  Issue.swift
//  A11yTracker
//
//  Created by Dani on 26/08/2024.
//

import Foundation
import SwiftData

@Model
final class Issue {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
