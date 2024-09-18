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
        filteredCars = cars
        
        // Debugging: Print initial cars
        print("Initial cars array: \(cars)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if SearchHome == true {
            SearchHome = false
        }
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
        let car = filteredCars[indexPathRow]
        
        // Configure the cell with car data
        cell.Brand.text = car.brand
        cell.Price.text = String(car.price)
        cell.Model.text = car.model
        cell.Year.text = String(car.year)
        
        // Check the favorite status
        checkFavorite(myButton: cell.FavoriteButton, mycar: car)
        cell.FavoriteButton.tag = indexPath.item
        cell.FavoriteButton.addTarget(self, action: #selector(FavoriteButtonTapped(_:)), for: .touchUpInside)
        
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
            filteredCars = cars
        } else {
            // Filter cars based on brand or model
            filteredCars = cars.filter { car in
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
        if isFavorite(car: car) {
            removeFavorite(mycar: car)
        } else {
            addFavorite(mycar: car)
        }
        
        // Update the favorite button's appearance
        checkFavorite(myButton: sender, mycar: car)
        
        // Reload the specific row to reflect the favorite status change
        tableView.reloadRows(at: [IndexPath(row: carIndex, section: 0)], with: .automatic)
    }
}
