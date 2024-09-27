//
//  BuyingCellThree.swift
//  Term Project
//
//  Created by Win Yu Maung on 31/08/2024.
//

import UIKit

class BuyingCellThree: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellThree", for: indexPath) as! CollectionCellThree
        let i = indexPath.row
        cell.TypeName.text = carTypes[i]
        cell.Myimage.image = UIImage(named: carTypes[i])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = self.findViewController() {
            let CarType = viewController.storyboard?.instantiateViewController(withIdentifier: "CarType") as! CarTypePage
            let i = indexPath.row
            CarType.cartype = carTypes[i]
            
            viewController.navigationController?.pushViewController(CarType, animated: true)
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    let carTypes = [
        "Sedan",
        "SUV",
        "Hatchback",
        "Coupe",
        "Pickup",
        "Minivan",
    ]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
