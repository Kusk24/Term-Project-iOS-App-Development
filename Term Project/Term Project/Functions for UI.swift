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

