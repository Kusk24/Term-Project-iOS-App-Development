//
//  SearchPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 01/09/2024.
//

import UIKit

class SearchPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let IndexPath = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "Search") as! SearchTableCell
        
//        cell.Myimage.image =
        cell.Brand.text = cars[IndexPath].brand
        cell.Price.text = String(cars[IndexPath].price)
        cell.Model.text = cars[IndexPath].model
        cell.Year.text = String(cars[IndexPath].year)
        checkFavorite(myButton: cell.FavoriteButton, mycar: cars[IndexPath])
        cell.FavoriteButton.tag = indexPath.item
        cell.FavoriteButton.addTarget(self, action: #selector(FavoriteButtonTapped(_:)), for: .touchUpInside)
        return cell
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
        tableView.reloadData()
        // Reload the collection view data (optional: only reload affected item)
        tableView.reloadRows(at: [IndexPath(row: carIndex, section: 0)], with: .automatic)
    }

}
