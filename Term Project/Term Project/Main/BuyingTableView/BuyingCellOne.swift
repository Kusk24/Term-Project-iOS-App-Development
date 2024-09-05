//
//  BuyingCellOne.swift
//  Term Project
//
//  Created by Win Yu Maung on 31/08/2024.
//

import UIKit

class BuyingCellOne: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let IndexPath = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellOne", for: indexPath ) as! CollectionCellOne
        
        
        cell.Brand.text = cars[IndexPath].brand
        cell.Model.text = cars[IndexPath].model
        cell.Price.text = String(cars[IndexPath].price)
        cell.Year.text = String(cars[IndexPath].year)
        checkFavorite(myButton: cell.FavoriteButton, mycar: cars[IndexPath])
        cell.FavoriteButton.tag = indexPath.item
        cell.FavoriteButton.addTarget(self, action: #selector(FavoriteButtonTapped(_:)), for: .touchUpInside)
        
        //cell.Myimage.image = cars[IndexPath].image
        
        
            // Configure border and corner radius
//            cell.contentView.layer.borderColor = UIColor.black.cgColor
//            cell.contentView.layer.borderWidth = 2.0
//            cell.contentView.layer.cornerRadius = 8.0
            
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
        
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOpacity = 0.3
//        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        contentView.layer.shadowRadius = 4
//
//        // Ensure the shadow is applied correctly
//        contentView.layer.masksToBounds = false
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
