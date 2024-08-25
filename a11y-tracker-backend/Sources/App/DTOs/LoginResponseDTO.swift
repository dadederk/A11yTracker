//
//  LoginResponseDTO.swift
//
//
//  Created by Dani on 25/08/2024.
//

import Foundation
import Vapor

struct LoginResponseDTO: Content {
    let token: String?
    let userId: UUID
}
