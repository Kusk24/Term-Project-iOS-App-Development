//
//  FavoriteTableCell.swift
//  Term Project
//
//  Created by Win Yu Maung on 05/09/2024.
//

import UIKit

class FavoriteTableCell: UITableViewCell {
    
    @IBOutlet weak var MyImage: UIStackView!
    @IBOutlet weak var Brand: UILabel!
    @IBOutlet weak var Model: UILabel!
    @IBOutlet weak var Year: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var FavoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
