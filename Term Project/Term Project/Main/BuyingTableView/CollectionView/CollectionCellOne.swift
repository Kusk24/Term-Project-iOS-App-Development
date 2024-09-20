//
//  CollectionCellOne.swift
//  Term Project
//
//  Created by Win Yu Maung on 02/09/2024.
//

import UIKit

class CollectionCellOne: UICollectionViewCell {
    @IBOutlet weak var Myimage: UIImageView!
    @IBOutlet weak var Brand: UILabel!
    @IBOutlet weak var Model: UILabel!
    @IBOutlet weak var Year: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var FavoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow(contentView: contentView)
        layer.cornerRadius = 10
        contentView.layer.cornerRadius = 50
        contentView.layer.masksToBounds = true
    }
    
//    func setupShadow() {
//        // Set content view corner radius
//        contentView.layer.cornerRadius = 10
//        
//        // Shadow settings
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOpacity = 0.25
//        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        contentView.layer.shadowRadius = 4
//        contentView.layer.masksToBounds = false
//        
//        // Add rounded corners
//        contentView.layer.cornerRadius = 10
//        layer.cornerRadius = 10
//    }
}
