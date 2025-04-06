//
//  AuthPayload.swift
//
//
//  Created by Dani on 25/08/2024.
//

import Foundation
import JWTKit

struct AuthPayload: JWTPayload {
    enum CodingKeys: String, CodingKey {
        case subject = "sub"
        case expiration = "exp"
        case userId = "uuid"
    }
    
    var subject: SubjectClaim
    var expiration: ExpirationClaim
    var userId: UUID
    
    func verify(using algorithm: some JWTKit.JWTAlgorithm) async throws {
        try self.expiration.verifyNotExpired()
    }
}
