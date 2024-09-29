//
//  SearchPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 01/09/2024.
//

import UIKit

class SearchPage: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // Data sources
    var filteredCars: [Car] = []  // Filtered data source for search results
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self

        // Initially show all cars
        filteredCars = CarViewModel.shared.getCarList()
        
        // Debugging: Print initial cars
//        print("Initial cars array: \(CarViewModel.shared.getCarList())")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    // Number of rows based on the filtered data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCars.count
    }
    
    // Configure the table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexPathRow = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "Search") as! SearchTableCell
        
        // Get the car from the filteredCars array
        let id = filteredCars[indexPathRow].id
        
        // Configure the cell with car data
        cell.Brand.text = String(CarViewModel.shared.getCarBrand(id: id) ?? "")
        cell.Model.text = CarViewModel.shared.getCarModel(id: id) ?? ""
        cell.Year.text = String(CarViewModel.shared.getCarYear(id: id) ?? "")
        cell.Price.text = "$" + (String(CarViewModel.shared.getCarPrice(id: id) ?? ""))
        cell.Myimage.sd_setImage(with: URL(string: CarViewModel.shared.getCarImage(id: id) ?? ""))

        
        // Check the favorite status
        checkFavorite(myButton: cell.FavoriteButton, id: id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "")
        cell.FavoriteButton.tag = indexPath.item
        cell.FavoriteButton.addTarget(self, action: #selector(FavoriteButtonTapped(_:)), for: .touchUpInside)
        cell.Myimage.layer.cornerRadius = 10 // Adjust as needed
        cell.Myimage.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row
        let Detail = storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailPage
        Detail.mycar = filteredCars[i]
        navigationController?.pushViewController(Detail, animated: true)
    }
    
    // Search functionality when user types in search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // Show all cars if search text is empty
            filteredCars = CarViewModel.shared.getCarList()
        } else {
            // Filter cars based on brand or model
            filteredCars = CarViewModel.shared.getCarList().filter { car in
                car.brand.lowercased().contains(searchText.lowercased()) ||
                car.model.lowercased().contains(searchText.lowercased())
            }
        }
        
        // Debugging: Print filtered cars array
        print("Filtered cars: \(filteredCars)")
        
        // Reload the table view with filtered data
        tableView.reloadData()
    }
    
    // MARK: - Favorite Button Handling
    
    @objc func FavoriteButtonTapped(_ sender: UIButton) {
        let carIndex = sender.tag
        let car = filteredCars[carIndex]
        
        // Toggle the favorite status
        if FavoriteViewModel.shared.isFavorite(id: car.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "") {
            FavoriteViewModel.shared.removeFavorite(id: car.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "")
        } else {
            FavoriteViewModel.shared.addFavorite(id: car.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "")
        }
        
        // Update the favorite button's appearance
        checkFavorite(myButton: sender, id: car.id, username: CurrentUserViewModel.shared.loadCurrentUser().username ?? "")
        
        // Reload the specific row to reflect the favorite status change
        tableView.reloadRows(at: [IndexPath(row: carIndex, section: 0)], with: .automatic)
    }
}
