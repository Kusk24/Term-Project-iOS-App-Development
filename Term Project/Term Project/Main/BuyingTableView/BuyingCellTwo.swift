//
//  BuyingCellTwo.swift
//  Term Project
//
//  Created by Win Yu Maung on 31/08/2024.
//

import UIKit

class BuyingCellTwo: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let IndexPath = [cars.count-1, cars.count-2, cars.count-3, cars.count-4, cars.count-5]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellTwo", for: indexPath) as! CollectionCellTwo
        
        cell.Brand.text = cars[IndexPath[indexPath.item]].brand
        cell.Model.text = cars[IndexPath[indexPath.item]].model
        cell.Price.text = String(cars[IndexPath[indexPath.item]].price)
        cell.Year.text = String(cars[IndexPath[indexPath.item]].year)
        //cell.Myimage.image = cars[IndexPath[indexPath.item]].image
        
        return cell
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    var Detail: UIViewController!
    
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
