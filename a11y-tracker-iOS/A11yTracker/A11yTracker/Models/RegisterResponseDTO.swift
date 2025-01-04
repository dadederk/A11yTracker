//
//  RegisterResponseDTO.swift
//  A11yTracker
//
//  Created by Dani on 26/08/2024.
//

import Foundation

struct RegisterResponseDTO: Codable {
    //TODO: Should this be a Result enum?
    let error: Bool
    var reason: String? = nil
}
