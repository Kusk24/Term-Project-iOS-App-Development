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
    @IBOutlet weak var ViewInside: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow(contentView: contentView)
        layer.cornerRadius = 10
    
        ViewInside.layer.cornerRadius = 15
        ViewInside.layer.masksToBounds = true
    }
}
