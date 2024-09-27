//
//  KeyChainService.swift
//  Term Project
//
//  Created by Win Yu Maung on 27/09/2024.
//
import Foundation
import KeychainAccess

class KeychainService {
    private let keychain: Keychain
    
    init(service: String) {
        keychain = Keychain(service: service)
    }
    
    // Save user credentials
    func saveUser(_ user: User) throws {
        try keychain.set(user.password, key: user.username)
        try keychain.set(user.email, key: "email-\(user.username)")
    }
    
    // Retrieve user by username
    func retrieveUser(username: String) throws -> User? {
        if let password = try keychain.get(username),
           let email = try keychain.get("email-\(username)") {
            return User(username: username, email: email, password: password)
        }
        return nil
    }
    
    // Update user password
    func updatePassword(for username: String, newPassword: String) throws {
        try keychain.set(newPassword, key: username)
    }
    
    // Delete user
    func deleteUser(username: String) throws {
        try keychain.remove(username)
        try keychain.remove("email-\(username)")
    }
    
    // Check if user exists
    func userExists(username: String) -> Bool {
        return (try? keychain.get(username)) != nil
    }
    
    // Check if email matches username
    func emailMatches(username: String, email: String) -> Bool {
        guard let storedEmail = try? keychain.get("email-\(username)") else { return false }
        return storedEmail == email
    }
    
    func updateEmail(for username: String, newEmail: String) throws {
        try keychain.set(newEmail, key: username)
    }
}
