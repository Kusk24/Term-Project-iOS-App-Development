//
//  BookingCell.swift
//  Term Project
//
//  Created by Win Yu Maung on 27/09/2024.
//

import UIKit

class BookingCell: UITableViewCell {

    @IBOutlet weak var Myimages: UIImageView!
    @IBOutlet weak var Brand: UILabel!
    @IBOutlet weak var BookingDays: UILabel!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var ShopButton: UIButton!
    @IBOutlet weak var TotalCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
