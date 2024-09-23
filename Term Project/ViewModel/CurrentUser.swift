//
//  CurrentUser.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/09/2024.
//

import Foundation

func saveCurrentUser(isLoggedIn: Bool, username: String?) {
    let userDict: [String: Any] = [
        "isLoggedIn": isLoggedIn,
        "username": username ?? ""
    ]
    
    UserDefaults.standard.set(userDict, forKey: "CurrentUser")
    UserDefaults.standard.synchronize() // Ensures data is saved immediately
}

func loadCurrentUser() -> (isLoggedIn: Bool, username: String?) {
    if let userDict = UserDefaults.standard.dictionary(forKey: "CurrentUser") {
        let isLoggedIn = userDict["isLoggedIn"] as? Bool ?? false
        let username = userDict["username"] as? String
        return (isLoggedIn, username)
    }
    return (false, nil) // Return default value if no data is found
}

func unsaveCurrentUser(){
    saveCurrentUser(isLoggedIn: false, username: "")
}
