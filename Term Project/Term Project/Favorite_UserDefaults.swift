//
//  Favorite_UserDefaults.swift
//  Term Project
//
//  Created by Win Yu Maung on 05/09/2024.
//

import Foundation

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

func isFavorite(car: Car) -> Bool {
    return getFavorites().contains(where: { $0.brand == car.brand && $0.model == car.model && $0.year == car.year })
}
