//
//  CollectionCellTwo.swift
//  Term Project
//
//  Created by Win Yu Maung on 03/09/2024.
//

import UIKit

class CollectionCellTwo: UICollectionViewCell {
    
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
    }
    
}
