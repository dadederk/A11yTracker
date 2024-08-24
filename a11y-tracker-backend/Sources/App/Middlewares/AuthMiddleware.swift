//
//  AuthMiddleware.swift
//
//
//  Created by Daniel Devesa Derksen-Staats on 24/08/2024.
//

import Foundation
import Vapor

struct AuthMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        guard let authorization = request.headers.bearerAuthorization else {
            throw Abort(.unauthorized)
        }
        return try await next.respond(to: request)
    }
}
