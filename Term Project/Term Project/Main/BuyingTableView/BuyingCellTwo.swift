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
        let reverseIndex = cars.count - 1 - indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellTwo", for: indexPath) as! CollectionCellTwo
                
        let car = cars[reverseIndex]
        cell.Brand.text = car.brand
        cell.Model.text = car.model
        cell.Price.text = String(car.price)
        cell.Year.text = String(car.year)
        // cell.Myimage.image = car.image
                
        checkFavorite(myButton: cell.FavoriteButton, mycar: car)
        cell.FavoriteButton.tag = reverseIndex
        cell.FavoriteButton.addTarget(self, action: #selector(FavoriteButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = self.findViewController() {
            let Detail = viewController.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailPage
            viewController.navigationController?.pushViewController(Detail, animated: true)
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
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

    @objc func FavoriteButtonTapped(_ sender: UIButton) {
        let carIndex = sender.tag
        let car = cars[carIndex]

        // Toggle the favorite status
        if isFavorite(car: car) {
            removeFavorite(mycar: car)
        } else {
            addFavorite(mycar: car)
        }
        
        // Update the button's appearance
        checkFavorite(myButton: sender, mycar: car)
        
        // Reload the collection view data (optional: only reload affected item)
        collectionView.reloadItems(at: [IndexPath(item: carIndex, section: 0)])
    }
    
}
