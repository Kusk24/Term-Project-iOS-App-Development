//
//  CollectionCellFour.swift
//  Term Project
//
//  Created by Win Yu Maung on 24/09/2024.
//

import UIKit

class CollectionCellFour: UICollectionViewCell {
    @IBOutlet weak var Myimages: UIImageView!
    @IBOutlet weak var Brand
    : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow(contentView: contentView)
        layer.cornerRadius = 10
    }
}
