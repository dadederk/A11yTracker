//
//  File.swift
//  
//
//  Created by Dani on 25/08/2024.
//

import Foundation
import Vapor

struct RegisterResponseDTO: Content {
    //TODO: Should this be a Result enum?
    let error: Bool
    var reason: String? = nil
}
