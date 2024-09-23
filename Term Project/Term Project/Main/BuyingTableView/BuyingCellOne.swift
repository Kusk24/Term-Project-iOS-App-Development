//
//  BuyingCellOne.swift
//  Term Project
//
//  Created by Win Yu Maung on 31/08/2024.
//

import UIKit
import SDWebImageSwiftUI

class BuyingCellOne: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let i = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellOne", for: indexPath ) as! CollectionCellOne
        
        
        cell.Brand.text = String(CarViewModel.shared.getCarBrand(id: cars[i].id) ?? "")
        cell.Model.text = CarViewModel.shared.getCarModel(id: cars[i].id) ?? ""
        cell.Price.text = "$" + (CarViewModel.shared.getCarPrice(id: cars[i].id) ?? "")
        cell.Year.text = String(CarViewModel.shared.getCarYear(id: cars[i].id) ?? "")
        checkFavorite(myButton: cell.FavoriteButton, id: cars[i].id)
        cell.Myimage.sd_setImage(with: URL(string: CarViewModel.shared.getCarImage(id: cars[i].id)!))
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
    
    @objc func FavoriteButtonTapped(_ sender: UIButton) {
        let carIndex = sender.tag
        let car = cars[carIndex]
        
        // Toggle the favorite status
        if isFavorite(id: car.id) {
            removeFavorite(id: car.id)
        } else {
            addFavorite(id: car.id)
        }
        
        // Update the button's appearance
        checkFavorite(myButton: sender, id: car.id)
        
        // Reload the collection view data (optional: only reload affected item)
        collectionView.reloadItems(at: [IndexPath(item: carIndex, section: 0)])
    }
    
}
