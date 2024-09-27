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


func setupShadow(contentView: UIView) {
    // Set content view corner radius
    contentView.layer.cornerRadius = 10
    
    // Shadow settings
    contentView.layer.shadowColor = UIColor.black.cgColor
    contentView.layer.shadowOpacity = 0.325
    contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
    contentView.layer.shadowRadius = 4
    contentView.layer.masksToBounds = false
    
    // Add rounded corners
    contentView.layer.cornerRadius = 10
}

func checkFavorite(myButton: UIButton, id: Int, username: String) {
    let favCars = FavoriteViewModel.shared.getFavorites(username: username)
    let isFavorite = favCars.contains(where: { $0.car.id == id })
    
    if isFavorite {
        myButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    } else {
        myButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}

