//
//  SearchTableCell.swift
//  Term Project
//
//  Created by Win Yu Maung on 03/09/2024.
//

import UIKit

class SearchTableCell: UITableViewCell {

    @IBOutlet var Myimage : UIImageView!
    @IBOutlet var Brand: UILabel!
    @IBOutlet var Model: UILabel!
    @IBOutlet var Price: UILabel!
    @IBOutlet var Year: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
