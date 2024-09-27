//
//  Favorite_UserDefaults.swift
//  Term Project
//
//  Created by Win Yu Maung on 05/09/2024.
//

import Foundation
import UIKit

class FavoriteViewModel {

    static let shared = FavoriteViewModel()
    
    // Save favorites for a specific user
    func saveFavorites(favorites: [Favorite], username: String) {
        let key = "favCars_\(username)"  // Create a unique key based on the username
        if let encodedData = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
    
    // Retrieve favorites for a specific user
    func getFavorites(username: String) -> [Favorite] {
        let key = "favCars_\(username)"  // Retrieve using the unique key
        if let data = UserDefaults.standard.data(forKey: key),
           let favorites = try? JSONDecoder().decode([Favorite].self, from: data) {
            return favorites
        }
        return []
    }
    
    // Check if a specific car is a favorite for a specific user
    func isFavorite(id: Int, username: String) -> Bool {
        return getFavorites(username: username).contains(where: { $0.car.id == id })
    }
    
    // Add a car to favorites for a specific user
    func addFavorite(id: Int, username: String) {
        var favorites = getFavorites(username: username)
        guard let mycar = CarViewModel.shared.getCarList().first(where: { $0.id == id }) else {
            print("Car not found.")
            return
        }
        
        if !favorites.contains(where: { $0.car.id == id }) {
            let newFavorite = Favorite(username: username, car: mycar)
            favorites.append(newFavorite)
            saveFavorites(favorites: favorites, username: username)
            print("\(mycar.brand) added to \(username)'s favorites.")
        } else {
            print("\(mycar.brand) is already in \(username)'s favorites.")
        }
    }
    
    // Remove a car from favorites for a specific user
    func removeFavorite(id: Int, username: String) {
        var favorites = getFavorites(username: username)
        
        if let index = favorites.firstIndex(where: { $0.car.id == id }) {
            favorites.remove(at: index)
            saveFavorites(favorites: favorites, username: username)
        } else {
            print("Cannot remove from \(username)'s favorites.")
        }
    }
}
