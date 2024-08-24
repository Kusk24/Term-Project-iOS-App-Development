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
