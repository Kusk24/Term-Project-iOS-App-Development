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
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CarViewModel.shared.getCarList().prefix(10).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let i = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellOne", for: indexPath ) as! CollectionCellOne
        
        let id = CarViewModel.shared.getCarList()[i].id
        cell.Brand.text = String(CarViewModel.shared.getCarBrand(id: id) ?? "")
        cell.Model.text = CarViewModel.shared.getCarModel(id: id) ?? ""
        cell.Price.text = "$" + (CarViewModel.shared.getCarPrice(id: id) ?? "")
        cell.Year.text = String(CarViewModel.shared.getCarYear(id: id) ?? "")
        checkFavorite(myButton: cell.FavoriteButton, id: id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "")
        cell.Myimage.sd_setImage(with: URL(string: CarViewModel.shared.getCarImage(id: id)!))
        cell.FavoriteButton.tag = indexPath.item
        cell.FavoriteButton.addTarget(self, action: #selector(FavoriteButtonTapped(_:)), for: .touchUpInside)
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = self.findViewController() {
            let Detail = viewController.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailPage
            let i = indexPath.row
            let id = CarViewModel.shared.getCarList()[i].id
            Detail.mycar = CarViewModel.shared.getCar(at: id)
            viewController.navigationController?.pushViewController(Detail, animated: true)
        }
    }
    
    @objc func FavoriteButtonTapped(_ sender: UIButton) {
        let carIndex = sender.tag
        let car = CarViewModel.shared.getCarList()[carIndex]
        
        // Toggle the favorite status
        if FavoriteViewModel.shared.isFavorite(id: car.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "") {
            FavoriteViewModel.shared.removeFavorite(id: car.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "")
        } else {
            FavoriteViewModel.shared.addFavorite(id: car.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "")
        }
        
        // Update the button's appearance
        checkFavorite(myButton: sender, id: car.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "")
        
        // Reload the collection view data (optional: only reload affected item)
        collectionView.reloadItems(at: [IndexPath(item: carIndex, section: 0)])
    }
    
}
