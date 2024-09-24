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
    func saveFavorites(favCars: [Car], username: String) {
        let key = "favCars_\(username)"  // Create a unique key based on the username
        if let encodedData = try? JSONEncoder().encode(favCars) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
    
    // Retrieve favorites for a specific user
    func getFavorites(username: String) -> [Car] {
        let key = "favCars_\(username)"  // Retrieve using the unique key
        if let data = UserDefaults.standard.data(forKey: key),
           let favCars = try? JSONDecoder().decode([Car].self, from: data) {
            return favCars
        }
        return []
    }
    
    // Check if a specific car is a favorite for a specific user
    func isFavorite(id: Int, username: String) -> Bool {
        return getFavorites(username: username).contains(where: { $0.id == id })
    }
    
    // Add a car to favorites for a specific user
    func addFavorite(id: Int, username: String) {
        var favCars = getFavorites(username: username)
        let mycar: Car = CarViewModel.shared.getCarList().first(where: { $0.id == id })!
        
        if !favCars.contains(where: { $0.id == id }) {
            favCars.append(mycar)
            saveFavorites(favCars: favCars, username: username)
            print("\(mycar.brand) added to \(username)'s favorites.")
        } else {
            print("\(mycar.brand) is already in \(username)'s favorites.")
        }
    }
    
    // Remove a car from favorites for a specific user
    func removeFavorite(id: Int, username: String) {
        var favCars = getFavorites(username: username)
        
        if let index = favCars.firstIndex(where: { $0.id == id }) {
            favCars.remove(at: index)
            saveFavorites(favCars: favCars, username: username)
        } else {
            print("Cannot remove from \(username)'s favorites.")
        }
    }
    
    // Check the favorite status and update the button for a specific user
    func checkFavorite(myButton: UIButton, id: Int, username: String) {
        let favCars = getFavorites(username: username)
        let isFavorite = favCars.contains(where: { $0.id == id })
        
        if isFavorite {
            myButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            myButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
