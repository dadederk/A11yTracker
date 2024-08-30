//
//  UsernameUtils.swift
//  A11yTracker
//
//  Created by Dani on 26/08/2024.
//

import Foundation

struct UserUtils {
    //TODO: Return proper errors
    static func validate(username: String) -> Bool {
        let nonAlphanumericCharacters = CharacterSet.alphanumerics.inverted
        let usernameIsNotEmpty = !username.isEmpty
        let usernameHasJustAlphanumericCharacters = (username.rangeOfCharacter(from: nonAlphanumericCharacters) == nil)
        return usernameIsNotEmpty && usernameHasJustAlphanumericCharacters
    }
    
    static func validate(password: String, confirmPassword: String? = nil) -> Bool {
        let passwordHasMinimumNumberOfCharacters = password.count >= 8
        let passwordDoesNotExceedMaximum = password.count <= 16
        let passwordsMatch = passwordsMatch(password: password, confirmPassword: confirmPassword)
        return passwordHasMinimumNumberOfCharacters &&
        passwordDoesNotExceedMaximum &&
        passwordsMatch
    }
    
    private static func passwordsMatch(password: String, confirmPassword: String? = nil) -> Bool {
        guard let confirmPassword = confirmPassword else { return true }
        return password == confirmPassword
    }
}
