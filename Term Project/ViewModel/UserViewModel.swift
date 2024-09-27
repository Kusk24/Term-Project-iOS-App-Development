//
//  UserViewModel.swift
//  Term Project
//
//  Created by Win Yu Maung on 27/09/2024.
//

import Foundation

class UserViewModel {
    private let keychainService: KeychainService
    private(set) var currentUser: User?
    
    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }
    
    // Save a new user
    func signupUser(username: String, email: String, password: String) throws {
        let newUser = User(username: username, email: email, password: password)
        try keychainService.saveUser(newUser)
        currentUser = newUser
    }
    
    // Login user by username and password
    func loginUser(username: String, password: String) -> Bool {
        guard let user = try? keychainService.retrieveUser(username: username) else {
            return false
        }
        
        if user.password == password {
            currentUser = user
            return true
        }
        return false
    }
    
    // Update user password
    func updateUserPassword(username: String, newPassword: String) throws {
        try keychainService.updatePassword(for: username, newPassword: newPassword)
    }
    
    func updateUserEmail(username: String, newEmail: String) throws {
        try keychainService.updateEmail(for: username, newEmail: newEmail)
    }
    
    // Check if the username is available
    func isUsernameAvailable(username: String) -> Bool {
        return !keychainService.userExists(username: username)
    }
    
    // Check if email matches username
    func doesEmailMatch(username: String, email: String) -> Bool {
        return keychainService.emailMatches(username: username, email: email)
    }
}
