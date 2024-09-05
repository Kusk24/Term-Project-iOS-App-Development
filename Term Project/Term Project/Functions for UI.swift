//
//  Functions for UI.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/08/2024.
//

import Foundation
import UIKit

func addImage(textField : UITextField, img : UIImage){
    let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: img.size.width, height: img.size.height))
    imageView.image = img
    textField.leftView = imageView
    textField.leftViewMode = .always
}

//func addFavorite(mycar: Car) {
//    // Check if the car is not already in the favorite list
//    if !favCars.contains(where: { $0.brand == mycar.brand && $0.model == mycar.model && $0.year == mycar.year }) {
//        favCars.append(mycar)
//        print("\(mycar.brand) added to favorites.")
//    } else {
//        print("\(mycar.brand) is already in favorites.")
//    }
//}
//
//func removeFavorite(mycar: Car) {
//    // Find the index of the car in the favorite list
//    if let index = favCars.firstIndex(where: { $0.brand == mycar.brand && $0.model == mycar.model && $0.year == mycar.year }) {
//        favCars.remove(at: index)
//        print("\(mycar.brand) removed from favorites.")
//    } else {
//        print("\(mycar.brand) is not in favorites.")
//    }
//}
//
//func checkFavorite(myButton: UIButton, mycar: Car) {
//    // Check if the car is in the favorites list
//    let isFavorite = favCars.contains(where: { $0.brand == mycar.brand && $0.model == mycar.model && $0.year == mycar.year })
//    
//    // Update the button's image based on whether the car is a favorite
//    if isFavorite {
//        myButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//    } else {
//        myButton.setImage(UIImage(systemName: "heart"), for: .normal)
//    }
//}


func addFavorite(mycar: Car) {
    // Retrieve the current favorite cars from UserDefaults
    var favCars = getFavorites()
    
    // Check if the car is not already in the favorite list
    if !favCars.contains(where: { $0.brand == mycar.brand && $0.model == mycar.model && $0.year == mycar.year }) {
        favCars.append(mycar)
        saveFavorites(favCars: favCars)
        print("\(mycar.brand) added to favorites.")
    } else {
        print("\(mycar.brand) is already in favorites.")
    }
}

func removeFavorite(mycar: Car) {
    // Retrieve the current favorite cars from UserDefaults
    var favCars = getFavorites()
    
    // Find the index of the car in the favorite list
    if let index = favCars.firstIndex(where: { $0.brand == mycar.brand && $0.model == mycar.model && $0.year == mycar.year }) {
        favCars.remove(at: index)
        saveFavorites(favCars: favCars)
        print("\(mycar.brand) removed from favorites.")
    } else {
        print("\(mycar.brand) is not in favorites.")
    }
}

func checkFavorite(myButton: UIButton, mycar: Car) {
    // Retrieve the current favorite cars from UserDefaults
    let favCars = getFavorites()
    
    // Check if the car is in the favorites list
    let isFavorite = favCars.contains(where: { $0.brand == mycar.brand && $0.model == mycar.model && $0.year == mycar.year })
    
    // Update the button's image based on whether the car is a favorite
    if isFavorite {
        myButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    } else {
        myButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}

