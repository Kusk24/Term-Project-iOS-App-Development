//
//  Favorite_UserDefaults.swift
//  Term Project
//
//  Created by Win Yu Maung on 05/09/2024.
//

import Foundation
import UIKit

func saveFavorites(favCars: [Car]) {
    if let encodedData = try? JSONEncoder().encode(favCars) {
        UserDefaults.standard.set(encodedData, forKey: "favCars")
    }
}

func getFavorites() -> [Car] {
    if let data = UserDefaults.standard.data(forKey: "favCars"),
       let favCars = try? JSONDecoder().decode([Car].self, from: data) {
        return favCars
    }
    return []
}

func isFavorite(id: Int) -> Bool {
    return getFavorites().contains(where: { $0.id == id})
}

func addFavorite(id: Int) {
    // Retrieve the current favorite cars from UserDefaults
    var favCars = getFavorites()
    let mycar : Car = cars.first(where: { $0.id == id})!
    
    // Check if the car is not already in the favorite list
    if !favCars.contains(where: {$0.id == id}) {
        favCars.append(mycar)
        saveFavorites(favCars: favCars)
        print("\(mycar.brand) added to favorites.")
    } else {
        print("\(mycar.brand) is already in favorites.")
    }
}

func removeFavorite(id: Int) {
    // Retrieve the current favorite cars from UserDefaults
    var favCars = getFavorites()
    
    // Find the index of the car in the favorite list
    if let index = favCars.firstIndex(where: { $0.id == id}) {
        favCars.remove(at: index)
        saveFavorites(favCars: favCars)
    } else {
        print("cannot remove")
    }
}

func checkFavorite(myButton: UIButton, id: Int) {
    // Retrieve the current favorite cars from UserDefaults
    let favCars = getFavorites()
    
    // Check if the car is in the favorites list
    let isFavorite = favCars.contains(where: { $0.id == id})
    
    // Update the button's image based on whether the car is a favorite
    if isFavorite {
        myButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    } else {
        myButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
