//
//  LoginResponseDTO.swift
//  A11yTracker
//
//  Created by Dani on 26/08/2024.
//

import Foundation

struct LoginResponseDTO: Codable {
    let token: String?
    let userId: UUID
}
