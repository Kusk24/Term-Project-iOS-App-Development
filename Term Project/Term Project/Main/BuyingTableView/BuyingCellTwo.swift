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
        let reverseIndex = CarViewModel.shared.getCarList().count - 1 - indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellTwo", for: indexPath) as! CollectionCellTwo
                
        let id = CarViewModel.shared.getCarList()[reverseIndex].id
        cell.Brand.text = CarViewModel.shared.getCarBrand(id: id) ?? ""
        cell.Model.text = CarViewModel.shared.getCarModel(id: id) ?? ""
        cell.Price.text = "$" + (String(CarViewModel.shared.getCarPrice(id: id) ?? ""))
        cell.Year.text = String(CarViewModel.shared.getCarYear(id: id) ?? "")
        cell.Myimage.sd_setImage(with: URL(string: CarViewModel.shared.getCarImage(id: id) ?? ""))
                
        FavoriteViewModel.shared.checkFavorite(myButton: cell.FavoriteButton, id: id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "")
        cell.FavoriteButton.tag = reverseIndex
        cell.FavoriteButton.addTarget(self, action: #selector(FavoriteButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = self.findViewController() {
            let Detail = viewController.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailPage
            let reverseIndex = CarViewModel.shared.getCarList().count - 1 - indexPath.item
            let id = CarViewModel.shared.getCarList()[reverseIndex].id
            Detail.mycar = CarViewModel.shared.getCar(at: id)
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
        let car = CarViewModel.shared.getCarList()[carIndex]

        // Toggle the favorite status
        if FavoriteViewModel.shared.isFavorite(id: car.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "") {
            FavoriteViewModel.shared.removeFavorite(id: car.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "")
        } else {
            FavoriteViewModel.shared.addFavorite(id: car.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "")
        }
        
        // Update the button's appearance
        FavoriteViewModel.shared.checkFavorite(myButton: sender, id: car.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "")
        
        // Reload the collection view data (optional: only reload affected item)
        collectionView.reloadItems(at: [IndexPath(item: carIndex, section: 0)])
    }
    
}
