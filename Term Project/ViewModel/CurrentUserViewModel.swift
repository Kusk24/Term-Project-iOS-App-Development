//
//  CurrentUser.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/09/2024.
//

import Foundation

class CurrentUserViewModel {
    
    static let shared = CurrentUserViewModel()
    
    private let userDefaultsKey = "CurrentUser"

    func saveCurrentUser(_ user: currentUser) {
        let userDict: [String: Any] = [
            "isLoggedIn": user.isLoggedIn,
            "username": user.username ?? ""
        ]
        
        UserDefaults.standard.set(userDict, forKey: userDefaultsKey)
    }
    
    func loadCurrentUser() -> currentUser {
        if let userDict = UserDefaults.standard.dictionary(forKey: userDefaultsKey) {
            let isLoggedIn = userDict["isLoggedIn"] as? Bool ?? false
            let username = userDict["username"] as? String
            return currentUser(isLoggedIn: isLoggedIn, username: username)
        }
        return currentUser(isLoggedIn: false, username: nil) // Return default User if no data is found
    }
    
    func unsaveCurrentUser() {
        saveCurrentUser(currentUser(isLoggedIn: false, username: nil))
    }
}
