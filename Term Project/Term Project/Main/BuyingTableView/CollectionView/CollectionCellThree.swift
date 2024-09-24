//
//  CollectionCellThree.swift
//  Term Project
//
//  Created by Win Yu Maung on 03/09/2024.
//

import UIKit

class CollectionCellThree: UICollectionViewCell {
    
    @IBOutlet weak var Myimage: UIImageView!
    @IBOutlet weak var TypeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow(contentView: contentView)
        layer.cornerRadius = 10
    }
    
}
